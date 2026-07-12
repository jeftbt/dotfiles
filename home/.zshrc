# Clean & Minimal Zsh Configuration

# Path to your oh-my-zsh installation (if any)
# export ZSH="$HOME/.oh-my-zsh"

# Set history options
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_space

# Basic keybindings (using standard emacs mode keys)
bindkey -e

# Autocompletion
autoload -Uz compinit
compinit

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"     # Match color scheme

# Useful Aliases
alias ls="ls --color=auto"
alias ll="ls -lah"
alias l="ls -la"
alias grep="grep --color=auto"
alias ..="cd .."
alias ...="cd ../.."
alias c="clear"
alias h="history"
alias ff="clear && fastfetch"

# Git Aliases
alias gs="git status"
alias gd="git diff"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gl="git log --oneline -n 10"

# Package Manager Shortcut
alias yay-install="yay -S"
alias yay-update="yay -Syu"
alias yay-remove="yay -Rns"

# Environment Variables
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Initialize Starship Prompt (if installed)
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
else
    # Simple backup prompt if starship is not installed
    PROMPT="%F{cyan}%n%f@%F{blue}%m%f:%F{green}%~%f$ "
fi

# Plugins (installed via pacman/yay)
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
export PATH=$PATH:~/.spicetify
