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

echo "[+] Create directories"
mkdir -p /usr/share/backgrounds/atomeos
mkdir -p /etc/atomeos

echo "[+] Copy overlay if present"
if [ -d /tmp/overlay ]; then
    if command -v rsync >/dev/null 2>&1; then
        rsync -a /tmp/overlay/ /
    else
        cp -a /tmp/overlay/. /
    fi
fi

# Ensure executable permissions on AtomeOS binaries
chmod +x /usr/bin/atome-* /usr/bin/ask /usr/bin/explain /usr/bin/code-ai /usr/bin/fix-ai 2>/dev/null || true

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

        # Select model to preload based on environment or hardware
        PRELOAD_MODEL="${ATOME_PRELOAD_MODEL:-}"
        if [ -z "$PRELOAD_MODEL" ]; then
            mem_kb="$(awk '/MemTotal/ {print $2}' /proc/meminfo 2>/dev/null || echo 0)"
            ram_mb=$(( mem_kb / 1024 ))
            if [ "$ram_mb" -ge 12000 ]; then
                PRELOAD_MODEL="llama3.1:8b"
            elif [ "$ram_mb" -ge 6000 ]; then
                PRELOAD_MODEL="llama3.2:3b"
            else
                PRELOAD_MODEL="llama3.2:1b"
            fi
        fi

        echo "[+] Attempting to preload model: $PRELOAD_MODEL"
        ollama pull "$PRELOAD_MODEL" || echo "[!] Could not pull $PRELOAD_MODEL during build. It will be pulled on first run."
        kill "$OLLAMA_PID" >/dev/null 2>&1 || true
    fi
fi

echo "[+] Write build information"
cat >/etc/atomeos-release <<EOF
NAME="AtomeOS"
VERSION="0.2"
EDITION="Pro / Strong"
SLOGAN="Smart by default, private by design."
BASE="Ubuntu"
BUILD_DATE="$(date -u +%Y-%m-%d)"
AI_TIER="Dynamic auto-detection (1B / 3B / 8B / Qwen / Mistral)"
EOF

echo "[+] Clean apt cache"
apt-get clean

echo "[+] AtomeOS v0.2 Pro / Strong setup completed successfully."
