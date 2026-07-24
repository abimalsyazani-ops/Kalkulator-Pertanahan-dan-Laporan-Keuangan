create table if not exists public.app_user_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.app_user_state enable row level security;

create or replace function public.set_app_user_state_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists set_app_user_state_updated_at on public.app_user_state;
create trigger set_app_user_state_updated_at
before update on public.app_user_state
for each row
execute function public.set_app_user_state_updated_at();

drop policy if exists "app_user_state_select_own" on public.app_user_state;
create policy "app_user_state_select_own"
on public.app_user_state
for select
to authenticated
using ((select auth.uid()) = user_id);

drop policy if exists "app_user_state_insert_own" on public.app_user_state;
create policy "app_user_state_insert_own"
on public.app_user_state
for insert
to authenticated
with check ((select auth.uid()) = user_id);

drop policy if exists "app_user_state_update_own" on public.app_user_state;
create policy "app_user_state_update_own"
on public.app_user_state
for update
to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);

drop policy if exists "app_user_state_delete_own" on public.app_user_state;
create policy "app_user_state_delete_own"
on public.app_user_state
for delete
to authenticated
using ((select auth.uid()) = user_id);

grant usage on schema public to anon, authenticated;
grant select, insert, update, delete on public.app_user_state to authenticated;
revoke all on public.app_user_state from anon;
