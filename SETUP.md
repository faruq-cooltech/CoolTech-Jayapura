# COOLTECH JAYAPURA — panduan pemasangan (tanpa coding manual)

## Apa yang tersedia
- Dashboard ringkasan pemasukan, pengeluaran, laba/selisih dan order hari ini.
- CRUD pelanggan dan orderan, pencatatan transaksi pemasukan/pengeluaran.
- Laporan bulanan dan ekspor transaksi CSV.
- Login admin menggunakan Supabase Auth.
- Database dilindungi Row Level Security (RLS).

## Langkah 1 — Buat database Supabase
1. Buka https://supabase.com/dashboard dan buat proyek baru.
2. Simpan password database di tempat aman. Jangan kirim ke chat.
3. Buka **SQL Editor** → **New query**.
4. Buka file `supabase.sql`, salin seluruh isinya, tempel di SQL Editor, lalu tekan **Run**.
5. Buka **Authentication → Users → Add user**. Buat email dan password admin. Jika ada opsi konfirmasi email, pilih sesuai kebutuhanmu.
6. Buka **Project Settings → API** (atau **Connect**). Salin **Project URL** dan **publishable key** / **anon public key**. Jangan pernah menggunakan `service_role` key.

## Langkah 2 — Isi konfigurasi
1. Ubah nama `config.js.example` menjadi `config.js`.
2. Buka `config.js` dan ganti nilai `url` serta `anonKey` dengan data dari Supabase.
3. Simpan file. Pastikan `index.html` dan `config.js` berada di folder yang sama.

## Langkah 3 — Upload ke GitHub
1. Buat repository baru di https://github.com/new. Nama contoh: `cooltech-jayapura`.
2. Pilih **Public** atau **Private** sesuai preferensi. Ingat: `config.js` berisi publishable/anon key yang memang boleh berada di browser, tetapi jangan masukkan service-role key atau password.
3. Pilih **Add file → Upload files**, lalu unggah `index.html`, `config.js`, dan file lain yang diperlukan (misalnya README/SQL). Tekan **Commit changes**.

## Langkah 4 — Terbitkan melalui Cloudflare Pages
1. Buka https://dash.cloudflare.com/ → **Workers & Pages** → **Create** → **Pages** → **Connect to Git**.
2. Hubungkan GitHub dan pilih repository `cooltech-jayapura`.
3. Untuk aplikasi HTML statis ini, gunakan framework preset **None**. Build command kosong; output/build directory ` / ` (root folder; bila UI meminta folder, isi `.`).
4. Klik **Save and Deploy**. Setelah selesai, Cloudflare memberi alamat `*.pages.dev`.

## Langkah 5 — Uji
1. Buka alamat `pages.dev`.
2. Login dengan akun admin Supabase.
3. Tambah pelanggan, lalu buat order, lalu masukkan transaksi uji. Pastikan data tersimpan setelah halaman dimuat ulang.
4. Jangan gunakan data pelanggan nyata sampai login, RLS, dan alur backup telah diuji.

## Penting
- Ini starter internal; belum ada invoice PDF, nomor invoice otomatis, pengingat WhatsApp, galeri, multi-teknisi, atau booking publik.
- Transaksi pemasukan/pengeluaran dicatat manual. Order tidak otomatis menjadi pemasukan ketika dibuat.
- RLS membatasi data ke user yang login. Untuk satu pemilik, buat hanya akun admin yang diperlukan dan jangan aktifkan pendaftaran publik.
- Sebelum dipakai untuk pembukuan nyata, uji seluruh fitur dan siapkan ekspor/backup rutin.
- Domain sendiri dapat ditambahkan di Cloudflare Pages → Custom domains setelah website terbit; domain biasanya dibeli terpisah.
