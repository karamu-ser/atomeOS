# Journal des Modifications (Changelog)

## [0.2.0] - 2026-09-26 - Edition "Pro / Strong"

### Ajouts Majeurs - Assistant IA Local Puissant
- **Support des modeles 8B et 7B** : Compatibilite et presets integres pour `llama3.1:8b`, `qwen2.5:7b`, `mistral:7b`, `deepseek-r1:8b`, ainsi que `llama3.2:3b` et `llama3.2:1b`.
- **Detection materielle dynamique** : Analyse en temps reel de la RAM totale et des GPUs (NVIDIA/AMD) pour conseiller ou auto-configurer le tier IA optimal.
- **Nouvelles commandes terminal** :
  - `atome-ai chat` : session de chat interactive multi-tours dans le terminal.
  - `code-ai` / `atome-ai code` : generateur de scripts et snippets de programmation.
  - `fix-ai` / `atome-ai fix` : analyse d'erreurs et commandes de resolution.
  - `atome-ai models` : catalogue des modeles recommandes avec prérequis memoire.
  - `atome-ai set-model` : selection et persistance du modele utilisateur (`~/.config/atomeos/ai.conf`).
  - `atome-ai hardware` / `status` : affichage du diagnostic CPU, RAM, GPU, statut Ollama et tier IA.
- **Lanceur de bureau Assistant IA** : Ajout du fichier `atome-ai.desktop` pour un acces rapide depuis le menu des applications.

### Ameliorations du Centre Atome (`atome-center`)
- Mise a niveau vers la version v0.2 Pro / Strong.
- Interface graphique (Zenity) et TUI enrichies avec menu de selection de modeles IA.
- Acces direct au Chat IA, aux requetes rapides et au diagnostic materiel.
- Ajout du bouton d'activation du profil `pro` / `strong`.

### Nouveaux Profils et Outils
- **Profil Pro / Strong (`atome-profile pro`)** : Ajout des utilitaires de diagnostic et monitoring (`nvtop`, `btop`, `iotop`, `sysstat`), de la chaine de compilation complete et du declenchement du modele IA optimal.
- **Assistant vocal connecte (`atome-voice`)** : Capacite a relayer des requetes vocales en direct a l'assistant IA (`ask ...`, `ai chat`, `what model`).
- **Scripts d'administration et de build** :
  - `scripts/build-info.sh` : inspection rapide de l'environnement de build et du commit git.
  - `scripts/cleanup.sh` : nettoyage optimise pour Cubic chroot.
  - `scripts/install-dev-mode.sh` : installateur tout-en-un du mode dev et pro.
  - `cubic/notes.md` : documentation pas a pas du processus de generation ISO avec Cubic.
  - `cubic/post-customization.sh` : verification d'integrite des binaires et des schemas GNOME.

---

## [0.1.0] - 2026-06-03 - Version Initiale
- Base Ubuntu 24.04 personnalisee avec Cubic.
- Centre Atome basique en Zenity/Bash.
- Premier assistant local utilisant `llama3.2:1b`.
- Reconnaissance vocale locale basique avec PocketSphinx.
- Profils initiaux : `lightweight`, `student`, `creator`, `developer`.
- Fond d'ecran AtomeOS declare dans GNOME.
