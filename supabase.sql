-- Aman dijalankan berulang di Supabase: SQL Editor > New query > tempel > Run.
-- Ganti EMAIL_PEMILIK@contoh.com dengan EMAIL LENGKAP akun pemilik (4 tempat).
-- Email harus persis sama dengan email pengguna di Authentication > Users, lengkap dengan @ dan domainnya.

-- 1. Tabel tugas
create table if not exists public.tugas (
  id uuid primary key default gen_random_uuid(),
  kode text,
  judul text not null,
  deskripsi text default '',
  tenggat date,
  status text not null default 'belum'
    check (status in ('belum', 'dikerjakan', 'dikumpulkan', 'dinilai')),
  pertemuan text default '',
  tautan text default '',
  berkas jsonb not null default '[]'::jsonb,
  dibuat timestamptz not null default now()
);

-- 2. Aturan akses: semua orang boleh membaca, hanya pemilik yang boleh mengubah
alter table public.tugas enable row level security;

drop policy if exists "tugas_baca_publik" on public.tugas;
create policy "tugas_baca_publik" on public.tugas
  for select using (true);

drop policy if exists "tugas_tulis_pemilik" on public.tugas;
create policy "tugas_tulis_pemilik" on public.tugas
  for all
  using ((auth.jwt() ->> 'email') = 'dikaaryasaputra865@gmail.com')
  with check ((auth.jwt() ->> 'email') = 'dikaaryasaputra865@gmail.com');

-- 3. Penyimpanan berkas (bucket publik untuk dibaca, hanya pemilik yang boleh unggah dan hapus)
insert into storage.buckets (id, name, public)
values ('berkas', 'berkas', true)
on conflict (id) do nothing;

drop policy if exists "berkas_unggah_pemilik" on storage.objects;
create policy "berkas_unggah_pemilik" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'berkas' and (auth.jwt() ->> 'email') = 'dikaaryasaputra865@gmail.com');

drop policy if exists "berkas_hapus_pemilik" on storage.objects;
create policy "berkas_hapus_pemilik" on storage.objects
  for delete to authenticated
  using (bucket_id = 'berkas' and (auth.jwt() ->> 'email') = 'dikaaryasaputra865@gmail.com');