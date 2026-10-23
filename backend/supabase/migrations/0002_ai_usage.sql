-- Daily AI usage counters, used by the `ai` edge function to enforce quotas.
-- Only the function (service role) increments them; users may read their own.

create table if not exists public.ai_usage (
  user_id uuid not null references auth.users (id) on delete cascade,
  day     date not null,
  count   integer not null default 0 check (count >= 0),
  primary key (user_id, day)
);

alter table public.ai_usage enable row level security;
alter table public.ai_usage force row level security;

drop policy if exists ai_usage_select_own on public.ai_usage;
create policy ai_usage_select_own on public.ai_usage
  for select to authenticated using (user_id = auth.uid());

-- No insert/update/delete policies: clients cannot change their own counters.
revoke all on public.ai_usage from anon, authenticated;
grant select on public.ai_usage to authenticated;

-- Atomically increments today's counter and returns the new value. Callable
-- only by the service role (the edge function).
create or replace function public.increment_ai_usage(p_user uuid)
returns integer
language sql
security definer
set search_path = public
as $$
  insert into public.ai_usage (user_id, day, count)
  values (p_user, (now() at time zone 'utc')::date, 1)
  on conflict (user_id, day) do update set count = public.ai_usage.count + 1
  returning count;
$$;

revoke all on function public.increment_ai_usage(uuid) from public, anon, authenticated;
grant execute on function public.increment_ai_usage(uuid) to service_role;
