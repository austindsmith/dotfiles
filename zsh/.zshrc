# -----------------------------------------------------------------------------
# Interactive-only Zsh init (safe for scp/rsync/non-interactive shells)
# -----------------------------------------------------------------------------

[[ -o interactive ]] || return

# -----------------------------------------------------------------------------
# Environment
# -----------------------------------------------------------------------------
export STARSHIP_CONFIG="${STARSHIP_CONFIG:-$HOME/.config/starship/starship.toml}"
export PATH="$HOME/.local/bin:$PATH"


alias semaphore='/usr/local/bin/sem'
alias clip="kitten clipboard"

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

