#!/usr/bin/env bash
set -euo pipefail

echo "=========================================="
echo "  AtomeOS Build & Environment Information "
echo "=========================================="
echo "OS Name         : AtomeOS"
echo "Version         : 0.2"
echo "Edition         : Pro / Strong"
echo "Codename        : Smart & Private"
echo "Git Commit      : $(git rev-parse --short HEAD 2>/dev/null || echo 'unknown')"
echo "Git Branch      : $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo 'unknown')"
echo "Host Kernel     : $(uname -r)"
echo "Host Arch       : $(uname -m)"
echo "Ollama Status   : $(command -v ollama >/dev/null 2>&1 && echo 'Installed' || echo 'Not installed')"
echo "=========================================="
