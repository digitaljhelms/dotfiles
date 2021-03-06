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