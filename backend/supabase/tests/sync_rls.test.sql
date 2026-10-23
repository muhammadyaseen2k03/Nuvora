-- pgTAP tests for the sync schema. Run with `supabase test db`.
-- NOT YET RUN by the repository author: they require a local Supabase stack
-- (Docker). Treat them as the acceptance checklist for account isolation.
begin;
select plan(8);

-- Two users.
insert into auth.users (id, email) values
  ('00000000-0000-0000-0000-0000000000a1', 'a@example.test'),
  ('00000000-0000-0000-0000-0000000000b2', 'b@example.test');

-- Act as user A.
set local role authenticated;
select set_config('request.jwt.claim.sub', '00000000-0000-0000-0000-0000000000a1', true);

select lives_ok(
  $$select public.push_sync_records('[{"table_name":"subjects","row_id":"s1","data":{"name":"Math"},"deleted":false,"updated_at":"2024-05-10T09:00:00Z"}]'::jsonb)$$,
  'user A can push a record');

select is((select count(*)::int from public.sync_records), 1, 'user A sees own row');

-- An older record must not overwrite a newer one.
select public.push_sync_records('[{"table_name":"subjects","row_id":"s1","data":{"name":"Old"},"deleted":false,"updated_at":"2024-05-10T08:00:00Z"}]'::jsonb);
select is((select data ->> 'name' from public.sync_records where row_id = 's1'), 'Math',
  'older record does not overwrite newer data');

-- Disallowed table names are rejected.
select throws_ok(
  $$select public.push_sync_records('[{"table_name":"profiles","row_id":"x","data":{},"deleted":false,"updated_at":"2024-05-10T09:00:00Z"}]'::jsonb)$$,
  '23514', null, 'tables outside the allow-list are rejected');

-- Switch to user B.
select set_config('request.jwt.claim.sub', '00000000-0000-0000-0000-0000000000b2', true);
select is((select count(*)::int from public.sync_records), 0, 'user B cannot see user A rows');

-- B cannot update or delete A's row, even by guessing the key.
update public.sync_records set data = '{"name":"hacked"}' where row_id = 's1';
delete from public.sync_records where row_id = 's1';

-- B cannot insert a row owned by A.
select throws_ok(
  $$insert into public.sync_records (user_id, table_name, row_id, data, updated_at)
    values ('00000000-0000-0000-0000-0000000000a1', 'subjects', 'evil', '{}', now())$$,
  '42501', null, 'user B cannot insert rows for user A');

-- Back to A: the row is intact.
select set_config('request.jwt.claim.sub', '00000000-0000-0000-0000-0000000000a1', true);
select is((select data ->> 'name' from public.sync_records where row_id = 's1'), 'Math',
  'user A data was not modified by user B');

-- Anonymous users have no access at all.
reset role;
set local role anon;
select throws_ok($$select * from public.sync_records$$, '42501', null,
  'anonymous role is denied');

select * from finish();
rollback;
