# Custom Prompt
# Working directory, username, hostname if ssh
# Bright blue for username, white for command
if [ -n "$SSH_CLIENT" ]; then
    PS1='\[\e[0;34m\]\u@\h :: \W/ > \[\e[0m\]'
else
    PS1='\[\e[0;34m\]\u :: \W/ > \[\e[0m\]'
fi

# Add my custom scripts to path
export PATH=$PATH:~/.scripts:~/.scripts/wp


# Colors for LS and Grep
# LS Color
export CLICOLOR=1
# GREP Color
#export GREP_OPTIONS='--color=auto'
#export GREP_COLOR='1;32'

# Use Terminal's colors for emacs (Mac OS X)
[[ "$OSTYPE" == "darwin"* ]] && export TERM='xterm-color'

# Better Bash History
shopt -s histappend # session appends not overwrites to history
HISTFILESIZE=2000
HISTSIZE=2000
HISTCONTROL=ignoreboth # ignore dup commands, commands starting with space

# ------------------------------------------------------
#            Command Aliases / Functions
# ------------------------------------------------------
# la: display files as list, hidden files, human-readable form
alias la="ls -lah"

# pbcopy / pbpaste for OSX clipboard
if [[ "$OSTYPE" == "darwin"* ]]
then
    alias pp=pbpaste
    alias pc=pbcopy
fi

# tree: show tree, limit level to 2 automatically
alias tree="tree -L 2"

# easy check if connected to internet
alias pingg="ping -c 2 www.google.com"

# Emacs daemon
export ALTERNATE_EDITOR=""
alias emc='emacsclient -t'

# Include local executables
export PATH=$PATH:~/.local/bin

# Include local for pythonpath
export PYTHONPATH=$PYTHONPATH:~/.local/python

export EDITOR=vim

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
