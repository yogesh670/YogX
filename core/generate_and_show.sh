#!/usr/bin/env bash
# core/generate_and_show.sh
# Generate ASCII if missing and show the YogX banner
set -euo pipefail

REPO_DIR="${HOME}/YogX"
ASSETS_DIR="${REPO_DIR}/assets"
CORE_DIR="${REPO_DIR}/core"
OUT_FILE="$ASSETS_DIR/logo.txt"
YOGX_NAME="YogX"

# ensure generator present
GEN="$CORE_DIR/generate_ascii.sh"
if [[ ! -f "$GEN" ]]; then
  echo "Generator not found at $GEN. Exiting."
  exit 1
fi

# if ascii missing, generate
if [[ ! -f "$OUT_FILE" || "$1" == "regen" ]]; then
  echo "Generating ASCII art for '$YOGX_NAME'..."
  bash "$GEN" "$YOGX_NAME" "$ASSETS_DIR"
fi

# colors
RED="\e[1;31m"; MAG="\e[1;35m"; CYN="\e[1;36m"; YEL="\e[1;33m"; GRN="\e[1;92m"; RST="\e[0m"

# info
DF=$(df -h "$HOME" 2>/dev/null | awk 'NR==2 {print $3 " of " $2 " (" $5 ")"}' || echo "N/A")
MEM=$(awk '/MemTotal/ {t=$2}/MemAvailable/ {a=$2} END {print (t>0) and int((t-a)/t*100) or "N/A"}' /proc/meminfo 2>/dev/null || echo "N/A")
# pretty uptime
UP_SEC=$(awk '{print int($1)}' /proc/uptime 2>/dev/null || echo 0)
UPH=$(printf '%dd %02dh %02dm' $((UP_SEC/86400)) $((UP_SEC%86400/3600)) $((UP_SEC%3600/60)))

# show header
echo -e "${MAG}${YEL}●●●${RST}    [${CYN}${RST}] Disk: ${GRN}${DF}${RST}  | RAM: ${YEL}${MEM}%${RST}  | Uptime: ${CYN}${UPH}${RST}"
echo -e "${CYN}[] $(date '+%I:%M:%S %p | %Y-%b-%a — %d')${RST}"
echo

# show ASCII art (colorize with lolcat if available)
if command -v lolcat >/dev/null 2>&1; then
  cat "$OUT_FILE" | lolcat
else
  sed 's/^/'"$MAG"'/; s/$/'"$RST"'/' "$OUT_FILE"
fi

echo
echo -e "\e[1;31m ┌─╼[\e[1;33m${YOGX_NAME}✈${YOGX_NAME}\e[1;31m]-[\e[1;36m~\e[1;31m]"
echo -e " └────╼ \e[1;92m❯❯❯ \e[0m"