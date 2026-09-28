# Architecture AtomeOS (v0.2 Pro / Strong)

## Structure du Projet
- `cubic/package-list.txt` : liste des paquets APT installes dans Cubic (outils coeur, terminal, monitoring, IA, bureau).
- `cubic/notes.md` : guide de generation de l'image ISO.
- `cubic/removals.txt` : paquets purges pour optimiser la taille et supprimer le tracking.
- `cubic/post-customization.sh` : validations d'integrite post-build.
- `scripts/chroot-setup.sh` : script d'installation principal a executer dans le chroot Cubic.
- `scripts/build-info.sh` : utilitaire d'inspection de version et d'environnement.
- `scripts/cleanup.sh` : nettoyage des caches et logs pour finaliser l'ISO.
- `scripts/install-dev-mode.sh` : activation rapide du mode developpement et pro.
- `overlay/` : arborescence copiee directement a la racine du systeme.
- `branding/` : fonds d'ecran et identite visuelle.

## Composants de l'Assistant IA Local (`atome-ai`)
L'assistant est articule autour de plusieurs couches :
1. **Module de Detection Materielle (`recommend_model`, `get_ram_mb`, `has_gpu`)** :
   - RAM < 6 GB : modele Ultra-leger (`llama3.2:1b`).
   - 6 GB <= RAM < 12 GB : modele Standard (`llama3.2:3b`).
   - RAM >= 12 GB ou GPU dedie : modeles Pro / Fort (`llama3.1:8b`, `qwen2.5:7b`, `mistral:7b`, `deepseek-r1:8b`).
2. **Couche de Configuration** :
   - Fichier utilisateur : `~/.config/atomeos/ai.conf`.
   - Fichier systeme : `/etc/atomeos/ai.conf`.
   - Variable d'environnement : `ATOME_AI_MODEL`.
3. **Moteur d'Execution** :
   - S'appuie sur le daemon `ollama` local. Demarre le service en tache de fond si inactif.
   - Telecharge et verifie le modele demande a la volee ou en pre-chargement.
4. **Commandes et Points d'Entree** :
   - `atome-ai chat` : session interactive multi-tour en terminal.
   - `ask "..."` : Q&R rapide en langage naturel.
   - `explain "..."` : decryptage technique et analyse de securite des commandes Linux.
   - `code-ai "..."` : generation de code source et scripts.
   - `fix-ai "..."` : diagnostic de messages d'erreur et commandes de depannage.
   - `atome-ai summarize <file>` : synthese automatique de documents.
   - `atome-ai models` / `set-model` : selection et gestion des modeles.
   - `atome-ai hardware` : diagnostic en direct CPU, RAM, GPU et Ollama.

## Composants Graphiques et Vocaux
- `overlay/usr/bin/atome-center` : panneau de controle Zenity (GUI) et terminal (TUI) offrant un acces unifie a l'assistant, aux profils, aux modeles IA et a l'etat du systeme.
- `overlay/usr/bin/atome-voice` : assistant vocal fonctionnant en local avec PocketSphinx. Il ecoute le mot d'activation (*"atom OS"* / *"atomeos"*), execute des actions systeme et peut relayer des questions a l'assistant IA (`ask ...`, `open chat`).
- `overlay/usr/bin/atome-first-run` : premier demarrage avec proposition intelligente du profil et du tier IA selon le materiel detecte.

## Profils Systeme (`atome-profile`)
- `pro` / `strong` : outils de developpement intensif, monitoring avance (`nvtop`, `btop`, `iotop`, `sysstat`), Docker, VS Code et telechargement du tier IA superieur.
- `developer` : outils de base du developpeur (Git, Node, Python, Docker, terminal moderne).
- `lightweight` : base minimale optimisee pour la rapidite.
- `student` : suite bureautique, PDF et organisation.
- `creator` : montage video, retouche photo et traitement audio.
