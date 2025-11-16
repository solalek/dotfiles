########################################
# 🚀 Powerlevel10k Instant Prompt
########################################
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

########################################
# 🎨 LS_COLORS
########################################
eval "$(dircolors -b)"

########################################
# 🔌 Zinit Initialization
########################################
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "$ZINIT_HOME/zinit.zsh"

# Core plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
# zinit light marlonrichert/zsh-autocomplete
zinit light Aloxaf/fzf-tab

# Oh-My-Zsh plugin snippets
for plugin in git sudo archlinux aws kubectl kubectx command-not-found; do
  zinit snippet "OMZP::$plugin"
done

# Replays previously loaded plugins (useful for zinit)
autoload -U compinit && compinit
zinit cdreplay -q

########################################
# ⚙️ Completion & FZF-tab
########################################
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*:*:*:*:*' file-sort name
zstyle ':completion:*:*:*:*:*' tag-order local-directories
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=auto $realpath'

########################################
# 🎨 Powerlevel10k config
########################################
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

########################################
# 🧠 History Settings
########################################
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

########################################
# 🔈 General Settings
########################################
setopt correct
setopt no_beep

########################################
# ⌨️ Custom ZLE Widgets & Keybindings
########################################

# Open current command in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# Clear screen and execute
function clear-and-accept {
    clear
    zle accept-line
}
zle -N clear-and-accept
bindkey '^y' clear-and-accept

# editing enhancements
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^l' forward-char
bindkey '^h' backward-char
bindkey '^k' beginning-of-line
bindkey '^j' end-of-line

########################################
# 📦 Aliases
########################################
alias ls='lsd'
alias la='lsd -a'
alias ll='lsd -l'
alias lla='lsd -la'
alias pip=~/venv/bin/pip
alias python=~/venv/bin/python3
alias get-weather='~/venv/bin/python3 ~/.local/bin/get-weather.py'
alias quit='disown -a && exit'
alias pkill='ps aux | fzf --height 40% --layout=reverse --prompt="Select process to kill: " | awk '\''{print $2}'\'' | xargs -r sudo kill'
alias sstart='sudo systemctl start'
alias sstop='sudo systemctl stop'
alias srestart='sudo systemctl restart'
alias sstatus='sudo systemctl status'
alias senble='sudo systemctl enable'
alias sdisable='sudo systemctl disable'
alias thm='sudo openvpn ~/vpn/alexandr.solomin.ovpn'
alias nvim='~/.local/bin/edit.sh'

########################################
# 🛠️ Tool Initializations
########################################
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

export EDITOR=nvim
