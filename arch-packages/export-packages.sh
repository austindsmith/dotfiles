#!/usr/bin/env bash
set -euo pipefail

# write outputs next to this script
SCRIPT_DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# explicitly-installed repo packages
pacman -Qqen | sort > "$SCRIPT_DIR/pkglist.txt"

# explicitly-installed AUR/foreign packages
pacman -Qqem | sort > "$SCRIPT_DIR/aurlist.txt"

echo "Wrote:"
echo "  $SCRIPT_DIR/pkglist.txt"
echo "  $SCRIPT_DIR/aurlist.txt"

