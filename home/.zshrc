# ==============================================================================
# MINIMAL & FAST ZSH CONFIGURATION
# ==============================================================================

# 1. History (Geçmiş) Ayarları
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt appendhistory          # Geçmişi dosyaya ekleyerek kaydet
setopt sharehistory           # Açık olan tüm terminaller arasında geçmişi anlık paylaş
setopt hist_ignore_all_dups   # Mükerrer komutları geçmişe tekrar kaydetme
setopt hist_ignore_space      # Başında boşluk bırakarak yazılan komutları geçmişe kaydetme
setopt hist_reduce_blanks     # Komutlardaki gereksiz boşlukları temizleyip kaydet

# 2. Tuş Atamaları (Emacs / Standart Mod)
bindkey -e
bindkey '^[[H' beginning-of-line  # Home tuşu
bindkey '^[[F' end-of-line        # End tuşu
bindkey '^[[3~' delete-char       # Delete tuşu

# 3. Gelişmiş Tamamlama (Completion) Sistemi
autoload -Uz compinit
# Performans optimizasyonu: compinit'i günde sadece bir kez sıfırdan tara
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.m+1) ]]; then
  compinit
else
  compinit -C
fi

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Büyük/küçük harf duyarsız tamamlama
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"     # ls renk düzeniyle tamamlama menüsü
zstyle ':completion:*' menu select                         # Ok tuşlarıyla seçilebilir menü

# 4. Ortam Değişkenleri (Environment Variables)
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# PATH Güncellemeleri (Spicetify ve yerel ikilik dosyalar dahil)
typeset -U path # PATH içinde mükerrer kayıt oluşmasını engeller
path=(
  "$HOME/.local/bin"
  "$HOME/.spicetify"
  $path
)
export PATH

# 5. Temel Alias'lar
alias ls="ls --color=auto"
alias ll="ls -lah"
alias l="ls -la"
alias grep="grep --color=auto"
alias ..="cd .."
alias ...="cd ../.."
alias c="clear"
alias h="history"
alias ff="clear && fastfetch"

# Git & Paket Yöneticisi Alias'ları
alias gs="git status"
alias gd="git diff"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gl="git log --oneline -n 10"

alias pi="sudo pacman -S"
alias ps="sudo pacman -Ss"
alias pr="sudo pacman -Rns"
alias pu="sudo pacman -Syu"

alias yi="yay -S"
alias ys="yay -Ss"
alias yr="yay -Rns"
alias yu="yay -Syu"

alias power="powerprofilesctl"
alias psaver="powerprofilesctl set power-saver"
alias pbalanced="powerprofilesctl set balanced"
alias pmax="powerprofilesctl set performance"

alias sysclean="sudo pacman -Rns \$(pacman -Qtdq 2>/dev/null) --noconfirm 2>/dev/null; yay -Sc --noconfirm"

# 6. Prompt (Starship entegrasyonu & Yedek Prompt)
if command -v starship &>/dev/null; then
    export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
    eval "$(starship init zsh)"
else
    PROMPT='%F{cyan}%n%f@%F{blue}%m%f:%F{green}%~%f$ '
fi

# 7. Sistem Eklentileri (Pacman/Yay ile kurulu olanlar)
# Otomatik Öneri (Autosuggestions)
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Sözdizimi Renklendirme (Syntax Highlighting - Her zaman en sonda yüklenmeli)
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
export PATH="$HOME/path/to/helix/directory:$PATH"
alias hx='helix'
