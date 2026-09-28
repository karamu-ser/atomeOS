#!/usr/bin/env bash
set -euo pipefail

# Script execute a la fin de la personnalisation Cubic
echo "[+] Verification de l'integrite AtomeOS v0.2 Pro..."

# Verifier les executables
for bin in atome-ai atome-center atome-voice atome-profile atome-first-run ask explain code-ai fix-ai; do
    if [ ! -x "/usr/bin/$bin" ]; then
        echo "[!] Avertissement: /usr/bin/$bin n'est pas executable ou manquant."
    fi
done

# Compiler les schemas GNOME
if command -v glib-compile-schemas >/dev/null 2>&1 && [ -d /usr/share/glib-2.0/schemas ]; then
    glib-compile-schemas /usr/share/glib-2.0/schemas
fi

echo "[+] Post-customisation terminee avec succes."
