# 🎬 WatchMe: Aplikasi Katalog Film

**WatchMe** adalah sebuah **aplikasi seluler (mobile application)** yang berfungsi sebagai katalog film dan *personal movie tracker*. Aplikasi ini dirancang untuk pengguna yang ingin menjelajahi film-film terbaru dan menyimpan film-film yang ingin mereka tonton ke dalam *watchlist* pribadi. Dari segi fungsionalitas, WatchMe memungkinkan penjelajahan film berdasarkan kategori seperti **Trending movies, Top rated, and Upcoming**. Fiturnya meliputi pencarian *real-time*, tampilan detail film yang menyertakan **Cast, Writer, dan Director**, serta sistem **Watchlist** yang tersimpan secara lokal dan terintegrasi secara dinamis di seluruh UI. Secara teknis, aplikasi ini dibangun dengan framework **Flutter** dan menggunakan **GetX** untuk *state management*. Proyek ini menunjukkan implementasi **Arsitektur Modular**.

---

## 🚀 Fitur Utama Aplikasi
| Halaman | Fungsionalitas Kunci |
| :--- | :--- |
| **🏠 Home** | **Jelajah Film:** Menampilkan daftar film utama (**Trending**, *Top Rated*, dan *Upcoming*) dengan *auto-sliding banner*. | 
| **🎬 Detail** | **Informasi Mendalam:** Menampilkan *overview*, *Rating* dinamis, *trailer button*, serta **Tab Switching** untuk memisahkan data **Cast**, **Writer**, dan **Director**. | 
| **🔍 Search** | **Pencarian Instan:** Mencari film secara *real-time* (*search-as-you-type*) dengan teknik *debouncing* untuk performa API yang optimal. | 
| **📝 Watchlist** | **Penyimpanan Lokal:** Daftar film yang disimpan di memori perangkat (**Local Storage**), dengan kemampuan pencarian/filter lokal. | 

---

## ⚙️ Tech Stack & Arsitektur

### Struktur Proyek (Modular GetX)

| Folder | Tanggung Jawab | Komponen Kunci |
| :--- | :--- | :--- |
| **`lib/config`** | **Konfigurasi Global** | `routes/`, `theme/`. |
| **`lib/data`** | **Data Layer** | `models/`, `services/`. |
| **`lib/modules`** | **Presentation Layer** | `main/`, `home/`, `detail/`, `search/`, `watchlist/`. |
| **`lib/shared`** | **Reusable Widgets** | `widgets/`. |
| **`lib/utils`** | **Helper Functions** | `app_utils.dart`. |

### Komponen Teknis

| Komponen | Alat/Konsep | Fokus Utama |
| :--- | :--- | :--- |
| **Framework** | Flutter 3.x+ | Pengembangan *cross-platform* yang cepat. |
| **State & DI** | GetX | *State Management* reaktif dan *Dependency Injection* (DI) akar. |
| **Arsitektur** | Modular & Clean Code | Pembagian kode per fitur (`home/`, `search/`, `detail/`) untuk skalabilitas. |
| **Data API** | Dio | Klien HTTP yang kuat untuk komunikasi dengan TMDb. |
| **Data Source** | TMDb API | Digunakan untuk mendapatkan data film Populer, Trending, Upcoming dan credits. |
| **Local Storage**| `get_storage` | Penyimpanan data *watchlist* lokal (*local-first*) yang aman. |
| **Keamanan** | `flutter_dotenv` | Mengisolasi dan mengamankan **API Key** TMDb. |
| **Native UI** | `flutter_native_splash` | Pengalaman *splash screen* *native* yang mulus (anti-*white flash*). |

---

## 🛠️ Instruksi Menjalankan Aplikasi

### A. Setup Lingkungan & API Key

1.  **Clone Repository:**
    ```bash
    git clone https://github.com/azrieldwim/watchme
    flutter pub get
    ```

2.  **Konfigurasi Kunci API (Wajib):**
    * Buat file **`.env`** di **tingkat akar *root* proyek**.
    * Isi file `.env` dengan *key* TMDb Anda:
        ```
        API_KEY=YOUR_SECRET_API_KEY_HERE
        ```

3.  **Build Native Assets:**

    ```bash
    flutter pub run flutter_launcher_icons
    flutter pub run flutter_native_splash:create
    ```

### B. Menjalankan Aplikasi

```bash
# Jalankan aplikasi
flutter run --no-enable-impeller
```

## 🖼️ Dokumentasi
![alt text](https://github.com/azrieldwim/watchme/blob/master/assets/images/dokumentasi1.png?raw=true)
![alt text](https://github.com/azrieldwim/watchme/blob/master/assets/images/dokumentasi2.png?raw=true)
