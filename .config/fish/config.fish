# ~/.config/fish/config.fish

### Environment Variables ###
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx BROWSER qutebrowser
set -gx TERMINAL kitty

# Tambahkan PATH kustom
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH /usr/local/bin $PATH

#python
#set -x VIRTUAL_ENV /home/bayu/.virtualenvs/neovim
#set -x VIRTUAL_ENV /home/bayu/belajar/project/.env
set -gx PATH /opt/quarto/bin $PATH
# Pastikan terminal mendukung 24-bit colors (Kitty sudah mendukung)
set -gx TERM xterm-256color


### Alias & Abbreviations ###
alias ls='ls --color=auto'
alias ll='ls -lah'
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
# Pastikan Starship sudah terinstal dan file konfigurasi (~/.config/starship.toml) berisi
# konfigurasi seperti yang telah Anda lampirkan.
if type -q starship
    starship init fish | source
end

# Jika Anda ingin mengaktifkan fitur transient prompt (opsional), Anda dapat mendefinisikan fungsi-fungsi berikut:
function starship_transient_prompt_func
    starship module character
end

function starship_transient_rprompt_func
    starship module time
end

# Aktifkan transience (prompt sebelumnya akan digantikan sesuai fungsi di atas)
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
        switch $argv[1]
            case '*.tar.bz2'
                tar xjf $argv[1]
            case '*.tar.gz'
                tar xzf $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.rar'
                unrar x $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.tar'
                tar xf $argv[1]
            case '*.tbz2'
                tar xjf $argv[1]
            case '*.tgz'
                tar xzf $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.7z'
                7z x $argv[1]
            case '*'
                echo "Unknown format: $argv[1]"
        end
    else
        echo "File does not exist: $argv[1]"
    end
end
