#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias pingg='ping -c 2 www.google.com'
alias scr='bspc window -t floating;screenfetch;read'
alias flux='redshift -l geoclue2'
alias cmu='cd ~/CMU/Alumni/saved_courses/15410/p0/'
alias gs='git status'
alias '..'='cd ..'
alias mk='make'

# Fancy prompt
fg=('\[\e[0;30m\]' '\[\e[0;31m\]' '\[\e[0;32m\]' '\[\e[0;33m\]'
    '\[\e[0;34m\]' '\[\e[0;35m\]' '\[\e[0;36m\]' '\[\e[0;37m\]'
    '\[\e[1;30m\]' '\[\e[1;31m\]' '\[\e[1;32m\]' '\[\e[1;33m\]'
    '\[\e[1;34m\]' '\[\e[1;35m\]' '\[\e[1;36m\]' '\[\e[1;37m\]')
nofg='\[\e[0m\]'


export PS1="\[\e[0;31m\] \w >> \[\e[0;36m\]"

export EDITOR=vim
export TERM=rxvt

rmd () {
  pandoc $1 | lynx -stdin
}

set -o vi

# Python :D
venv() {
    local activate=~/.python/$1/bin/activate
    if [ -e "$activate" ] ; then
        source "$activate"
    else
        echo "Error: Not found: $activate"
    fi
}
venv27() { venv 27 ; }

export CLASSPATH=/home/asekar/CMU/Senior/15440/hw4/15440-p4/lib/:/home/asekar/CMU/Senior/15440/hw4/15440-p4/src
export PATH=/home/asekar/.cabal/bin/:$PATH
