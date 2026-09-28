# Instructions de build Cubic - AtomeOS v0.2 Pro / Strong

## 1. Preparation de l'environnement
- Telecharger une image ISO Ubuntu (recommandé: Ubuntu Desktop 24.04 LTS x86_64).
- Installer Cubic :
  ```bash
  sudo apt-add-repository universe
  sudo apt-add-repository ppa:cubic-wizard/release
  sudo apt update
  sudo apt install cubic
  ```

## 2. Configuration du projet Cubic
- Creer un dossier de travail pour AtomeOS.
- Selectionner l'ISO source Ubuntu.
- Nom du volume : `AtomeOS-v0.2-Pro`
- Nom du fichier ISO genere : `atomeos-0.2-pro-amd64.iso`

## 3. Personnalisation dans le chroot Cubic
Copier les fichiers du depot dans le chroot Cubic (via le bouton "Copier" de Cubic ou en terminal) :
- Copier `cubic/package-list.txt` vers `/tmp/package-list.txt`
- Copier le dossier `overlay/` vers `/tmp/overlay/`
- Executer :
  ```bash
  bash /chemin/vers/atomeOS/scripts/chroot-setup.sh
  ```

Optionnellement, pour forcer le prechargement d'un modele 8B pendant le build si vous avez assez de RAM et de bande passante :
```bash
ATOME_PRELOAD_MODEL="llama3.1:8b" bash scripts/chroot-setup.sh
```

## 4. Nettoyage et Generation
- Executer `bash scripts/cleanup.sh`
- Cliquer sur "Suivant" dans Cubic pour generer l'image ISO.
