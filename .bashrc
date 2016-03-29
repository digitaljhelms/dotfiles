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
PS1+="\[$orange\]\h" # host
PS1+="\[$reset$white\]@"
PS1+="\[$yellow\]\u:" # username
PS1+="\[$reset$white\] "
PS1+="\[$green\]\W" # working directory

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
  PS1+="\$(__git_ps1 \"\[$white\] on \[$cyan\]%s \")" # git repository details
fi

PS1+="\[$reset$white\]\$ \[$reset\]" # $ (and reset color)

# file/directory cleanup
function delstore() {
  echo "recursively removing .DS_Store files from"
  pwd
  find . -name ".DS_Store" -delete
}
function delcvs() {
  echo "recursively removing CVS folders from"
  pwd
  #rm -rf `find . -type d -name CVS`
  find . -name CVS -print0 | xargs -0 rm -rf
}
function delgit() {
  echo "recursively removing .git folders from"
  pwd
  #rm -rf `find . -type d -name .git`
  find . -name .git -print0 | xargs -0 rm -rf
}
function delsvn() {
  echo "recursively removing .svn folders from"
  pwd
  #rm -rf `find . -type d -name .svn`
  find . -name .svn -print0 | xargs -0 rm -rf
}
function delorig() {
  echo "recursively removing *.orig files from"
  pwd
  find . -name "*.orig" -delete
}
function delpyc() {
  echo "recursively removing .pyc files from"
  pwd
  find . -name "*.pyc" -delete
}

# change file extension for multiple files at once
function ext() {
  for f in *.$1; do mv $f `basename $f .$1`.$2; done;
}

# count the number of css selectors in a file
# usage: cat styles.css | csscount
# http://alias.sh/count-number-selectors-css-file
function csscount() {
  local cnt=0
  local depth=0
  while read -n 1 char; do
    case $char in
      "{") ((depth++));;
      "}")
        ((depth--))
        if [ "$depth" -eq "0" ]; then
          ((cnt++))
        fi
        ;;
      ",") ((cnt++));;
    esac
  done
  echo $cnt
}

# http://blog.vicshih.com/2008/04/move-to-trash-from-mac-command-line.html
#alias rm='trash'
function trash() {
  while [ -n "$1" ]; do
    local file=`basename "$1"`
    # Chop trailing '/' if there
    file=${file%/}

    local destination=""

    if [ -e "$HOME/.Trash/$file" ]; then
      # Extract file and extension
      local ext=`expr "$file" : ".*\(\.[^\.]*\)$"`
      local base=${file%$ext}

      # Add a space between base and timestamp
      test -n "$base" && base="$base "

      destination="/$base`date +%H-%M-%S`_$RANDOM$ext"
    fi

    echo "Moving '$1' to '$HOME/.Trash$destination'"
    mv "$1" "$HOME/.Trash$destination"
    shift
  done
}

# local & sbin directory
# export PATH="/usr/local:/usr/local/bin:/usr/local/sbin:$PATH" # this is done in /etc/paths instead

# LS_COLORS
# http://softwaregravy.com/ls-colors-for-mac/
export LS_OPTIONS='--color=auto'
export CLICOLOR=1
# default is exfxcxdxbxegedabagacad
export LSCOLORS=Dxfxcxdxbxegedabagacad

# Default compiler
export CC=/usr/bin/gcc

# Default editor
#export EDITOR='coda -w'
#export EDITOR='mate -w'
export EDITOR='st -w'

# Permanently set the SVN_EDITOR variable
export SVN_EDITOR=/usr/bin/vi
