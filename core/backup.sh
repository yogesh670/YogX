#!/usr/bin/env bash
# Backup all user Termux configs
echo "📦 Creating Termux backup..."
BACKUP_DIR="$HOME/YogX/backups/backup_$(date +%Y%m%d_%H%M)"
mkdir -p "$BACKUP_DIR"
cp -r ~/.bashrc ~/.termux "$BACKUP_DIR" 2>/dev/null || true
echo "✅ Backup saved at: $BACKUP_DIR"