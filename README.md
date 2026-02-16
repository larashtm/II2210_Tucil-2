<div align="center">
  <h1>🔮 Laras Ramalan Zodiak</h1>

[![FastAPI](https://img.shields.io/badge/FastAPI-0.115.12-009688?style=flat-square&logo=fastapi)](https://fastapi.tiangolo.com/)
[![Python](https://img.shields.io/badge/Python-3.10-3776ab?style=flat-square&logo=python)](https://www.python.org/)
[![SQLModel](https://img.shields.io/badge/SQLModel-0.0.24-d62728?style=flat-square&logo=sqlite)](https://sqlmodel.tiangolo.com/)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ed?style=flat-square&logo=docker)](https://www.docker.com/)
[![Uvicorn](https://img.shields.io/badge/Uvicorn-0.34.0-499848?style=flat-square&logo=uvicorn)](https://www.uvicorn.org/)

</div>

---

## Overview

> **Laras Ramalan Zodiak** adalah aplikasi web interaktif yang menggabungkan ramalan zodiak dengan sistem Message of the Day (MOTD) yang aman. Aplikasi ini dibangun menggunakan FastAPI sebagai backend dan SQLite sebagai database, dilindungi dengan autentikasi TOTP (Time-based One-Time Password) untuk keamanan maksimal.

---

## Features

Berikut ini adalah fitur-fitur utama yang disediakan dalam aplikasi **Laras Ramalan Zodiak**:

| Fitur | Deskripsi |
|------|----------|
| **Ramalan Zodiak Interaktif** | Interface step-by-step yang user-friendly untuk mendapatkan ramalan personal berdasarkan: <br>• Nama pengguna <br>• Usia <br>• Zodiak (12 zodiak tersedia). <br>Dilengkapi dengan animasi smooth dan desain warna-warni yang menarik. |
| **Message of the Day (MOTD)** | Sistem pesan motivasi yang powerful dengan: <br>• Pengambilan pesan secara random dari database <br>• Pencatatan creator dan timestamp <br>• API endpoint untuk integrasi mudah <br>• Tracking history lengkap semua pesan. |
| **Autentikasi TOTP** | Keamanan tingkat enterprise dengan: <br>• Time-based One-Time Password (TOTP) <br>• SHA256 hashing algorithm <br>• 8-digit verification code <br>• Base32 encoding untuk shared secret <br>• HTTP Basic Authentication. |
| **RESTful API** | API yang clean dan well-documented: <br>• GET /motd - Ambil pesan random <br>• POST /motd - Tambah pesan baru (protected) <br>• Response JSON yang konsisten <br>• Error handling yang comprehensive. |
| **Database Management** | SQLite database dengan SQLModel ORM: <br>• Auto-initialization saat startup <br>• Model yang type-safe <br>• Timestamp otomatis untuk setiap entry <br>• Query optimization dengan random selection. |

---

## Getting Started

Sebelum menjalankan aplikasi, pastikan perangkat telah memenuhi kebutuhan berikut:

- Python (versi 3.10 atau lebih baru)
- pip (Python package manager)
- Docker & Docker Compose (opsional, namun direkomendasikan)
- Git

---

## Installation

### **Metode 1: Menggunakan Docker Compose (Recommended)**

1. Clone repository:
```bash
git clone <repository-url>
cd laras-ramalan-zodiak
```

2. Jalankan dengan Docker Compose:
```bash
docker-compose up --build
```

3. Aplikasi akan berjalan di:
```
http://localhost:17787
```

### **Metode 2: Local Installation**

1. Clone repository:
```bash
git clone <repository-url>
cd laras-ramalan-zodiak
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Jalankan aplikasi:
```bash
python main.py
```
atau
```bash
uvicorn main:app --host 0.0.0.0 --port 17787 --reload
```

4. Akses aplikasi melalui browser:
```
http://localhost:17787
```

---

## Running on Different Environments

### **Development Mode**
```bash
uvicorn main:app --host 0.0.0.0 --port 17787 --reload
```
Mode ini akan auto-reload setiap kali ada perubahan pada kode.

### **Production Mode**
```bash
uvicorn main:app --host 0.0.0.0 --port 17787
```

### **Docker Container**
```bash
# Build image
docker build -t laras-zodiak .

# Run container
docker run -p 17787:17787 laras-zodiak
```

---

## Project Structure

Dibawah ini adalah struktur folder utama yang digunakan dalam pengembangan aplikasi Laras Ramalan Zodiak beserta fungsi dari masing-masing file:

```
laras-ramalan-zodiak/
├── main.py              → Aplikasi FastAPI utama & routing
├── model.py             → SQLModel database models
├── index.html           → Halaman ramalan zodiak interaktif
├── motd.html            → Halaman display Message of the Day
├── tester.py            → Script testing untuk TOTP authentication
├── requirements.txt     → Python dependencies
├── Dockerfile           → Docker image configuration
├── docker-compose.yml   → Docker orchestration
├── motd.db              → SQLite database (auto-generated)
└── README.md            → Dokumentasi proyek
```

---

## API Endpoints

### **GET /**
Menampilkan halaman utama ramalan zodiak.

**Response:** HTML Page

---

### **GET /motd**
Mengambil satu pesan MOTD secara random dari database.

**Response:**
```json
{
  "message": "Slow progres is still progress, jadi jangan nyerah yaa"
}
```

---

### **POST /motd**
Menambahkan pesan MOTD baru ke database (memerlukan autentikasi).

**Request Body:**
```json
{
  "motd": "Pesan motivasi hari ini"
}
```

**Headers:**
```
Authorization: Basic <base64_encoded_credentials>
```

**Response - Success:**
```json
{
  "message": "MOTD added successfully."
}
```

**Response - Error:**
```json
{
  "detail": "Invalid userid or password."
}
```

---

## Authentication

Aplikasi menggunakan sistem autentikasi TOTP yang secure dengan konfigurasi berikut:

### **Configured Users**

| Username | Shared Secret |
|----------|--------------|
| `sister` | `ii2210_sister_rahasia` |
| `laras` | `ii2210_laras_sukaungu` |

### **TOTP Configuration**
- **Algorithm:** SHA256
- **Digits:** 8
- **Interval:** 30 seconds (default)
- **Encoding:** Base32

### **Testing Authentication**

Gunakan script `tester.py` untuk testing:

```python
python tester.py
```

Edit konfigurasi di dalam file:
```python
userid = "laras"
shared_secret = "ii2210_laras_sukaungu"
server_url = "http://localhost:17787/motd"
motd = {"motd": "Pesan motivasi hari ini"}
```

---

## Database Schema

### **MOTD Table**

| Column | Type | Constraint | Description |
|--------|------|-----------|-------------|
| `id` | Integer | PRIMARY KEY, AUTO INCREMENT | Unique identifier |
| `motd` | String | NOT NULL | Isi pesan motivasi |
| `creator` | String | NOT NULL | Username pembuat pesan |
| `created_at` | DateTime | NOT NULL, DEFAULT NOW | Timestamp UTC pembuatan |

---

## Docker Configuration

### **Dockerfile Highlights**
- Base Image: `python:3.10-slim`
- Working Directory: `/app`
- Exposed Port: `17787`
- Auto-install dependencies
- Optimized layer caching

### **Docker Compose Features**
- Service name: `web`
- Port mapping: `17787:17787`
- Volume mounting untuk development
- Hot-reload enabled
- Environment isolation

---

## Testing

### **Manual Testing**

1. Test halaman ramalan zodiak:
```bash
curl http://localhost:17787/
```

2. Test GET MOTD:
```bash
curl http://localhost:17787/motd
```

3. Test POST MOTD (dengan autentikasi):
```bash
python tester.py
```

---

## Configuration

### **Port Configuration**
Edit di `docker-compose.yml` atau saat menjalankan uvicorn:
```yaml
ports:
  - "17787:17787"  # ubah port pertama sesuai kebutuhan
```

### **Database Configuration**
Edit di `main.py`:
```python
sqlite_file_name = "motd.db"  # nama file database
sqlite_url = f"sqlite:///{sqlite_file_name}"
```

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| **Error 500 saat akses /motd** | Database belum ter-inisialisasi. Restart aplikasi atau panggil `create_db_and_tables()` |
| **Autentikasi gagal** | Pastikan TOTP token di-generate dengan benar (SHA256, 8 digits, Base32 encoding) |
| **Port sudah digunakan** | Ubah port di `docker-compose.yml` atau gunakan flag `--port` saat menjalankan uvicorn |
| **Docker build gagal** | Pastikan Docker daemon running dan port tidak konflik |
| **Database locked** | Hentikan semua instance aplikasi yang berjalan |

---

## Technologies Used

| Technology | Version | Purpose |
|-----------|---------|---------|
| FastAPI | 0.115.12 | Web framework |
| Uvicorn | 0.34.0 | ASGI server |
| SQLModel | 0.0.24 | ORM & database management |
| PyOTP | 2.9.0 | TOTP authentication |
| Python | 3.10 | Programming language |
| SQLite | 3.x | Database |
| Docker | Latest | Containerization |

---

## Security Notes

- Shared secrets di-hardcode untuk keperluan development/demo
- Untuk production, gunakan environment variables atau secret management system
- TOTP password berubah setiap 30 detik
- Database SQLite tidak direkomendasikan untuk production scale
- Gunakan HTTPS untuk deployment production
- Implement rate limiting untuk prevent brute force attacks

---

## Deployment

### **Deployment ke Cloud**

1. **Heroku:**
```bash
heroku create laras-zodiak
git push heroku main
```

2. **Railway/Render:**
- Connect repository
- Set port ke 17787
- Deploy otomatis dari Git

3. **VPS/Server:**
```bash
docker-compose up -d
```

