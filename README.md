# AtomeOS

AtomeOS is a modern Ubuntu-based Linux distribution built with Cubic.

**Smart by default, private by design.**

AtomeOS focuses on a clean desktop experience, useful default tools, and local-first AI features. The goal is to provide a simple operating system for daily use while keeping enough power for developers, students, and creators.

## Highlights

- **Ubuntu base**: familiar, stable, and compatible with common Linux software.
- **Atome Center**: a lightweight control center for profiles, system status, cleanup, wallpaper, and AI shortcuts.
- **Local AI assistant**: `ask`, `explain`, and `atome-ai` use Ollama when available.
- **Voice assistant**: say “atom OS”, then give a command such as “open chrome”.
- **First-run setup**: guided profile selection on first login.
- **Ready profiles**: `lightweight`, `student`, `creator`, and `developer`.
- **AtomeOS wallpaper**: installed, declared in GNOME, and applied by default.

## System Requirements

Minimum:

- 64-bit CPU, 2 cores
- 4 GB RAM
- 20 GB storage
- Linux-compatible graphics
- Microphone for the voice assistant

Recommended:

- 64-bit CPU, 4 cores
- 8 GB RAM
- 40 GB SSD
- Internet connection for model downloads and optional tools
- Microphone, built-in or USB

For local AI, `llama3.2:1b` is the target model for v0.1. It can run on modest hardware, but 8 GB RAM is recommended for a smoother experience.

## Features

### Atome Center

Run:

```bash
atome-center
```

Atome Center provides quick access to:

- assistant tools
- voice assistant controls
- beginner and developer modes
- student and creator profiles
- system status
- wallpaper setup
- apt cache cleanup
- AtomeOS build information

### Local AI Assistant

AtomeOS includes terminal helpers for local AI workflows:

```bash
ask "comment installer docker ?"
explain "sudo apt update"
atome-ai summarize ./notes.txt
```

The assistant uses Ollama and the `llama3.2:1b` model when available. If the model is missing, the helper attempts to pull it.

### Voice Assistant

Enable the voice assistant:

```bash
atome-voice enable
```

Wake phrase:

```text
atom OS
```

Example flow:

```text
User: atom OS
AtomeOS: How can I help you?
User: open chrome
```

Useful commands:

```bash
atome-voice status
atome-voice debug
atome-voice logs
atome-voice disable
```

Current supported voice actions:

- `open chrome`
- `open terminal`
- `open files`
- `open atome center`

### Profiles

Install a profile:

```bash
sudo atome-profile developer
```

Available profiles:

- `lightweight`: daily-use essentials
- `student`: documents, study, and organization tools
- `creator`: image, audio, video, and media tools
- `developer`: Git, Node.js, Python, Docker, terminal tools, and optional VS Code via Snap

## Repository Structure

```text
atomeos/
├── branding/              # Source visual assets
├── cubic/                 # Cubic package and customization notes
├── docs/                  # Vision, roadmap, and architecture
├── overlay/               # Files copied into the final OS
├── releases/              # Release notes and changelog
└── scripts/               # Build and chroot helper scripts
```

Important files:

- `scripts/chroot-setup.sh`: main Cubic chroot setup script
- `cubic/package-list.txt`: package list installed during customization
- `overlay/usr/bin/atome-center`: Atome Center launcher
- `overlay/usr/bin/atome-ai`: local AI wrapper
- `overlay/usr/bin/atome-voice`: local voice assistant
- `overlay/usr/share/backgrounds/atomeos/default.png`: default wallpaper

## Build Notes

AtomeOS is designed to be built inside a Cubic chroot.

Typical flow:

1. Open the Ubuntu ISO in Cubic.
2. Copy `cubic/package-list.txt` to `/tmp/package-list.txt` inside the chroot.
3. Copy `overlay/` to `/tmp/overlay` inside the chroot.
4. Run:

```bash
bash /path/to/scripts/chroot-setup.sh
```

The setup script:

- updates apt metadata
- installs packages while ignoring comments in `package-list.txt`
- copies the overlay with `rsync`
- compiles GNOME schema overrides
- installs Ollama unless disabled
- attempts to preload `llama3.2:1b`
- writes `/etc/atomeos-release`
- cleans apt cache

To skip Ollama during a build:

```bash
ATOME_SKIP_OLLAMA=1 bash scripts/chroot-setup.sh
```

## Testing

Check scripts:

```bash
bash -n scripts/chroot-setup.sh
bash -n overlay/usr/bin/atome-ai
bash -n overlay/usr/bin/atome-center
bash -n overlay/usr/bin/atome-profile
bash -n overlay/usr/bin/atome-voice
```

Test the wallpaper after boot:

```bash
gsettings get org.gnome.desktop.background picture-uri
```

Expected path:

```text
file:///usr/share/backgrounds/atomeos/default.png
```

Test voice output:

```bash
atome-voice test-say
```

Test voice recognition:

```bash
atome-voice debug
```

## Privacy

AtomeOS is designed around local-first behavior. The AI assistant runs locally when Ollama and the model are installed. The voice assistant uses local speech recognition with PocketSphinx and does not require a cloud service.

Network access is still required for package installation, optional tools, and downloading AI models.

## Status

AtomeOS is currently in early v0.1 development. The current focus is a functional custom ISO with a clean identity, useful defaults, local AI helpers, and a simple configuration center.

## License

This project is licensed under the MIT License.
