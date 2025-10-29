#!/usr/bin/env bash
# core/generate_ascii.sh
# Generate ASCII art using pyfiglet (safe, offline-friendly)
# Usage: ./generate_ascii.sh "YogX"  OR  generate_ascii.sh       (defaults to "YogX")

set -euo pipefail

TEXT="${1:-YogX}"
OUT_DIR="${2:-$HOME/YogX/assets}"
OUT_FILE="$OUT_DIR/logo.txt"
PYTHON_BIN="$(command -v python3 || command -v python || true)"
PIP_CMD="$(command -v pip3 || command -v pip || true)"

mkdir -p "$OUT_DIR"

# Ensure python available
if [[ -z "$PYTHON_BIN" ]]; then
  echo "Python not found. Installing python..."
  if command -v pkg >/dev/null 2>&1; then
    pkg install -y python
  else
    sudo apt install -y python3
  fi
  PYTHON_BIN="$(command -v python3 || command -v python)"
fi

# Ensure pyfiglet installed
if ! "$PYTHON_BIN" -c "import pyfiglet" >/dev/null 2>&1; then
  echo "pyfiglet not found. Installing..."
  if [[ -n "$PIP_CMD" ]]; then
    "$PIP_CMD" install --user pyfiglet >/dev/null 2>&1 || "$PIP_CMD" install pyfiglet >/dev/null 2>&1 || true
  else
    # try pip via python -m pip
    "$PYTHON_BIN" -m pip install --user pyfiglet >/dev/null 2>&1 || "$PYTHON_BIN" -m pip install pyfiglet >/dev/null 2>&1 || true
  fi
fi

# Generate ASCII using pyfiglet; prefer 'shadow' font (close to ANSI Shadow)
"$PYTHON_BIN" - <<PYCODE > "$OUT_FILE"
from pyfiglet import Figlet
f = Figlet(font='shadow')   # 'shadow' is common; fallback to 'standard' if missing
try:
    print(f.renderText("$TEXT"))
except Exception:
    f = Figlet(font='standard')
    print(f.renderText("$TEXT"))
PYCODE

echo "Generated ASCII -> $OUT_FILE"