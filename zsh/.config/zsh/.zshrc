# -----------------------------------------------------------------------------
# Interactive-only Zsh init (safe for scp/rsync/non-interactive shells)
# -----------------------------------------------------------------------------
[[ -o interactive ]] || return

# -----------------------------------------------------------------------------
# Environment
# -----------------------------------------------------------------------------
export STARSHIP_CONFIG="${STARSHIP_CONFIG:-$HOME/.config/starship/starship.toml}"
export PATH="$HOME/.local/bin:$PATH"
export MPD_HOST="127.0.0.1"
export MPD_PORT="6600"

# Hint to many tools that truecolor is supported (harmless if ignored)
export COLORTERM="${COLORTERM:-truecolor}"

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
  # Only rewrite TERM for the ssh process when the local TERM is likely unsupported remotely.
  case "$TERM" in
    xterm-kitty|alacritty|foot|ghostty)
      env TERM="xterm-256color" COLORTERM="$COLORTERM" command ssh "$@"
      ;;
    *)
      command ssh "$@"
      ;;
  esac
}

# Override ssh in this shell only (drop-in: your muscle memory stays "ssh host")
ssh() { __ssh_term_fallback "$@"; }

# Kitty's ssh helper (kept as a convenience). Uses kitty if available, otherwise falls back.
kssh() {
  if command -v kitty >/dev/null 2>&1; then
    kitty +kitten ssh "$@"
  else
    __ssh_term_fallback "$@"
  fi
}

# Other aliases
alias neomutt='TERM=xterm-direct neomutt'

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
test
