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