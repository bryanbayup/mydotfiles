# ~/.config/fish/config.fish

### Environment Variables ###

fastfetch
starship init fish | source

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx BROWSER qutebrowser
set -gx TERMINAL kitty

# Tambahkan PATH kustom
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH /usr/local/bin $PATH
set -gx PATH /opt/quarto/bin $PATH

# Pastikan terminal mendukung 24-bit colors (Kitty sudah mendukung)
set -gx TERM xterm-256color


### Alias & Abbreviations ###
alias ls='exa --icons --color=auto'
alias ll='exa -lah --icons'
alias grep='grep --color=auto'
alias v='nvim'
alias cat='bat'
alias find='fd'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias update='sudo pacman -Syu'
alias upgrade='paru -Syu'

abbr -a gco 'git checkout'
abbr -a gst 'git status'
abbr -a gcm 'git commit -m'
abbr -a gpl 'git pull'
abbr -a gps 'git push'


### Integrasi dengan Starship ###
if type -q starship
    starship init fish | source
end

function starship_transient_prompt_func
    starship module character
end

function starship_transient_rprompt_func
    starship module time
end

enable_transience


### Pengaturan Tambahan ###
# Aktifkan vi mode untuk navigasi yang cepat
fish_vi_key_bindings

# Fungsi: mkcd - Membuat direktori dan langsung masuk ke dalamnya
function mkcd
    mkdir -p $argv[1] && cd $argv[1]
end

# Fungsi: extract - Mengekstrak berbagai jenis file archive
function extract
    if test -f $argv[1]
        set mime_type (file --mime-type -b $argv[1])
        switch $mime_type
            case 'application/gzip'
                tar xzf $argv[1]
            case 'application/x-bzip2'
                tar xjf $argv[1]
            case 'application/x-xz'
                tar xJf $argv[1]
            case 'application/x-tar'
                tar xf $argv[1]
            case 'application/x-7z-compressed'
                7z x $argv[1]
            case 'application/zip'
                unzip $argv[1]
            case 'application/vnd.rar'
                unrar x $argv[1]
            case '*'
                echo "Unknown or unsupported format: $argv[1]"
        end
    else
        echo "File does not exist: $argv[1]"
    end
end


### Integrasi Zoxide ###
if type -q zoxide
    zoxide init fish | source
end
alias cd='z'


### Perintah Tambahan ###
# Gunakan bat sebagai default pager jika tersedia
if type -q bat
    set -gx PAGER bat
end

#fzf
set -gx FZF_DEFAULT_OPTS "
  --color fg:#5d6466,bg:#1e2527
  --color bg+:#ef7d7d,fg+:#2c2f30
  --color hl:#dadada,hl+:#26292a,gutter:#1e2527
  --color pointer:#373d49,info:#606672
  --border
  --color border:#1e2527
  --height 13"

function cdf
    if type -q fd
        set dir (fd --type d | fzf)
    else
        set dir (find . -type d | fzf)
    end
    if test -n "$dir"
        cd "$dir"
    end
end


