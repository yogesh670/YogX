#!/usr/bin/env bash
# yogx-banner.sh - shows YogX banner (called on shell start)

REPO_DIR="$HOME/YogX"
ASSETS="$REPO_DIR/assets"
CORE="$REPO_DIR/core"
YOGX_NAME="YogX"

# colors
RED="\e[1;31m"; MAG="\e[1;35m"; CYN="\e[1;36m"; YEL="\e[1;33m"; GRN="\e[1;92m"; RST="\e[0m"

# gather info
DF=$(df -h "$HOME" 2>/dev/null | awk 'NR==2 {print $3 " of " $2 " (" $5 ")"}' || echo "N/A")
MEM=$(awk '/MemTotal/ {t=$2}/MemAvailable/ {a=$2} END {if(t>0) printf(\"%d%%\", (t-a)/t*100); else print \"N/A\"}' /proc/meminfo 2>/dev/null || echo "N/A")
UP=$(awk '{print int($1)}' /proc/uptime 2>/dev/null || echo 0)
UPH=$(printf '%dd %02dh %02dm' $((UP/86400)) $((UP%86400/3600)) $((UP%3600/60)))

# top info line
echo -e "${MAG}●●●    [] Disk: ${GRN}${DF}${RST}  | RAM: ${YEL}${MEM}${RST}"
echo -e "${CYN}[] $(date '+%I:%M:%S %p | %Y-%b-%a — %d')   uptime: ${UPH}${RST}"
echo
# show ASCII logo (assets/logo.txt)
if [[ -f "$ASSETS/logo.txt" ]]; then
  cat "$ASSETS/logo.txt"
else
  # fallback small logo
  echo -e "${MAG}██╗   ██╗ ██████╗  ██████╗ ██╗  ██╗${RST}"
  echo -e "${MAG}╚██╗ ██╔╝██╔═══██╗██╔════╝ ╚██╗██╔╝${RST}"
  echo
fi
echo
# prompt preview
echo -e "\e[1;31m ┌─╼[\e[1;33m${YOGX_NAME}✈${YOGX_NAME}\e[1;31m]-[\e[1;36m~\e[1;31m]"
echo -e " └────╼ \e[1;92m❯❯❯ \e[0m"