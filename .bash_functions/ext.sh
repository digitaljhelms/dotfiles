# add extension to files without
# usage: addext {path} {ext_to_add}
function addext() {
  echo "Adding file extensions to all files matched in"
  pwd
  find $1 -type f -not -name "*.*" -exec mv "{}" "{}".$2 \;
}

# change file extension for all matching files in current dir
# usage: mvext {current_ext} {new_ext}
function mvext() {
  echo "Converting all matching file extensions in"
  pwd
  for f in *.$1; do mv $f `basename $f .$1`.$2; done;
}