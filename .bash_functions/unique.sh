# generate unique string X characters in length
# usage: unique [--no-symbols] {length}
function unique() {
  # date +%s | shasum | base64 | head -c 10; echo

  PROGNAME=$0
  
  if [[ -n $1 && $1 == "--no-symbols" && -n $2 && $2 -ge 0 ]]; then
    CHARS=""
    LEN=$2
  elif [[ -n $1 && $1 -ge 0 ]]; then
    CHARS="!@#$%^&*()-_" # /, =, and + are symbols 
    LEN=$1
  else
    echo -e "Usage: $PROGNAME [--no-symbols] <length>" >&2
    return
  fi

  # https://www.redlever-solutions.com/blog/howto-generate-secure-passwords-with-openssl
  NUMBYTES=`echo $LEN | awk '{print int($1*1.16)+1}'`

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

  SHUFFLE="shuf"
  if ! [ -x "$(command -v shuf)" ]; then
    SHUFFLE="gshuf"
  fi
  if ! [ -x "$(command -v gshuf)" ]; then
    SHUFFLE="sort -R"
  fi

  echo "$(openssl rand -base64 ${NUMBYTES}+${#CHARS} \
    | tr -d "=+/" \
    | (echo ${CHARS} && cat) \
    | fold -w1 \
    | eval ${SHUFFLE} \
    | tr -d '\n' \
    | colrm $(expr ${LEN} + 1))"

  # https://stackoverflow.com/a/30948155
  # { </dev/urandom LC_ALL=C grep -ao '[A-Za-z0-9]' \
  #       | head -n$((RANDOM % $1))
  #   echo ${CHARS:$((RANDOM % ${#CHARS})):1}   # Random special char.
  # } \
  # | shuf \
  # | tr -d '\n'; echo
}