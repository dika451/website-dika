# Jurnal SI Web dan Mobile

Situs materi dan tugas kuliah Sistem Informasi Berbasis Web/Mobile. Satu halaman HTML, tanpa proses build.

## Isi folder

| Berkas | Fungsi |
| --- | --- |
| `index.html` | Seluruh situs (tampilan, materi, dan logika tugas) |
| `config.js` | Alamat dan kunci Supabase. Kosong = tugas disimpan di browser saja |
| `supabase.sql` | Skema tabel, bucket berkas, dan aturan akses untuk database |

## Menjalankan di VS Code

1. Buka folder ini di VS Code (File > Open Folder).
2. Pasang ekstensi **Live Server**, klik kanan `index.html`, pilih **Open with Live Server**.
3. Alternatif tanpa ekstensi: di terminal VS Code jalankan `python -m http.server 5500`, lalu buka `http://localhost:5500`.

Tanpa mengisi `config.js`, situs sudah berjalan dan tugas tersimpan di browser (tidak ikut ke perangkat lain).

## Mengaktifkan database Supabase

1. Buat akun dan proyek baru di https://supabase.com (paket gratis cukup).
2. Buka **SQL Editor**, tempel isi `supabase.sql`, ganti `EMAIL_PEMILIK@contoh.com` dengan email Anda, lalu klik **Run**.
3. Buka **Authentication > Users > Add user**, buat akun dengan email yang sama dan kata sandi pilihan Anda, lalu centang konfirmasi otomatis.
4. Di pengaturan Authentication, matikan pendaftaran pengguna baru (opsi untuk mengizinkan sign up) agar tidak ada orang lain yang bisa membuat akun.
5. Buka **Project Settings > API**, salin **Project URL** dan kunci **anon** (atau **publishable**) ke `config.js`.
6. Muat ulang situs. Di tab Tugas klik **Masuk pemilik**, masuk dengan email dan kata sandi tadi, lalu tambah tugas dan unggah berkas.

Catatan keamanan: kunci anon memang boleh terlihat di kode situs karena hak ubah dijaga oleh aturan akses di database. Jangan pernah menaruh kunci `service_role` di `config.js`.

## Mengganti isi materi

Buka `index.html`, cari `const DATA` di bagian `<script>`, lalu ubah daftar `materi`. Daftar tugas dikelola langsung dari tab Tugas.

## Publikasi

Unggah ketiga berkas ke GitHub Pages atau Netlify. Karena tugas tersimpan di Supabase, data yang sama tampil di semua perangkat.
