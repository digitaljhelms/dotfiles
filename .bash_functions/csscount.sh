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