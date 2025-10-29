#!/usr/bin/env bash
# ======================================================
# 🧩 YogX Utilities (shared functions)
# ======================================================

show_logo() {
  python3 - <<EOF | lolcat
from pyfiglet import Figlet
import time
f = Figlet(font='ANSI Shadow')
for line in f.renderText("YogX").split("\n"):
    print(line)
    time.sleep(0.02)
EOF
}

show_sysinfo() {
  echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | lolcat
  echo -e "📅 Date: $(date +"%A, %d %b %Y — %I:%M:%S %p")"
  echo -e "💾 Storage: $(df -h | grep /data | awk '{print $4 " Free"}')"
  echo -e "🔋 Battery: $(termux-battery-status | grep percentage | awk '{print $2}' | tr -d ',')%"
  echo -e "🕹️ Uptime: $(uptime -p)"
  echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | lolcat
}

show_tips() {
  local tips_file=~/YogX/core/tips.txt
  [ -f "$tips_file" ] || return
  local line=$(shuf -n 1 "$tips_file")
  echo -e "\n💡 Tip: $line\n" | lolcat
}

set_prompt() {
  PS1="\[\033[1;31m\]┌─[\[\033[1;37m\]\T\[\033[1;31m\]]───\e[1;93m[YogX]\e[0;31m───[\#]\n└─[\[\033[0;35m\]\W\[\033[0;31m\]]──► \[\033[1;92m\]"
  export PS1
}