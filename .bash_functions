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

# change file extension for all matching files in current dir
# usage: ext {current_ext} {new_ext}
function ext() {
  echo "converting all matching file extensions in"
  pwd
  for f in *.$1; do mv $f `basename $f .$1`.$2; done;
}

# add extension to files without
# usage: addext {path} {ext_to_add}
function addext() {
  echo "adding file extensions to all files matched in"
  pwd
  find $1 -type f -not -name "*.*" -exec mv "{}" "{}".$2 \;
}

# generate unique string X characters in length
# usage: genpass {len}
function genpass() {
  # date +%s | shasum | base64 | head -c 10; echo
  ((test -n "$1" && test "$1" -ge 0) && \
    openssl rand -base64 $1 | colrm $(expr $1 + 1) | tr -d '\n') 2>&-;
  # https://stackoverflow.com/a/30948155
  # chars='!@#$%^&*()-_=+'
  # ((test -n "$1" && test "$1" -ge 0) &&
  #   { </dev/urandom LC_ALL=C grep -ao '[A-Za-z0-9]' \
  #         | head -n$((RANDOM % $1))
  #     echo ${chars:$((RANDOM % ${#chars})):1}   # Random special char.
  #   } \
  #   | sort -R \
  #   | tr -d '\n')
}