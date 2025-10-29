#!/usr/bin/env bash
# ======================================================
# ⚡ YogX v2 — Advanced Termux Banner Installer
# Author: Yogeshwar Kumar (YogX)
# ======================================================

set -euo pipefail
PREFIX=${PREFIX:-/data/data/com.termux/files/usr}
HOME_DIR="$HOME"
REPO_DIR="$HOME_DIR/YogX"
CORE="$REPO_DIR/core"
ASSETS="$REPO_DIR/assets"
FILES="$REPO_DIR/files"

echo "⚙️  Installing YogX Environment..."
mkdir -p "$CORE" "$ASSETS" "$FILES"

pkg update -y && pkg upgrade -y
pkg install -y git python figlet ruby curl termux-api

# Install lolcat if missing
if ! command -v lolcat >/dev/null 2>&1; then
  gem install lolcat
fi

# Install pyfiglet if missing
python3 -m pip install --user pyfiglet > /dev/null 2>&1 || true

# Backup old Termux bashrc
if [ -f "$HOME_DIR/.bashrc" ]; then
  cp "$HOME_DIR/.bashrc" "$REPO_DIR/core/bashrc_backup_$(date +%s)"
fi

# Add YogX auto-start
if ! grep -q 'YogX/core/yogx.sh' "$HOME_DIR/.bashrc"; then
  echo '[[ $- == *i* ]] && bash ~/YogX/core/yogx.sh' >> "$HOME_DIR/.bashrc"
fi

# Add update alias
if ! grep -q 'alias yogx-update' "$HOME_DIR/.bashrc"; then
  echo "alias yogx-update='bash ~/YogX/core/update.sh'" >> "$HOME_DIR/.bashrc"
fi

# Add backup alias
if ! grep -q 'alias yogx-backup' "$HOME_DIR/.bashrc"; then
  echo "alias yogx-backup='bash ~/YogX/core/backup.sh'" >> "$HOME_DIR/.bashrc"
fi

clear
echo "✅ YogX installed successfully!"
echo "🎨 Restart Termux to see your new header!"
echo "⚡ Commands available: yogx-update | yogx-backup"