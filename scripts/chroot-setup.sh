#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

if [ "$(id -u)" -ne 0 ]; then
    echo "[!] This script must be run as root inside the Cubic chroot."
    exit 1
fi

echo "[+] Update packages"
apt-get update

echo "[+] Install package list"
if [ -f /tmp/package-list.txt ]; then
    sed 's/#.*//;/^[[:space:]]*$/d' /tmp/package-list.txt | xargs -r apt-get install -y
fi

echo "[+] Create wallpaper folder"
mkdir -p /usr/share/backgrounds/atomeos

echo "[+] Copy overlay if present"
if [ -d /tmp/overlay ]; then
    if command -v rsync >/dev/null 2>&1; then
        rsync -a /tmp/overlay/ /
    else
        cp -a /tmp/overlay/. /
    fi
fi

echo "[+] Configure GNOME defaults"
if command -v glib-compile-schemas >/dev/null 2>&1 && [ -d /usr/share/glib-2.0/schemas ]; then
    glib-compile-schemas /usr/share/glib-2.0/schemas
fi

echo "[+] Install Ollama"
if [ "${ATOME_SKIP_OLLAMA:-0}" = "1" ]; then
    echo "[i] Skipping Ollama install because ATOME_SKIP_OLLAMA=1"
else
    curl -fsSL https://ollama.com/install.sh | sh

    echo "[+] Preload local assistant model"
    if command -v ollama >/dev/null 2>&1; then
        ollama serve >/tmp/ollama-serve.log 2>&1 &
        OLLAMA_PID="$!"
        sleep 5
        ollama pull llama3.2:1b || echo "[!] Could not pull llama3.2:1b during build. It can be pulled after first boot."
        kill "$OLLAMA_PID" >/dev/null 2>&1 || true
    fi
fi

echo "[+] Write build information"
cat >/etc/atomeos-release <<EOF
NAME="AtomeOS"
VERSION="0.1"
SLOGAN="Smart by default, private by design."
BASE="Ubuntu"
BUILD_DATE="$(date -u +%Y-%m-%d)"
EOF

echo "[+] Clean apt cache"
apt-get clean

echo "[+] Done"
