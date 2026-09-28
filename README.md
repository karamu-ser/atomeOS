# AtomeOS - v0.2 Pro / Strong

AtomeOS is a modern, high-performance Ubuntu-based Linux distribution built with Cubic.

**Smart by default, private by design.**

AtomeOS delivers a clean desktop experience, robust developer and creator profiles, and a state-of-the-art **local-first AI assistant** that adapts to your hardware without sending your personal data to external clouds.

---

## Highlights

- **Ubuntu base**: Familiar, stable, and compatible with the broader Debian/Ubuntu ecosystem.
- **Dynamic Hardware & AI Auto-detection**: Automatically checks CPU, RAM, and GPU to configure the optimal local AI model (from 1B up to 8B parameters).
- **Strong Local AI Assistant**: Powered by Ollama with support for `llama3.1:8b`, `qwen2.5:7b`, `mistral:7b`, `deepseek-r1:8b`, `llama3.2:3b`, and `llama3.2:1b`.
- **Integrated AI Tool Suite**:
  - `atome-ai chat`: Interactive multi-turn terminal conversation.
  - `ask`: Quick natural language question answering.
  - `explain`: Linux command and script safety analyzer.
  - `code-ai`: Code and shell script generation.
  - `fix-ai`: Diagnostic and fix suggestions for errors and broken commands.
  - `atome-ai summarize`: Document and file summarizer.
  - `atome-ai models` & `set-model`: Model catalog, switching, and management.
- **Atome Center**: Graphical & TUI control center for AI models, system status, hardware diagnostics, profiles, wallpaper, and voice assistant.
- **Voice Assistant**: Say “atom OS”, then ask questions, launch AI chat, or control apps locally using PocketSphinx.
- **Ready Profiles**: `pro` (Strong / High-Performance), `developer`, `lightweight`, `student`, and `creator`.

---

## System Requirements & AI Tiers

| Tier | RAM | Recommended Model | Use Case |
|---|---|---|---|
| **Ultra-Lightweight** | 4 GB | `llama3.2:1b` | Netbooks, older laptops, low-resource VMs |
| **Standard / Balanced**| 6 - 8 GB | `llama3.2:3b` | Everyday productivity, documentation |
| **Pro / Strong** | 12 - 16+ GB or GPU | `llama3.1:8b`, `qwen2.5:7b`, `mistral:7b`, `deepseek-r1:8b` | Intensive coding, reasoning, advanced analysis |

### Hardware Requirements
- **Minimum**: 64-bit dual-core CPU, 4 GB RAM, 25 GB storage.
- **Recommended (Pro / Strong)**: 64-bit quad-core+ CPU, 12+ GB RAM (or dedicated NVIDIA/AMD GPU), 50 GB SSD.

---

## Features & Usage

### 1. Atome Center

Launch the control center:

```bash
atome-center
```

Provides graphical (Zenity) or terminal (TUI) access to:
- Interactive AI chat and question answering
- Switching AI models (1B / 3B / 8B / Qwen / Mistral / DeepSeek)
- Hardware & AI tier diagnostics
- Voice assistant controls
- System profiles (`pro`, `developer`, `student`, `creator`, `lightweight`)
- Wallpaper and desktop customization
- System cleanup and release information

### 2. Local AI Assistant (`atome-ai`)

Test hardware detection and model recommendation:

```bash
atome-ai hardware
```

List supported models and check active selection:

```bash
atome-ai models
```

Switch active model:

```bash
atome-ai set-model llama3.1:8b
```

Launch an interactive conversation:

```bash
atome-ai chat
```

Quick terminal shortcuts:

```bash
ask "comment configurer un reverse proxy nginx ?"
explain "iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080"
code-ai "ecris un script python qui surveille l'espace disque et alerte"
fix-ai "error: failed to push some refs to 'git@github.com:...'"
atome-ai summarize ./rapport.txt
```

### 3. Voice Assistant (`atome-voice`)

Enable the voice assistant:

```bash
atome-voice enable
```

Wake phrase: **"atom OS"** or **"atomeos"**

Examples:
- *"atom OS"* &rarr; *"How can I help you?"* &rarr; *"open terminal"*
- *"atom OS"* &rarr; *"How can I help you?"* &rarr; *"open chrome"*
- *"atom OS"* &rarr; *"How can I help you?"* &rarr; *"ask how do I update packages"*
- *"atom OS"* &rarr; *"How can I help you?"* &rarr; *"open chat"*
- *"atom OS"* &rarr; *"How can I help you?"* &rarr; *"what model"*

Control commands:

```bash
atome-voice status
atome-voice test-say
atome-voice debug
atome-voice disable
```

### 4. Profiles (`atome-profile`)

Apply ready-made system profiles:

```bash
# Pro / Strong profile: Heavy dev stack, performance monitoring (btop, nvtop, iotop), and strong AI
sudo atome-profile pro

# Developer profile: Git, Node.js, Python, Docker, build tools, VS Code
sudo atome-profile developer

# Lightweight profile: Daily essentials and fast utilities
sudo atome-profile lightweight

# Student & Creator profiles:
sudo atome-profile student
sudo atome-profile creator
```

---

## Repository Structure

```text
atomeos/
├── branding/              # Source visual assets and wallpapers
├── cubic/                 # Cubic customization package list, notes, and removals
│   ├── notes.md           # Step-by-step Cubic build tutorial
│   ├── package-list.txt   # APT packages installed in Cubic
│   ├── post-customization.sh # Post-build validation script
│   └── removals.txt       # Unnecessary packages purged from ISO
├── docs/                  # Architecture, roadmap, and vision
│   ├── architecture.md
│   ├── roadmap.md
│   └── vision.md
├── overlay/               # Files copied directly into root filesystem of the OS
│   ├── etc/               # Profile scripts and autostart entries
│   └── usr/               # Executables, desktop entries, wallpaper schemas
├── releases/              # Release notes and changelog
│   └── changelog.md
└── scripts/               # Build, cleanup, and helper scripts
    ├── build-info.sh      # Environment and build version inspector
    ├── chroot-setup.sh    # Main setup script executed in Cubic chroot
    ├── cleanup.sh         # ISO cleanup script
    └── install-dev-mode.sh # One-step developer & pro setup
```

---

## Building AtomeOS with Cubic

1. Open your Ubuntu 24.04 Desktop ISO in **Cubic**.
2. Copy `cubic/package-list.txt` to `/tmp/package-list.txt` in chroot.
3. Copy `overlay/` to `/tmp/overlay` in chroot.
4. Run:

```bash
bash /path/to/scripts/chroot-setup.sh
```

To optionally force preloading a specific model during the ISO build:

```bash
ATOME_PRELOAD_MODEL="llama3.1:8b" bash scripts/chroot-setup.sh
```

5. Run `bash scripts/cleanup.sh` before generating the ISO.

---

## Testing & Validation

Validate shell scripts:

```bash
bash -n scripts/*.sh
bash -n overlay/usr/bin/*
```

Inspect build environment:

```bash
./scripts/build-info.sh
```

Test hardware detection & models:

```bash
./overlay/usr/bin/atome-ai hardware
./overlay/usr/bin/atome-ai models
```

---

## License

This project is licensed under the MIT License.
