# Paths and Environment Setup
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:/usr/local/go/bin:/home/jashan/.local/share/fnm:$PATH"
export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
export PATH=/home/jsb/.jdks/openjdk-23.0.1/bin:$PATH
eval "$(brew shellenv)"
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Initialize Plugins
eval "$(starship init zsh)"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source /etc/zsh_command_not_found



# Completion and History Settings
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"


# Key Bindings
bindkey '^[[1;5A' history-substring-search-up # CTRL + Up Arrow 
bindkey '^[[1;5B' history-substring-search-down # CTRL + Down Arrow
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word


#History Settings
HISTSIZE=6000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

# Aliases
alias ll='eza -al --group-directories-first'
alias ls='eza -G --color=always --sort=size'
alias la='eza -a --color=always'
alias l='eza -xa --color=always --sort=size'
alias nv='nvim'
alias web='python3 -m http.server'
alias nf='neofetch'
alias btop='btop --utf-force'
alias vim='nvim'
alias bat='batcat'
alias upgrade='sudo apt update && sudo apt upgrade'
alias kittyupdate='curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin'
alias lg='lazygit'

# Colorful man pages
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[30;43m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;32m'

#Bat theme
export BAT_THEME="Catppuccin Mocha"


# Functions
mkcd() {
  mkdir -p "$1" && cd "$1"
}

extract() {
  for archive in "$@"; do
    if [ -f "$archive" ]; then
      case $archive in
        *.tar.bz2)   tar xvjf "$archive" ;;
        *.tar.gz)    tar xvzf "$archive" ;;
        *.bz2)       bunzip2 "$archive" ;;
        *.rar)       unrar x "$archive" ;;
        *.gz)        gunzip "$archive" ;;
        *.tar)       tar xvf "$archive" ;;
        *.tbz2)      tar xvjf "$archive" ;;
        *.tgz)       tar xvzf "$archive" ;;
        *.zip)       unzip "$archive" ;;
        *.Z)         uncompress "$archive" ;;
        *.7z)        7z x "$archive" ;;
        *)           echo "Unknown file type: '$archive'" ;;
      esac
    else
      echo "'$archive' is not a valid file!"
    fi
  done
}

cpp() {
  set -e
  strace -q -ewrite cp -- "$1" "$2" 2>&1 | awk '
    {
      count += $NF
      if (count % 10 == 0) {
        percent = count / total_size * 100
        printf "%3d%% [", percent
        for (i = 0; i <= percent; i++)
          printf "="
        printf ">"
        for (i = percent; i < 100; i++)
          printf " "
        printf "]\r"
      }
    }
    END { print "" }
  ' total_size="$(stat -c '%s' "$1")" count=0
}

cpg() {
  if [ -d "$2" ]; then
    cp "$1" "$2" && cd "$2"
  else
    cp "$1" "$2"
  fi
}

mvg() {
  if [ -d "$2" ]; then
    mv "$1" "$2" && cd "$2"
  else
    mv "$1" "$2"
  fi
}

mkdirg() {
  mkdir -p "$1" && cd "$1"
}


netinfo() {
  echo "--------------- Network Information ---------------"
  /sbin/ifconfig | awk '/inet / {print $2}'
  echo ""
  /sbin/ifconfig | awk '/Bcast/ {print $3}'
  echo ""
  /sbin/ifconfig | awk '/inet / {print $4}'
  /sbin/ifconfig | awk '/HWaddr/ {print $4, $5}'
  echo "---------------------------------------------------"
}

whatsmyip() {
  if [ -e /sbin/ip ]; then
    echo -n "Internal IP: " ; /sbin/ip addr show wlan0 | grep "inet " | awk '{print $2}'
  else
    echo -n "Internal IP: " ; /sbin/ifconfig wlan0 | grep "inet " | awk '{print $2}'
  fi
  echo -n "External IP: " ; curl -s ifconfig.me
}

mysqlconfig() {
  local config_files=(
    /etc/my.cnf
    /etc/mysql/my.cnf
    /usr/local/etc/my.cnf
    /usr/bin/mysql/my.cnf
    ~/my.cnf
    ~/.my.cnf
  )
  for file in "${config_files[@]}"; do
    if [ -f "$file"]; then
      sedit "$file"
      return
    fi
  done
  echo "Error: my.cnf file could not be found."
  echo "Searching for possible locations:"
  sudo updatedb && locate my.cnf
}


gcom() {
  git add .
  git commit -m "$1"
}


#setup autojump
if [ -f "/home/jsb/Personal/autojump/bin/autojump.zsh" ]; then
    source /home/jsb/Personal/autojump/bin/autojump.zsh
fi


# Set default editor and terminal
export EDITOR="nvim"
export TERMINAL="kitty"

