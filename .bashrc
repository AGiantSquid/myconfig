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
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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

# Add git branch if its present to PS1
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Pretty colors are set here
if [ "$color_prompt" = yes ]; then
 PS1='${debian_chroot:+($debian_chroot)}'
 PS1="$PS1"'\n'                   # new line
 PS1="$PS1"'\[\033[1;30m\]'       # change to turquoise
 PS1="$PS1"'\u '                  # user<space>
 PS1="$PS1"'\[\033[95m\]'         # change to gray
 PS1="$PS1"'@debian `cat /etc/debian_version` '
 PS1="$PS1"'\[\033[33m\]'         # change to brownish yellow
 PS1="$PS1"'\w '                  # current working directory
 PS1="$PS1"'\[\033[01;32m\]$(parse_git_branch)\[\033[00m\]'
 PS1="$PS1"'\n'
 PS1="$PS1"'$ '                   # prompt: always $
else
 PS1='${debian_chroot:+($debian_chroot)}\u:\w$(parse_git_branch)\$ '
fi
unset color_prompt force_color_prompt

# Use this if you have custom DIR_COLORS
# `dircolors` prints out `LS_COLORS='...'; export LS_COLORS`, so eval'ing
# $(dircolors) effectively sets the LS_COLORS environment variable.
# eval "$(dircolors /etc/DIR_COLORS)"

# fix color of 'other writable' directory
LS_COLORS="ow=01;34;40" && export LS_COLORS


# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'
# needed to use git versioning on this file and others
alias config='/usr/bin/git --git-dir=/home/$USER/.myconfig/ --work-tree=/home/$USER'


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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




# Use these settings if using debian in WSL
if [ -d /c/Users ]; then
  export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
  export PATH="$PATH:/mnt/c/Program\ Files/Docker/Docker/resources/bin"

  # For xming, displaying debian gui programs in windows host
  export DISPLAY=localhost:0.0

  # Needed to run docker commands from Windows
  export DOCKER_HOST=localhost:2375

  alias sublime='"/c/Program Files/Sublime Text 3/sublime_text.exe"'
  alias home='cd /c/Users/$USER/; ls'
  alias green='cd /c/Users/$USER/GreenKey/; ls'
  alias scribe='cd /c/Users/$USER/GreenKey/scribe; ls'
else
  alias sublime='/usr/bin/subl'
  alias home='cd; ls'
  alias green='cd ~/GreenKey/; ls'
  alias scribe='cd ~/GreenKey/scribe; ls'
fi

alias d='docker'
alias dpa='docker ps -a'
function de() {
  docker exec -it "$1" bash
}
function des() {
  docker exec -it "$1" sh
}
function dk() {
  docker kill "$1"
}

# GreenKey related stuff, add in secret key manually
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export GKT_USERNAME=gkt
export GKT_SECRETKEY=
