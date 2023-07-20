# Exopets - Marketplace Hewan Peliharaan Eksotis

Ini adalah proyek aplikasi Flutter mobile yang merupakan marketplace hewan peliharaan. Aplikasi ini memungkinkan pengguna untuk membeli dan menjual hewan peliharaan melalui platform yang aman dan terpercaya.

<img src="https://github.com/ferdifir/ExoPets/blob/main/screenshot/1.jpg" alt="1" width="300" height="534" />
<img src="https://github.com/ferdifir/ExoPets/blob/main/screenshot/2.jpg" alt="2" width="300" height="534" />
<img src="https://github.com/ferdifir/ExoPets/blob/main/screenshot/3.jpg" alt="3" width="300" height="534" />
<img src="https://github.com/ferdifir/ExoPets/blob/main/screenshot/4.jpg" alt="4" width="300" height="534" />
<img src="https://github.com/ferdifir/ExoPets/blob/main/screenshot/5.jpg" alt="5" width="300" height="534" />
<img src="https://github.com/ferdifir/ExoPets/blob/main/screenshot/6.jpg" alt="6" width="300" height="534" />
<img src="https://github.com/ferdifir/ExoPets/blob/main/screenshot/7.jpg" alt="7" width="300" height="534" />

## Fitur Utama
- Role User: Aplikasi ini memiliki tiga peran pengguna utama:
  - Buyer: Pengguna dapat menjelajahi daftar hewan peliharaan yang dijual, melakukan pembelian, dan melacak status pesanan mereka.
  - Seller: Pengguna dapat mendaftar sebagai penjual dan mengunggah informasi hewan peliharaan yang ingin mereka jual, mengelola daftar produk, dan mengelola pesanan dari pembeli.
  - Admin: Pengguna dengan peran admin memiliki akses penuh untuk mengelola pengguna, produk, pesanan, dan menjaga integritas platform.

- Autentikasi dan Otorisasi: Aplikasi ini menggunakan sistem autentikasi dan otorisasi yang aman, di mana pengguna harus login atau mendaftar untuk mengakses fitur-fitur tertentu berdasarkan peran pengguna mereka.

- Pencarian dan Filter: Pengguna dapat melakukan pencarian dan penyaringan berdasarkan jenis hewan, lokasi penjual, harga, dan fitur lainnya untuk menemukan hewan peliharaan yang mereka inginkan dengan mudah.

- Penilaian dan Ulasan: Pengguna dapat memberikan penilaian dan ulasan terhadap penjual dan hewan peliharaan yang telah mereka beli.

## Teknologi yang Digunakan
- Flutter: Kerangka kerja yang digunakan untuk mengembangkan aplikasi mobile cross-platform yang menampilkan antarmuka pengguna yang kaya dan responsif.
- Node.js: Digunakan untuk mengembangkan backend server yang mengelola logika bisnis, basis data, dan komunikasi dengan aplikasi mobile.
- MySQL: Digunakan sebagai sistem manajemen basis data relasional untuk menyimpan data pengguna, produk, dan pesanan.
- Firebase: Digunakan untuk otentikasi pengguna, penyimpanan file, dan pengiriman pemberitahuan push.

## Panduan Penggunaan
1. Clone repository ini dan repository Exopets-Backend ke dalam direktori lokal Anda.
2. Pastikan Anda memiliki Flutter SDK terinstal dan telah dikonfigurasi dengan benar di sistem Anda.
3. Buka proyek dalam editor kode Anda dan jalankan perintah `flutter pub get` untuk mengunduh dan menginstal dependensi proyek.
4. Pastikan Anda telah menginstal Node.js dan MySQL di sistem Anda.
5. Sesuaikan pengaturan koneksi basis data MySQL dalam file `database/db.js` dengan detail koneksi MySQL Anda.
6. Jalankan perintah `npm install` dalam direktori `server` untuk mengunduh dan menginstal dependensi server.
7. Jalankan perintah `npm start` dalam direktori `server` untuk memulai server backend.
8. Sesuaikan pengaturan localhost dengan IPv4 Address komputer Anda dalam file `lib/common/config/config.dart`
9. Jalankan aplikasi dengan perintah `flutter run` di terminal Anda.

Pastikan Anda telah mengatur emulator atau perangkat fisik untuk menjalankan aplikasi Flutter.
