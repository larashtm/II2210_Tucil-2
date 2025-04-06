# Menggunakan image Python sebagai base image
FROM python:3.10-slim

# Set working directory di dalam container
WORKDIR /app

# Salin requirements.txt dulu (biar bisa cache)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Salin semua file project ke container
COPY . .

# Expose port FastAPI kamu
EXPOSE 17787

# Jalankan aplikasi pakai uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "17787"]
