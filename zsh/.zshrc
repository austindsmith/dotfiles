# -----------------------------------------------------------------------------
# Interactive-only Zsh init (safe for scp/rsync/non-interactive shells)
# -----------------------------------------------------------------------------

[[ -o interactive ]] || return

# -----------------------------------------------------------------------------
# Environment
# -----------------------------------------------------------------------------
export STARSHIP_CONFIG="${STARSHIP_CONFIG:-$HOME/.config/starship/starship.toml}"
export PATH="$HOME/.local/bin:$PATH"


# Hint to many tools that truecolor is supported (harmless if ignored)
export COLORTERM="${COLORTERM:-truecolor}"

alias semaphore='/usr/local/bin/sem'

# -----------------------------------------------------------------------------
# SSH TERM compatibility fix (prevents: "unknown terminal type xterm-kitty" on remote)
#
# Keep your local TERM as-is (kitty features locally), but when launching ssh from a
# modern terminal (kitty/alacritty/foot/ghostty), advertise a widely-supported TERM
# to the REMOTE side so it doesn't need xterm-kitty terminfo.
#
# Notes:
# - We do NOT force a TTY (-t). This stays safe for scripts.
# - If you want to bypass the fallback for a one-off, run:  TERM=xterm-kitty ssh ...
# -----------------------------------------------------------------------------
__ssh_term_fallback() {
  case "$TERM" in
    xterm-kitty|alacritty|foot|ghostty)
      env TERM="xterm-256color" COLORTERM="$COLORTERM" command ssh "$@"
      ;;
    *)
      command ssh "$@"
      ;;
  esac
}


# Kitty's ssh helper (kept as a convenience). Uses kitty if available, otherwise falls back.
kssh() {
  if command -v kitty >/dev/null 2>&1; then
    kitty +kitten ssh "$@"
  else
    __ssh_term_fallback "$@"
  fi
}


# -----------------------------------------------------------------------------
# Pywal: persist/apply colors on every interactive shell start
#
# This sets your terminal colors by emitting escape sequences.
# Requirements per-host:
# - ~/.cache/wal/sequences must exist on that host (run `wal ...` there, or sync it)
#
# tmux users: ensure truecolor in tmux.conf (see note after this block).
# -----------------------------------------------------------------------------
__apply_pywal() {
  # Only if stdout is a TTY and pywal sequences exist
  [[ -t 1 ]] || return 0

  local seq="$HOME/.cache/wal/sequences"
  local seq_alt="$HOME/.config/wal/sequences"  # optional: if you sync wal cache into config

  if [[ -f "$seq" ]]; then
    cat "$seq"
  elif [[ -f "$seq_alt" ]]; then
    cat "$seq_alt"
  fi
}
__apply_pywal

# -----------------------------------------------------------------------------
# Atuin shell history (guarded)
# -----------------------------------------------------------------------------
if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh)"
fi

# -----------------------------------------------------------------------------
# Completion system (with a cache dir)
# -----------------------------------------------------------------------------
autoload -Uz compinit

# Put zcompdump in XDG-ish cache location to avoid clutter and speed up init
_ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p "$_ZSH_CACHE_DIR"

# -C = skip recompilation check (faster); remove -C if you change functions a lot
compinit -d "$_ZSH_CACHE_DIR/zcompdump" -C
zmodload zsh/complist

# -----------------------------------------------------------------------------
# Shell integrations (guarded)
# -----------------------------------------------------------------------------
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

if command -v carapace >/dev/null 2>&1; then
  eval "$(carapace _carapace zsh)"
fi

# -----------------------------------------------------------------------------
# Plugins (guarded so this works across hosts)
# -----------------------------------------------------------------------------
if [[ -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/home/austin/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
