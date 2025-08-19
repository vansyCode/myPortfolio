# Portfolio (Flutter)

Portofolio pribadi berbasis **Flutter** untuk menampilkan profil, keahlian, proyek, dan kontak. Dibangun dengan arsitektur sederhana namun terstruktur: section terpisah, komponen reusable, design system konsisten, serta custom painter untuk background grid. Responsif untuk **web** dan **mobile**.

---

## Daftar Isi
- [Fitur Utama](#fitur-utama)
- [Demo & Tangkapan Layar](#demo--tangkapan-layar)
- [Teknologi & Paket](#teknologi--paket)
- [Struktur Proyek](#struktur-proyek)
- [Konfigurasi Konten & Aset](#konfigurasi-konten--aset)
- [Menjalankan Secara Lokal](#menjalankan-secara-lokal)
- [Build & Deploy](#build--deploy)
- [Form Kontak: Backend](#form-kontak-backend)
- [Kualitas Kode](#kualitas-kode)
- [Roadmap](#roadmap)
- [Lisensi](#lisensi)
- [Kontak](#kontak)

---

## Fitur Utama
- **Responsif** untuk desktop, tablet, dan ponsel.
- Section: **Home**, **About**, **Portfolio/Projects**, **Contact**, **Footer**.
- **Custom grid background** via `CustomPainter` untuk nuansa techy yang halus.
- **Komponen reusable** (Card, SkillChip, ContactCard, dsb) agar konsisten dan hemat duplikasi.
- **Design system**: warna, spacing, radius, font size, durasi animasi, disentralisasi di `AppConstants`.
- **Form kontak** terhubung ke backend sederhana via `HTTP POST`.

---

## Demo & Tangkapan Layar
Tambahkan tangkapan layar ke folder `screenshots/`, lalu perbarui tautan di bawah.

| Home | Projects | Contact |
|------|----------|---------|
| ![Home](screenshots/home.png) | ![Projects](screenshots/projects.png) | ![Contact](screenshots/contact.png) |

---

## Teknologi & Paket
- **Flutter** 3.x • **Dart** 3.x
- Paket yang digunakan di kode:
  - `url_launcher` untuk membuka tautan eksternal
  - `http` untuk form kontak (request ke backend)
  - `font_awesome_flutter` untuk ikon
- Tambahkan di `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  url_launcher: ^6.3.0
  http: ^1.2.0
  font_awesome_flutter: ^10.7.0
