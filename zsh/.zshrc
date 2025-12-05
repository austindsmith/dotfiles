
# Use this file to store Zsh command history
eval "$(atuin init zsh)"

# Load and initialize Zsh’s completion system
autoload -Uz compinit
compinit

# Load the Zsh module that provides advanced completion-list behavior
zmodload zsh/complist

# Always run neomutt with TERM=xterm-direct so colors and UI behave correctly
alias neomutt='TERM=xterm-direct neomutt'

# Use this Starship configuration file instead of the default
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# Initialize zoxide (smart cd replacement) for Zsh
eval "$(zoxide init zsh)"

# Initialize the Starship prompt for Zsh
eval "$(starship init zsh)"

# Enable Carapace for richer shell completions for many CLI tools
eval "$(carapace _carapace zsh)"

# Enable Zsh plugin: suggests command completions as you type, based on history
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Enable Zsh plugin: colors your command line to show valid/invalid syntax, etc.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# (Duplicate) autosuggestions plugin load – functionally redundant
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# (Duplicate) syntax-highlighting plugin load – functionally redundant
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Add ~/.local/bin to the front of PATH so your local scripts/tools are found first
export PATH="$HOME/.local/bin:$PATH"

# Default kubeconfig file for kubectl and other Kubernetes tools
export KUBECONFIG=~/.kube/k3s.yaml

# Default host and port for MPD clients (like rmpc / ncmpcpp) to connect to MPD
export MPD_HOST="127.0.0.1"
export MPD_PORT="6600"

#
export KUBECONFIG=~/.kube/config

case "$TERM" in
    xterm-kitty|tmux-256color|alacritty|foot|ghostty)
        TERM=xterm-256color
        export TERM
        ;;
esac


alias kssh='kitty +kitten ssh'
