# Prompt
if [ "$UID" = "0" ]; then
	export prompt='%B%F{red}%n%b%F{green}@%m%F{blue}[%2d]%F{green}%#%f '
else
	export prompt='%F{green}%n@%m%F{blue}[%2d]%F{green}%#%f '
fi

# Set window title for XTerm
# Ref: https://www.xfree86.org/current/ctlseqs.html
parent="$(awk '/^Name:/{print $2}' /proc/$PPID/status)"
parent="${parent##*/}"
case "$parent" in
    xterm|sshd)
        echo -n "\033];$USER\007" ;;
esac

# Get OS type
export OS_TYPE="$(uname)"

# Save system PATH
export SAVED_PATH="$PATH"

# Setup default editor
export EDITOR=vim

# Add GPG_TTY for pinentry programs
export GPG_TTY=$(tty)

# History
HISTFILE=~/.zsh.history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Fix LS_COLORS for some distros
eval $(dircolors)

# Common aliases
alias g='git'
alias grep='grep --color=auto'

# TMPDIR
[ -n "${TMPDIR-}" ] || export TMPDIR=/tmp

# OS depended aliases
case "$OS_TYPE" in
    "Darwin")
        alias ls='ls -G -F'
        ;;
    "Linux")
        alias ls='ls --color=auto -F'
        ;;
esac

bindkey -e

# Stop backward-kill-word on directory delimiter
autoload -U select-word-style
select-word-style bash

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
  # for systems without proper GNU readlink...
  # $1 : relative filename
  [ -n "${1-}" ] || { echo "Usage: absname <filename>"; return 1 }
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

add2path() {
    if [ -n "${PATH:-}" ]; then
        echo "$PATH" | tr ':' '\n' | grep -Fxq "$1" || export PATH="$PATH:$1"
    else
        export PATH="$1"
    fi
}

add2ldpath() {
    if [ -n "${LD_LIBRARY_PATH:-}" ]; then
        echo "$LD_LIBRARY_PATH" | tr ':' '\n' | grep -Fxq "$1" || export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$1"
    else
        export LD_LIBRARY_PATH="$1"
    fi
}

# Add supplementary directories to PATH
add2path "/usr/sbin"
add2path "/sbin"
add2path "$HOME/bin"

# Enable completion
autoload -U compinit; compinit

# Source local specific config
case "$OS_TYPE" in
    "Darwin")
        [ ! -f "$HOME/.zshrc-local/darwin" ] || source "$HOME/.zshrc-local/darwin"
        ;;
    "Linux")
        [ ! -f "$HOME/.zshrc-local/linux" ] || source "$HOME/.zshrc-local/linux"
        ;;
esac
