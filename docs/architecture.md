# Architecture

## Structure
- `cubic/package-list.txt` : paquets installés pendant la personnalisation Cubic.
- `scripts/chroot-setup.sh` : script principal à lancer dans le chroot.
- `overlay/` : fichiers copiés dans le système final.
- `branding/` : ressources visuelles sources.

## Wallpaper
- `overlay/usr/share/backgrounds/atomeos/default.png` : fond d'écran installé.
- `overlay/usr/share/gnome-background-properties/atomeos.xml` : déclaration dans la liste GNOME.
- `overlay/usr/share/glib-2.0/schemas/90_atomeos-wallpaper.gschema.override` : fond par défaut GNOME.

## Overlay smart
- `overlay/usr/bin/atome-ai` : wrapper Ollama pour l'assistant local.
- `overlay/usr/bin/atome-voice` : assistant vocal local avec mot-clé `atomeos`.
- `overlay/usr/bin/ask` : raccourci pour poser une question.
- `overlay/usr/bin/explain` : raccourci pour expliquer une commande.
- `overlay/usr/bin/atome-profile` : installation des profils prêts.
- `overlay/usr/bin/atome-center` : centre de configuration graphique ou texte.
- `overlay/usr/bin/atome-first-run` : assistant de premier démarrage.
- `overlay/etc/xdg/autostart/atome-first-run.desktop` : lancement automatique au premier login.
- `overlay/etc/xdg/autostart/atome-voice.desktop` : démarrage automatique de l'assistant vocal si l'utilisateur l'a activé.
- `overlay/etc/profile.d/atome-ai.sh` : fonctions shell `ask` et `explain`.

## Build
Le script chroot :
1. met à jour les paquets ;
2. installe la liste en ignorant les commentaires ;
3. copie l'overlay avec `rsync` ;
4. compile les schemas GNOME pour appliquer les defaults ;
5. installe Ollama sauf si `ATOME_SKIP_OLLAMA=1` ;
6. tente de précharger `llama3.2:1b` ;
7. écrit `/etc/atomeos-release` ;
8. nettoie le cache apt.
