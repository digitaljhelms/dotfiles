# file/directory cleanup
function delstore() {
  echo "Recursively removing .DS_Store files from"
  pwd
  find . -name ".DS_Store" -delete
}
function delcvs() {
  echo "Recursively removing CVS folders from"
  pwd
  #rm -rf `find . -type d -name CVS`
  find . -name CVS -print0 | xargs -0 rm -rf
}
function delgit() {
  echo "Recursively removing .git folders from"
  pwd
  #rm -rf `find . -type d -name .git`
  find . -name .git -print0 | xargs -0 rm -rf
}
function delsvn() {
  echo "Recursively removing .svn folders from"
  pwd
  #rm -rf `find . -type d -name .svn`
  find . -name .svn -print0 | xargs -0 rm -rf
}
function delorig() {
  echo "Recursively removing *.orig files from"
  pwd
  find . -name "*.orig" -delete
}
function delpyc() {
  echo "Recursively removing .pyc files from"
  pwd
  find . -name "*.pyc" -delete
}

# change file extension for all matching files in current dir
# usage: ext {current_ext} {new_ext}
function ext() {
  echo "Converting all matching file extensions in"
  pwd
  for f in *.$1; do mv $f `basename $f .$1`.$2; done;
}

# add extension to files without
# usage: addext {path} {ext_to_add}
function addext() {
  echo "Adding file extensions to all files matched in"
  pwd
  find $1 -type f -not -name "*.*" -exec mv "{}" "{}".$2 \;
}

# generate unique string X characters in length
# usage: guniq {len}
function guniq() {
  # date +%s | shasum | base64 | head -c 10; echo

  CHARS="!@#$%^&*()-_=+"

  if [[ -n "$1" && "$1" -ge 0 ]]; then
    if ! [ -x "$(command -v shuf)" ]; then
      printf "%s" "The shuf command recommended, but not installed; would you like to install it using Homebrew? [y/N] "
      read shufinstall
      if [[ "$shufinstall" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
        if ! [ -x "$(command -v brew)" ]; then
          printf "Homebrew is not installed, would you like to install it? [y/N] "
          read brewinstall
          if [[ "$brewinstall" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
          else
            echo -e "Aborting" >&2
            return
          fi
        fi

        brew install coreutils
      fi
    fi

    if ! [ -x "$(command -v shuf)" ]; then
      SHUFFLE="gshuf"
    elif ! [ -x "$(command -v gshuf)" ]; then
      SHUFFLE="shuf"
    else
      SHUFFLE="sort -R"
    fi

    echo "$(openssl rand -base64 $1+${#CHARS} \
      | (echo ${CHARS} && cat) \
      | fold -w1 \
      | eval ${SHUFFLE} \
      | tr -d '\n' \
      | colrm $(expr $1 + 1))"

    # https://stackoverflow.com/a/30948155
    # { </dev/urandom LC_ALL=C grep -ao '[A-Za-z0-9]' \
    #       | head -n$((RANDOM % $1))
    #   echo ${CHARS:$((RANDOM % ${#CHARS})):1}   # Random special char.
    # } \
    # | shuf \
    # | tr -d '\n'; echo
  else
    echo "Command requires a length\nex: $ $0 32"
  fi
}