#!/usr/bin/env bash
set -e

echo "[+] Update packages"
apt update

echo "[+] Install package list"
if [ -f /tmp/package-list.txt ]; then
    xargs -a /tmp/package-list.txt apt install -y
fi

echo "[+] Create wallpaper folder"
mkdir -p /usr/share/backgrounds/atomeos

echo "[+] Copy overlay if present"
if [ -d /tmp/overlay ]; then
    cp -r /tmp/overlay/* /
fi

echo "[+] Clean apt cache"
apt clean

echo "[+] Done"