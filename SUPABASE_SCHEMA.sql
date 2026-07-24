create table if not exists public.app_user_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

create schema if not exists private;

create table if not exists public.app_profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  email text not null default '',
  role text not null default 'user' check (role in ('user', 'admin')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.app_user_state enable row level security;
alter table public.app_profiles enable row level security;

create or replace function private.is_app_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select (select auth.uid()) is not null
    and exists (
      select 1
      from public.app_profiles
      where user_id = (select auth.uid())
        and role = 'admin'
    );
$$;

revoke all on function private.is_app_admin() from public;
grant usage on schema private to authenticated;
grant execute on function private.is_app_admin() to authenticated;

create or replace function public.set_app_user_state_updated_at()
returns trigger
language plpgsql
set search_path = public
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

create or replace function public.set_app_profiles_updated_at()
returns trigger
language plpgsql
set search_path = public
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists set_app_profiles_updated_at on public.app_profiles;
create trigger set_app_profiles_updated_at
before update on public.app_profiles
for each row
execute function public.set_app_profiles_updated_at();

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

drop policy if exists "app_user_state_select_admin" on public.app_user_state;
create policy "app_user_state_select_admin"
on public.app_user_state
for select
to authenticated
using (private.is_app_admin());

drop policy if exists "app_profiles_select_own_or_admin" on public.app_profiles;
create policy "app_profiles_select_own_or_admin"
on public.app_profiles
for select
to authenticated
using ((select auth.uid()) = user_id or private.is_app_admin());

drop policy if exists "app_profiles_insert_own_user" on public.app_profiles;
create policy "app_profiles_insert_own_user"
on public.app_profiles
for insert
to authenticated
with check ((select auth.uid()) = user_id and role = 'user');

drop policy if exists "app_profiles_update_own_user" on public.app_profiles;
create policy "app_profiles_update_own_user"
on public.app_profiles
for update
to authenticated
using ((select auth.uid()) = user_id and role = 'user')
with check ((select auth.uid()) = user_id and role = 'user');

drop policy if exists "app_profiles_update_admin" on public.app_profiles;
create policy "app_profiles_update_admin"
on public.app_profiles
for update
to authenticated
using (private.is_app_admin())
with check (private.is_app_admin());

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
  'payment-proofs',
  'payment-proofs',
  false,
  10485760,
  array['image/jpeg', 'image/png', 'image/webp', 'image/gif', 'application/pdf']
)
on conflict (id) do update
set public = false,
    file_size_limit = excluded.file_size_limit,
    allowed_mime_types = excluded.allowed_mime_types;

drop policy if exists "payment_proofs_select_own_or_admin" on storage.objects;
create policy "payment_proofs_select_own_or_admin"
on storage.objects
for select
to authenticated
using (
  bucket_id = 'payment-proofs'
  and (((storage.foldername(name))[1] = (select auth.uid())::text) or private.is_app_admin())
);

drop policy if exists "payment_proofs_insert_own" on storage.objects;
create policy "payment_proofs_insert_own"
on storage.objects
for insert
to authenticated
with check (
  bucket_id = 'payment-proofs'
  and (storage.foldername(name))[1] = (select auth.uid())::text
);

drop policy if exists "payment_proofs_update_own" on storage.objects;
create policy "payment_proofs_update_own"
on storage.objects
for update
to authenticated
using (
  bucket_id = 'payment-proofs'
  and (storage.foldername(name))[1] = (select auth.uid())::text
)
with check (
  bucket_id = 'payment-proofs'
  and (storage.foldername(name))[1] = (select auth.uid())::text
);

drop policy if exists "payment_proofs_delete_own" on storage.objects;
create policy "payment_proofs_delete_own"
on storage.objects
for delete
to authenticated
using (
  bucket_id = 'payment-proofs'
  and (storage.foldername(name))[1] = (select auth.uid())::text
);

grant usage on schema public to anon, authenticated;
grant select, insert, update, delete on public.app_user_state to authenticated;
grant select, insert, update on public.app_profiles to authenticated;
revoke all on public.app_user_state from anon;
revoke all on public.app_profiles from anon;

-- Setelah akun admin dibuat dan pernah login sekali, promosikan dari Supabase SQL Editor:
-- update public.app_profiles set role = 'admin' where email = 'email-admin@contoh.com';
