set -euo pipefail

cfg="$HOME/.config/chezmoi/chezmoi.toml"
choice="${1:-}"

if [[ -z "$choice" ]]; then
  choice=$(chezmoi data | jq -r '.themes | keys[]' | fzf --prompt="theme> ")
fi

chezmoi data | jq -e --arg t "$choice" '.themes | has($t)' >/dev/null

sed -i "s/^theme_active = .*/theme_active = \"$choice\"/" "$cfg"
chezmoi apply
