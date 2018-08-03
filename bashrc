# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    export GITAWAREPROMPT=~/.bash/git-aware-prompt
    source "${GITAWAREPROMPT}/main.sh"
    PS1="\[\033[38;5;6m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\] @ \[$(tput sgr0)\]\[\033[38;5;34m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\]: \[$(tput sgr0)\]\[\033[38;5;3m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]: \[$(tput sgr0)\]\[\033[38;5;117m\]\$git_branch\[$(tput sgr0)\]:\n\$ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash/bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f "$HOME/.bash/bash_aliases" ]]; then
    source "$HOME/.bash/bash_aliases"
fi

# Functions
if [[ -f "$HOME/.bash/bash_functions" ]]; then
    source "$HOME/.bash/bash_functions"
fi

# Enhance search function
if [[ -f "$HOME/.bash/bash_find_utils" ]]; then
    source "$HOME/.bash/bash_find_utils"
fi

# Process management
if [[ -f "$HOME/.bash/bash_proceses" ]]; then
    source "$HOME/.bash/bash_proceses"
fi

# Networking
if [[ -f "$HOME/.bash/bash_networking" ]]; then
    source "$HOME/.bash/bash_networking"
fi


#   ---------------------------------------
#   5.  DEVELOPMENT
#   ---------------------------------------
if [[ -f "$HOME/.bash/develop_tools" ]]; then
    source "$HOME/.bash/develop_tools"
fi

#   5.1 ORACLE DB
if [[ -f "$HOME/.bash/develop_oracle" ]]; then
    source "$HOME/.bash/develop_oracle"
fi

#   5.2 WEB DEVELOPMENT
if [[ -f "$HOME/.bash/develop_web" ]]; then
    source "$HOME/.bash/develop_web"
fi

#   5.3 DEVELOPMENT PYTHON
if [[ -f "$HOME/.bash/develop_python" ]]; then
    source "$HOME/.bash/develop_python"
fi

#   5.4 DEVELOPMENT GO
if [[ -f "$HOME/.bash/develop_go" ]]; then
    source "$HOME/.bash/develop_go"
fi

#   ---------------------------
#   4.  If System is not Linux. MacOS
#   ---------------------------
#if [ $OS != "Linux" ]; then
#  . ~/.bash/bash_not_linux
#fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
