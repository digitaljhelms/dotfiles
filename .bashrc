# Personal functions.

# Personal environment variables and startup programs should go in
# ~/.bash_profile.  System wide environment variables and startup
# programs are in /etc/profile.  System wide aliases and functions are
# in /etc/bashrc.

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  tput sgr0 # reset colors

  bold=$(tput bold)
  reset=$(tput sgr0)

  # Solarized colors
  # (https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized#the-values)
  black=$(tput setaf 0)
  blue=$(tput setaf 33)
  cyan=$(tput setaf 37)
  green=$(tput setaf 64)
  orange=$(tput setaf 166)
  purple=$(tput setaf 125)
  red=$(tput setaf 124)
  white=$(tput setaf 15)
  yellow=$(tput setaf 136)
else
  bold=""
  reset="\e[0m"

  black="\e[1;30m"
  blue="\e[1;34m"
  cyan="\e[1;36m"
  green="\e[1;32m"
  orange="\e[1;33m"
  purple="\e[1;35m"
  red="\e[1;31m"
  white="\e[1;37m"
  yellow="\e[1;33m"
fi

# http://askubuntu.com/a/24422
PS1="\[\033]0;\w\007\]"
PS1+="["
PS1+="\[$black\]\t" # time
PS1+="\[$reset\]"
PS1+="] "
PS1+="\[$cyan\]\h" # host
PS1+="\[$white\]@"
PS1+="\[$purple\]\u\[$reset\]: " # username
PS1+="\[$blue\]\W" # working directory

# Git Command Completion & Git-aware PS1
if [ -e ~/.git-prompt.sh ]; then
  source ~/.git-prompt.sh
fi
if [ -e ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
  # GIT_PS1_SHOWDIRTYSTATE=true
  # GIT_PS1_SHOWUNTRACKEDFILES=true
  # GIT_PS1_SHOWUPSTREAM=true
  # GIT_PS1_SHOWSTASHSTATE=true
  # GIT_PS1_STATESEPARATOR=
  # GIT_PS1_SHOWCOLORHINTS=true
  PS1+="\$(__git_ps1 \"\[$reset\](\[$black\]on \[$yellow\]%s\[$reset\]) \")" # git repository details
fi

PS1+="\[$reset$white\]\$ \[$reset\]" # $ (and reset color)

# local & sbin directory
# export PATH="/usr/local:/usr/local/bin:/usr/local/sbin:$PATH" # this is done in /etc/paths instead

# LS_COLORS
# http://softwaregravy.com/ls-colors-for-mac/
export LS_OPTIONS='--color=auto'
export CLICOLOR=1
# default is exfxcxdxbxegedabagacad
export LSCOLORS=GxFxCxDxBxegedabagaced # for dark terminals
#export LSCOLORS=ExFxBxDxCxegedabagacad # for light terminals

# Default compiler
export CC=/usr/bin/gcc

# Default editor
#export EDITOR='coda -w'
#export EDITOR='mate -w'
export EDITOR='st -w'

# Permanently set the SVN_EDITOR variable
export SVN_EDITOR=/usr/bin/vi
