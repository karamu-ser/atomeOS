#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "[!] Ce script doit etre execute avec les privileges root."
    exit 1
fi

echo "[+] Nettoyage des caches APT..."
apt-get autoremove -y
apt-get clean
rm -rf /var/lib/apt/lists/*

echo "[+] Suppression des journaux et fichiers temporaires..."
rm -rf /tmp/* /var/tmp/*
find /var/log -type f -name "*.log" -exec truncate -s 0 {} + 2>/dev/null || true
find /var/log -type f -name "*.gz" -delete 2>/dev/null || true

echo "[+] Nettoyage termine avec succes pour l'ISO AtomeOS."
