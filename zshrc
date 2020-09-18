# Prompt
export prompt='%F{green}%n@%m%F{blue}[%2d]%F{green}%#%f '

# Get OS type
export OS_TYPE="$(uname)"

# Save system PATH
export SAVED_PATH="$PATH"

# Common aliases
alias g='git'
alias grep='grep --color=auto'

# OS depended aliases
case "$OS_TYPE" in
    "Darwin")
        alias ls='ls -G -F'
        ;;
    "Linux")
        alias ls='ls --color=auto -F'
        ;;
esac

# Alt+Backspace and Ctrl+w behaviour like in bash
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

__cdg_paths_echo() {
    local system_wide_filelist=''
    local user_filelist=''

    if [ -r /etc/cdg_paths ]; then
        system_wide_filelist=$(cat /etc/cdg_paths)
    fi
    if [ -r ~/.cdg_paths ]; then
        user_filelist=$(cat ~/.cdg_paths)
    fi

    echo -e "$system_wide_filelist\n$user_filelist" | sed '/^\s*$/d'
}

bm() {
    local curr_dir="${PWD} # $*"
    if [ ! -r ~/.cdg_paths ] || ! grep -Fxq "$curr_dir" ~/.cdg_paths; then
        echo "$curr_dir" >> ~/.cdg_paths
    fi
}

cdg() {
   local dest_dir=$(__cdg_paths_echo | fzf | sed 's/ #.*//g')
   if [[ $dest_dir != '' ]]; then
      cd $dest_dir
   fi
}

ytfm() { # YOUTUBE FM :DDD
    mpv --no-video ytdl://ytsearch10:"$@";
}

absname() {
  # $1 : relative filename
  [ -n "${1-}" ] || { echo "Usage: absname <filename>"; return 1 }
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

# Source local specific config
[ ! -f "$HOME/.zshrc.local" ] || source "$HOME/.zshrc.local"
