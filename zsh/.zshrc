#source /usr/share/cachyos-zsh-config/cachyos-config.zsh

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY SHARE_HISTORY
autoload -Uz compinit
compinit
zmodload zsh/complist

# Display setting for neomutt colors to work
alias neomutt='TERM=xterm-direct neomutt'

# zoxide
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"


# starship config file

# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /usr/bin/terraform terraform
eval "$(carapace _carapace zsh)"
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH="$HOME/.local/bin:$PATH"

# environment variables
# kubernetes
export KUBECONFIG=~/.kube/k3s.yaml

# mpd (for rmpc)
export MPD_HOST="127.0.0.1"
export MPD_PORT="6600"
