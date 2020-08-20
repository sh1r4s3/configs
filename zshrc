# Prompt
export prompt='%F{green}%n%F{blue}[%2d]%F{green}%#%f '

# Aliases
alias g='git'
alias ls='ls -F --color'
alias grep='grep --color=auto'

export VANILLA_PATH="$PATH"
export PATH="$HOME/bin/:$PATH"

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

gen_password() {
    # Need to touch file manually.
    # How to use:
    #  gen_password <NAME OF RESOURCE>
    TO_LIST=/Volumes/garmr/arei/passwords/passwords
    [ -f "$TO_LIST" ] || { echo "No file $TO_LIST"; return 1; }
    PASSWORD="$(head -c 16 /dev/urandom | base64 | sed 's;^\([^=]*\).*;\1;g')"
    echo "$PASSWORD $1" >> "$TO_LIST"
    echo -n "$PASSWORD" | pbcopy
}

absname() {
  # $1 : relative filename
  [ -n "${1-}" ] || { echo "Usage: absname <filename>"; return 1 }
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

# Source third-party scripts
. $HOME/work/git/github/fzf/shell/completion.zsh
. $HOME/work/git/github/fzf/shell/key-bindings.zsh
