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
  for f in *.$1; do mv $f `basename $f .$1`.$2; done;
}

# add extension to files without
# usage: addext {path} {ext_to_add}
function addext() {
  find $1 -type f -not -name "*.*" -exec mv "{}" "{}".$2 \;
}