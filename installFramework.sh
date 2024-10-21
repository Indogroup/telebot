#!/bin/bash

# Fungsi untuk mendeteksi sistem operasi
detect_os() {
    case "$(uname -s)" in
        Linux*)     OS="Linux";;
        Darwin*)    OS="Mac";;
        CYGWIN*|MINGW*|MSYS*) OS="Windows";;
        *)          OS="Unknown";;
    esac
    echo "Sistem Operasi terdeteksi: $OS"
}

# URL repository GitHub
REPO_URL="https://github.com/username/repository.git"
FRAMEWORK_DIR="framework"

# Cek apakah git sudah terinstal
check_git_installed() {
    if ! command -v git &> /dev/null
    then
        echo "Git tidak terinstal. Silakan instal Git terlebih dahulu."
        exit 1
    fi
}

# Fungsi untuk membuat direktori jika belum ada
create_framework_dir() {
    if [ ! -d "$FRAMEWORK_DIR" ]; then
        echo "Direktori $FRAMEWORK_DIR belum ada. Membuat direktori..."
        mkdir -p "$FRAMEWORK_DIR"
    else
        echo "Direktori $FRAMEWORK_DIR sudah ada."
    fi
}

# Clone repository ke dalam direktori framework
clone_repository() {
    # Hapus direktori framework jika sudah ada
    if [ -d "$FRAMEWORK_DIR" ]; then
        echo "Direktori $FRAMEWORK_DIR sudah ada, menghapus isinya..."
        rm -rf "$FRAMEWORK_DIR/*"
    fi

    # Clone repository
    echo "Mengunduh repository dari $REPO_URL ke direktori $FRAMEWORK_DIR..."
    git clone $REPO_URL "$FRAMEWORK_DIR"

    echo "Proses selesai. Repository telah diunduh."
}

# Periksa apakah kita sedang di Windows
check_windows() {
    if [ "$OS" == "Windows" ]; then
        echo "Anda sedang menggunakan Windows."
        echo "Untuk menjalankan script ini di Windows, pastikan Anda menggunakan lingkungan yang mendukung bash seperti Git Bash atau WSL (Windows Subsystem for Linux)."
        exit 1
    fi
}

# Deteksi sistem operasi
detect_os

# Cek apakah git sudah terinstal
check_git_installed

# Cek apakah script dijalankan di Windows tanpa WSL atau Git Bash
check_windows

# Buat direktori framework jika belum ada
create_framework_dir

# Clone repository jika tidak ada masalah
clone_repository
