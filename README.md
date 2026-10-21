# 🔴 BrainBlitz - Manchester United Edition (GGMU Quiz)

BrainBlitz MU Edition adalah aplikasi kuis interaktif berbasis *mobile* dengan tema khusus **Manchester United**. Aplikasi ini dirancang untuk menguji pengetahuan *Red Army* seputar sejarah, pemain legendaris, dan momen bersejarah di *The Theatre of Dreams* dengan antarmuka *gamified* yang modern.

## 👨‍💻 Identitas Mahasiswa
- **Nama:** Argha Niqie Wijaksono
- **NIM:** 241401096
- **Mata Kuliah:** Praktikum Pemrograman Mobile
- **Lab:** PM 6

---

## ✨ Fitur Utama
1. **Full Manchester United Theme:** Menggunakan palet warna khas Merah MU & Biru *Away Kit*, tipografi Montserrat, logo kustom HD, serta *wallpaper* Old Trafford di seluruh layar.
2. **Dynamic Shuffled Colors:** Warna tombol pilihan jawaban diacak secara murni tanpa duplikasi pada setiap pertanyaan.
3. **Dynamic Result Feedback:** Pesan apresiasi, ikon animasi, dan skor akhir menyesuaikan tingkat pencapaian pemain (Legend Status, Pemain Inti, atau Balik ke Akademi).
4. **State Management & Safe Navigation:** Ditenagai `Provider` untuk menjaga *state* skor serta `go_router` + `PopScope` untuk mencegah pemain keluar kuis secara tidak sengaja.
5. **Global Dual-Theme:** Fitur *Light Mode* dan *Dark Mode* yang responsif dengan penyesuaian visibilitas ikon tinggi.

---

## 🛠️ Aset & Teknologi
- **Framework:** Flutter & Dart
- **State Management:** Provider
- **Routing:** GoRouter
- **Tipografi:** Google Fonts (Montserrat)
- **Aset Kustom:** Logo HD (`logo.png`) & Latar Old Trafford (`old_trafford.jpg`)

---

## 📸 Tangkapan Layar Aplikasi

### 🔴 Light Mode (Merah Home Kit)
| Welcome Screen | Quiz Screen | Result Screen |
| :---: | :---: | :---: |
| <img src="screenshots/welcome_light.png" width="220"> | <img src="screenshots/quiz_light.png" width="220"> | <img src="screenshots/result_light.png" width="220"> |

### 🔵 Dark Mode (Biru Away Kit)
| Welcome Screen | Quiz Screen | Result Screen |
| :---: | :---: | :---: |
| <img src="screenshots/welcome_dark.png" width="220"> | <img src="screenshots/quiz_dark.png" width="220"> | <img src="screenshots/result_dark.png" width="220"> |

---
*Proyek ini dikembangkan sebagai pemenuhan tugas Ujian Tengah Semester (UTS) Praktikum Pemrograman Mobile.*