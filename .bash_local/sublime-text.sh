# {{{
# sublime text 2
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
#alias st='subl'
function st() {
  if [ -n "$1" -a -n "$2" ]; then # if more than one argument
    if [ "$1" = "-p" -o "$1" = "--project" ]; then # if arg1 is -p or --project
      local projectfile="$2"
      [[ $projectfile != *.sublime-project ]] && projectfile="$2.sublime-project" # detect if arg2 already includes the ext
      if [ -e $projectfile ]; then # does project file exist?
        subl -n --project $projectfile ${*:3} # open project file, in new window, include trailing args
        #echo "project specified, and project file exists, execute: subl -n --project projectfile ${*:3}"
      else
        subl ${*:3} # open sublime but drop -p||--project and project name from args
        #echo "project specified, but project file doesn't exist, execute: subl ${*:3}"
      fi
    else
      subl $* # open sublime and pass args as usual
      #echo "project argument not passed, execute: subl $*"
    fi
  else
    subl $* # open sublime and pass args as usual
    #echo "only 1 argument passed, execute: subl $*"
  fi
}
export -f st
# }}}