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
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/' ;
}

# check if we are using a linux distro
if [ "$OSTYPE" = "linux-gnu" ] && [ -f /etc/debian_version ]; then
    # change to magenta
    PLATFORM="\[\033[95m\]@debian `cat /etc/debian_version`"
elif [ "${OSTYPE:0:9}" = "linux-gnu" ]; then
    # change to magenta
    PLATFORM="\[\033[95m\]@linux"
else
    # change to red
    PLATFORM="\[\033[31m\]@windows"
fi

# setup colors for prompt
cyan='\[\033[1;36m\]'
gray='\[\033[1;30m\]'
magenta='\[\033[95m\]'
yellow='\[\033[33m\]'
green='\[\033[01;32m\]'
white='\[\033[00m\]'

echo "$(parse_git_branch)"
# Pretty colors are set here
if [ "$color_prompt" = yes ] ; then
 PS1='${debian_chroot:+($debian_chroot)}'
 PS1="$PS1"'\n'                        # new line
 PS1="$PS1""$cyan"
 PS1="$PS1""[$(hostname)] "            # hostname<space>
 PS1="$PS1""$gray"
 PS1="$PS1"'\u '                       # user<space>
 PS1="$PS1""$PLATFORM "                # OS version
 PS1="$PS1""$yellow"
 PS1="$PS1"'\w '                       # current working directory
 PS1="$PS1""$green"
 PS1="$PS1"'`parse_git_branch`'        # git branch
 PS1="$PS1""$white"
 PS1="$PS1"'\n'                        # new line
 PS1="$PS1"'$ '                        # prompt: always $
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

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# allow aliased commands to tab complete
if [ -f ~/.bash_tab_completion ]; then
    . ~/.bash_tab_completion
fi

# Passwords, etc.
if [ -f ~/.secrets ]; then
    . ~/.secrets
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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
