export EDITOR=vim
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:/Users/ilyaskrypitsa/Library/Python/3.7/bin
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/lib/pkgconfig/
export LDFLAGS="-L/usr/local/Cellar/openssl/1.0.2p/lib"
export CPPFLAGS="-  I/usr/local/opt/openssl/include"
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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
. ~/.bash_git

#Terminal command prompt
PROMPT_COMMAND='PS1BRANCH=$(__git_ps1); if [ ${#PS1BRANCH} -ge 1 ]; then PS1X=$(basename `git rev-parse --show-toplevel`)$PS1BRANCH; else PS1X=$(p="${PWD#${HOME}}"; [ "${PWD}" != "${p}" ] && printf "~";IFS=/; for q in ${p:1}; do printf /${q:0:1}; done; printf "${q:1}"); fi'
PS1='`if [ \$? = 0 ]; then echo \[\e[33m\]; else echo \[\e[31m\]; fi`\t-\[\033[1;31m\]\u\[\033[1;33m\]@\[\033[1;32m\]\h\[\033[0m\]:\[\e[1;34m\]${PS1X}:\[\e[0m\] '

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH
