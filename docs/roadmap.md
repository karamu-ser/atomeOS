# Roadmap AtomeOS

## v0.1 (Fondee)
- Base Ubuntu personnalisee avec Cubic.
- Overlay systeme pour le branding AtomeOS.
- Centre Atome initial en Bash / Zenity.
- Assistant local rudimentaire via Ollama et `llama3.2:1b`.
- Assistant vocal local avec mot-cle `atomeos` et commandes de base.
- Commandes terminal `ask`, `explain`, `atome-ai`.
- Premier demarrage guide et profils initiaux.

## v0.2 - Pro / Strong (Version Actuelle)
- **Support des modeles puissants** : integration complete de `llama3.1:8b`, `qwen2.5:7b`, `mistral:7b`, `deepseek-r1:8b`, `llama3.2:3b`.
- **Auto-detection materielle** : analyse automatique de la RAM et des GPUs pour recommander et adapter le modele optimal.
- **Suite d'outils IA elargie** :
  - `atome-ai chat` : session de conversation interactive en terminal.
  - `code-ai` : generation de scripts et code sources.
  - `fix-ai` : diagnostic et reparation d'erreurs systeme / dev.
  - `atome-ai models` / `set-model` : selection et persistance du modele IA.
  - `atome-ai hardware` : diagnostic detaille des ressources.
- **Centre Atome v0.2 Pro** : selection visuelle de la puissance IA, diagnostic materiel, lancement de chat.
- **Profil Pro / Strong** : profil haute performance avec monitoring avance (`nvtop`, `btop`, `iotop`, `sysstat`).
- **Assistant vocal enrichi** : capacite a relayer des questions vocales vers le moteur IA (`ask ...`, `open chat`).
- **Documentation et outillage de build** : guides Cubic pas a pas, `build-info.sh`, `cleanup.sh`, validation `post-customization.sh`.

## v0.3 (Futur)
- Interface de chat graphique native (GTK4 / Libadwaita).
- Agents IA autonomes avec confirmation d'actions systeme (safe sandbox).
- Support optionnel d'une base Arch Linux (`archiso` sur branche `arch._.based`).
- Gestionnaire de plugins et extensions pour l'assistant vocal.
