#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "[!] Ce script doit etre execute en root (sudo ./scripts/install-dev-mode.sh)."
    exit 1
fi

echo "[+] Activation du mode developpeur & Pro pour AtomeOS..."
if command -v atome-profile >/dev/null 2>&1; then
    atome-profile pro
elif [ -x "./overlay/usr/bin/atome-profile" ]; then
    ./overlay/usr/bin/atome-profile pro
else
    apt-get update
    apt-get install -y git vim nano zsh fzf tmux ripgrep fd-find bat eza build-essential cmake pkg-config python3 python3-pip python3-venv nodejs npm docker.io htop btop iotop sysstat nvtop
fi

echo "[+] Mode developpeur & Pro active avec succes."
