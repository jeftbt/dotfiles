# ==============================================================================
# ULTIMATE & FAST ZSH CONFIGURATION
# ==============================================================================

# 1. History (Geçmiş) Ayarları
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000

setopt appendhistory          # Geçmişi dosyaya ekleyerek kaydet
setopt sharehistory           # Açık olan tüm terminaller arasında geçmişi anlık paylaş
setopt hist_ignore_all_dups   # Mükerrer komutları geçmişe tekrar kaydetme
setopt hist_ignore_space      # Başında boşluk bırakarak yazılan komutları geçmişe kaydetme
setopt hist_reduce_blanks     # Komutlardaki gereksiz boşlukları temizleyip kaydet
setopt hist_expire_dups_first # Geçmiş dolduğunda önce mükerrerleri sil
setopt hist_find_no_dups      # Arama yaparken mükerrer sonuç getirme
export HISTORY_IGNORE="(\&|[bf]g|c|clear|history|exit|q|pwd|* --help)"

# 2. Akıllı Zsh Davranış Seçenekleri
setopt autocd                 # 'cd' yazmadan sadece klasör adı yazarak dizine geç
setopt auto_pushd             # Gezilen dizinleri hafızada tut (cd - ile geri dönülebilir)
setopt pushd_ignore_dups      # Dizin geçmişine mükerrer kayıt ekleme
setopt pushd_silent           # pushd/popd yaparken dizin listesini basma
setopt interactive_comments   # Terminalde '#' ile başlayan yorum satırlarını kabul et

# 3. Tuş Atamaları & Akıllı Ok Araması
bindkey -e
bindkey '^[[H' beginning-of-line  # Home tuşu
bindkey '^[[F' end-of-line        # End tuşu
bindkey '^[[3~' delete-char       # Delete tuşu

# Yazılan kelimeye göre Yukarı/Aşağı ok tuşlarıyla geçmiş arama
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# 4. Gelişmiş Tamamlama (Completion) Sistemi
autoload -Uz compinit
setopt extendedglob # (#q...) glob belirteci için gerekli

# Performans optimizasyonu: compinit'i günde sadece bir kez sıfırdan tara
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.m+1) ]]; then
  compinit
else
  compinit -C
fi

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Büyük/küçük harf duyarsız tamamlama
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"     # ls renk düzeniyle tamamlama menüsü
zstyle ':completion:*' menu select                         # Ok tuşlarıyla seçilebilir menü

# fzf-tab Eklentisi (Tab menüsünü FZF menüsüne çevirir - compinit'ten sonra yüklenmeli)
if [ -f /usr/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh ]; then
    source /usr/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

    # fzf-tab Önizleme ve Davranış Ayarları
    zstyle ':fzf-tab:*' switch-group ',' '.'
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons=auto $realpath 2>/dev/null'
    zstyle ':fzf-tab:complete:(\\|*/|)(bat|cat|hx|helix):*' fzf-preview 'bat --style=numbers --color=always --line-range :300 $realpath 2>/dev/null'
    zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word 2>/dev/null'
    zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w 2>/dev/null'
    zstyle ':fzf-tab:complete:*:*' fzf-preview 'if [ -d "$realpath" ]; then eza -1 --color=always --icons=auto "$realpath" 2>/dev/null; elif [ -f "$realpath" ]; then bat --style=numbers --color=always --line-range :300 "$realpath" 2>/dev/null; fi'
fi

# 5. Ortam Değişkenleri & PATH
export EDITOR="helix"
export VISUAL="helix"
export PAGER="less"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Renkli man sayfaları
export LESS_TERMCAP_md="$(tput bold 2> /dev/null; tput setaf 2 2> /dev/null)"
export LESS_TERMCAP_me="$(tput sgr0 2> /dev/null)"

typeset -U path # PATH içinde mükerrer kayıt oluşmasını engeller
path=(
  "$HOME/.local/bin"
  "$HOME/.spicetify"
  "$HOME/.local/share/fnm"
  $path
)
export PATH

# 6. Alias'lar & Modern Araç İkameleri
alias hx="helix"
alias sudo='sudo '
alias movie="moviebox-tui"

# Yazi (Çıkışta dizin değiştirme destekli)
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}
alias c="clear"
alias h="history"
alias ff="clear && fastfetch"
alias matrix="unimatrix -c cyan -s 95"
alias 01="rustrix-term --color cyan --chars binary --speed 10.0"
alias grep="grep --color=auto"
alias ..="cd .."
alias ...="cd ../.."

# eza (ls ikamesi) varsa kullan, yoksa standart ls
if command -v eza &>/dev/null; then
    alias ls="eza --icons=auto"
    alias ll="eza -l --icons=auto --git"
    alias l="eza -la --icons=auto --git"
    alias tree="eza --tree --icons=auto"
else
    alias ls="ls --color=auto"
    alias ll="ls -lah"
    alias l="ls -la"
fi

# bat (cat ikamesi) varsa kullan
if command -v bat &>/dev/null; then
    alias cat="bat --style=plain"
fi

# Git & Paket Yöneticisi Alias'ları
alias gs="git status"
alias gd="git diff"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gl="git log --oneline -n 10"

# Paru (Paket Yöneticisi) Tek Harf Alias'ları
alias p="paru"               # Paru ana komutu (Parametresiz: Güncelleme / İsimle: Arama & Kurulum)
alias i="paru -S"           # Paket kur (Install)
alias u="arch-update"         # Tüm sistemi güncelle (Update)
alias s="paru -Ss"          # Depolarda ve AUR'da ara (Search)
alias r="paru -Rns"         # Paketi artık bırakmadan sil (Remove)
alias q="paru -Qs"          # Kurulu paketler arasında ara (Query)

alias power="powerprofilesctl"
alias power1="powerprofilesctl set power-saver"
alias power2="powerprofilesctl set balanced"
alias power3="powerprofilesctl set performance"

# Rust
alias cg="cargo"
alias cgr="cargo run"
alias cga="cargo add"
alias cgn="cargo new"

# Derleme (Tüm çekirdekleri kullanarak hızlı derleme)
alias make="make -j\$(nproc)"
alias ninja="ninja -j\$(nproc)"

# Sistem Kısayolları
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias jctl="journalctl -p 3 -xb"
alias tb="nc termbin.com 9999"

# Sessiz, Hızlı ve Kapsamlı Sistem Temizliği
sysclean() {
    # Zsh onay sorularını ve 'no matches found' hatasını engelle
    setopt localoptions rmstarsilent nullglob

    # 1. Yetim paket temizliği
    [ -n "$(pacman -Qtdq 2>/dev/null)" ] && sudo pacman -Rns $(pacman -Qtdq) --noconfirm &>/dev/null
    # 2. Pacman & Paru önbellek temizliği
    command -v paccache &>/dev/null && sudo paccache -r -k2 &>/dev/null && sudo paccache -uk0 &>/dev/null
    command -v paru &>/dev/null && paru -Sc --noconfirm &>/dev/null
    # 3. Sistem log temizliği
    sudo journalctl --vacuum-size=100M &>/dev/null
    # 4. Flatpak kullanılmayan paketler
    command -v flatpak &>/dev/null && flatpak uninstall --unused -y &>/dev/null
    # 5. Çöp Kutusu temizliği
    rm -rf ~/.local/share/Trash/* &>/dev/null
    # 6. Kırık sembolik bağlantıları silme
    find ~ -xtype l -delete &>/dev/null
    # 7. Geliştirici önbellekleri (npm, pnpm, yarn, pip, go)
    command -v npm &>/dev/null && npm cache clean --force &>/dev/null
    command -v pnpm &>/dev/null && pnpm store prune &>/dev/null
    command -v yarn &>/dev/null && yarn cache clean &>/dev/null
    command -v pip &>/dev/null && pip cache purge &>/dev/null
    command -v go &>/dev/null && go clean -cache &>/dev/null
    # 8. Kullanıcı resim & uygulama önbellekleri
    rm -rf ~/.cache/thumbnails/* ~/.cache/yay/* ~/.cache/paru/* &>/dev/null
}


# 7. Modern CLI Entegrasyonları (Zoxide & FZF)
# Zoxide (cd ikamesi / akıllı dizin zıplama)
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
    alias cd="z"
fi

# FZF (Geçmiş araması ve bulanık arama)
if [ -f /usr/share/fzf/key-bindings.zsh ]; then
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
    # Alt tuşu Super (Pencereler) tuşuna atandığı için Alt kısayolunu (Alt+C) iptal ediyoruz
    bindkey -r '\ec' 2>/dev/null
    bindkey -r '^[c' 2>/dev/null

    # fd varsa FZF için varsayılan komut olarak ayarla (Hızlı ve .gitignore uyumlu)
    if command -v fd &>/dev/null; then
        export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="fd --type d --strip-cwd-prefix --hidden --follow --exclude .git"
    fi

    # FZF Görsel & Önizleme Seçenekleri (Ctrl+T ve Ctrl+R)
    export FZF_DEFAULT_OPTS="--height 45% --layout=reverse --border --inline-info --prompt='❯ '"
    export FZF_CTRL_T_OPTS="--preview 'if [ -d {} ]; then eza --tree --level=2 --color=always --icons=auto {} 2>/dev/null; else bat --style=numbers --color=always --line-range :300 {} 2>/dev/null; fi' --preview-window right:55%:wrap"
    export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
fi

# 8. Prompt (Starship entegrasyonu & Yedek Prompt)
if command -v starship &>/dev/null; then
    export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
    eval "$(starship init zsh)"
else
    PROMPT='%F{cyan}%n%f@%F{blue}%m%f:%F{green}%~%f$ '
fi

# 9. Sistem Eklentileri & Araçlar
# fnm (Node.js Versiyon Yöneticisi)
if command -v fnm &>/dev/null || [ -d "$HOME/.local/share/fnm" ]; then
  eval "$(fnm env --shell zsh)"
fi

# Otomatik Öneri (Autosuggestions)
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# pkgfile "command not found" yardımcısı
if [ -f /usr/share/doc/pkgfile/command-not-found.zsh ]; then
    source /usr/share/doc/pkgfile/command-not-found.zsh
fi

# Sözdizimi Renklendirme (Syntax Highlighting - En sonda yer almalı)
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
export PATH="$HOME/.cargo/bin:$PATH"
