# file conversions
function webpjpg() {
  echo "Converting all files in current directory from WebP to JPEG"
  for x in *.webp; do ffmpeg -i "$x" "${x%.webp}.jpg"; done
}