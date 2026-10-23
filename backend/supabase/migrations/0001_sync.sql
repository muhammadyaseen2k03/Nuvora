-- Nuvora cloud sync schema.
--
-- One generic table holds every synced row as JSON, keyed by
-- (user_id, table_name, row_id). Isolation between accounts is enforced HERE,
-- by row-level security, not by the app: even a modified client can only ever
-- see and change rows where user_id = auth.uid().
--
-- Apply with the Supabase CLI (`supabase db push`) or paste into the SQL
-- editor. This file has not been run against a live project by the author of
-- this repository; see README "Cloud setup" for the verification checklist.

create sequence if not exists public.sync_records_seq;

create table if not exists public.sync_records (
  user_id    uuid        not null default auth.uid()
                         references auth.users (id) on delete cascade,
  table_name text        not null,
  row_id     text        not null,
  data       jsonb,
  deleted    boolean     not null default false,
  -- Client-side change time; used for last-writer-wins conflict resolution.
  updated_at timestamptz not null,
  -- Server-assigned, increases on every accepted write; clients pull by it,
  -- so device clock skew cannot cause missed changes.
  seq        bigint      not null default nextval('public.sync_records_seq'),
  primary key (user_id, table_name, row_id),

  -- Only these tables may be synced.
  constraint sync_records_table_allowed check (table_name in (
    'user_preferences', 'prayer_settings', 'prayer_records', 'subjects',
    'syllabus_topics', 'exams', 'study_sessions', 'flashcards',
    'flashcard_reviews', 'water_logs', 'fasting_sessions', 'workout_sessions',
    'journal_entries', 'achievement_awards', 'daily_plans',
    'planned_activities'
  )),
  constraint sync_records_row_id_len check (char_length(row_id) between 1 and 64),
  -- Bound the size of one row so a client cannot store arbitrary blobs.
  constraint sync_records_data_size check (data is null or pg_column_size(data) <= 65536),
  constraint sync_records_deleted_has_no_data check (not deleted or data is null)
);

create index if not exists sync_records_user_seq_idx
  on public.sync_records (user_id, seq);

-- Bump seq on every update so other devices see the change.
create or replace function public.sync_records_touch_seq()
returns trigger language plpgsql as $$
begin
  new.seq := nextval('public.sync_records_seq');
  return new;
end $$;

drop trigger if exists sync_records_touch_seq on public.sync_records;
create trigger sync_records_touch_seq
  before update on public.sync_records
  for each row execute function public.sync_records_touch_seq();

-- Row-level security: the heart of account isolation.
alter table public.sync_records enable row level security;
alter table public.sync_records force row level security;

drop policy if exists sync_records_select_own on public.sync_records;
create policy sync_records_select_own on public.sync_records
  for select to authenticated using (user_id = auth.uid());

drop policy if exists sync_records_insert_own on public.sync_records;
create policy sync_records_insert_own on public.sync_records
  for insert to authenticated with check (user_id = auth.uid());

drop policy if exists sync_records_update_own on public.sync_records;
create policy sync_records_update_own on public.sync_records
  for update to authenticated
  using (user_id = auth.uid()) with check (user_id = auth.uid());

drop policy if exists sync_records_delete_own on public.sync_records;
create policy sync_records_delete_own on public.sync_records
  for delete to authenticated using (user_id = auth.uid());

-- Anonymous (not signed-in) requests get nothing.
revoke all on public.sync_records from anon;
grant select, insert, update, delete on public.sync_records to authenticated;

-- Idempotent upsert that never lets an older record replace a newer one.
-- SECURITY INVOKER: runs with the caller's rights, so RLS still applies.
create or replace function public.push_sync_records(records jsonb)
returns void
language plpgsql
security invoker
set search_path = public
as $$
declare
  r jsonb;
begin
  if auth.uid() is null then
    raise exception 'not authenticated' using errcode = '28000';
  end if;
  if jsonb_typeof(records) <> 'array' or jsonb_array_length(records) > 500 then
    raise exception 'records must be an array of at most 500 items';
  end if;

  for r in select * from jsonb_array_elements(records) loop
    insert into public.sync_records
      (user_id, table_name, row_id, data, deleted, updated_at)
    values (
      auth.uid(),
      r ->> 'table_name',
      r ->> 'row_id',
      case when coalesce((r ->> 'deleted')::boolean, false) then null else r -> 'data' end,
      coalesce((r ->> 'deleted')::boolean, false),
      (r ->> 'updated_at')::timestamptz
    )
    on conflict (user_id, table_name, row_id) do update
      set data = excluded.data,
          deleted = excluded.deleted,
          updated_at = excluded.updated_at
      where public.sync_records.updated_at <= excluded.updated_at;
  end loop;
end $$;

revoke all on function public.push_sync_records(jsonb) from public, anon;
grant execute on function public.push_sync_records(jsonb) to authenticated;
