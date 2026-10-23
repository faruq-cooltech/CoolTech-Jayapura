-- Jalankan seluruh SQL ini di Supabase Dashboard > SQL Editor > New query.
-- Buat akun admin terlebih dahulu di Authentication > Users > Add user.
create extension if not exists pgcrypto;
create table if not exists public.customers (
  id uuid primary key default gen_random_uuid(), owner_id uuid not null references auth.users(id) on delete cascade,
  name text not null, phone text default '', address text default '', notes text default '', created_at timestamptz not null default now()
);
create table if not exists public.orders (
  id uuid primary key default gen_random_uuid(), owner_id uuid not null references auth.users(id) on delete cascade,
  customer_id uuid not null references public.customers(id) on delete restrict,
  service_date date not null default current_date, service_type text not null, description text default '',
  qty integer not null default 1 check (qty > 0), total numeric(14,2) not null default 0 check (total >= 0),
  status text not null default 'Baru' check (status in ('Baru','Dikerjakan','Selesai','Dibatalkan')),
  notes text default '', created_at timestamptz not null default now()
);
create table if not exists public.transactions (
  id uuid primary key default gen_random_uuid(), owner_id uuid not null references auth.users(id) on delete cascade,
  date date not null default current_date, kind text not null check (kind in ('income','expense')),
  description text not null, amount numeric(14,2) not null check (amount > 0), created_at timestamptz not null default now()
);
create index if not exists customers_owner_name_idx on public.customers(owner_id, name);
create index if not exists orders_owner_date_idx on public.orders(owner_id, service_date desc);
create index if not exists transactions_owner_date_idx on public.transactions(owner_id, date desc);
alter table public.customers enable row level security;
alter table public.orders enable row level security;
alter table public.transactions enable row level security;
drop policy if exists "owner manages customers" on public.customers;
create policy "owner manages customers" on public.customers for all to authenticated using (auth.uid() = owner_id) with check (auth.uid() = owner_id);
drop policy if exists "owner manages orders" on public.orders;
create policy "owner manages orders" on public.orders for all to authenticated using (auth.uid() = owner_id) with check (auth.uid() = owner_id);
drop policy if exists "owner manages transactions" on public.transactions;
create policy "owner manages transactions" on public.transactions for all to authenticated using (auth.uid() = owner_id) with check (auth.uid() = owner_id);
