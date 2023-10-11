# aliases
alias open=openAndroidUrl

function openAndroidUrl() {
  ANDROID_URL_SCRIPT="translate-android-link"
  if ! command -v "$ANDROID_URL_SCRIPT" &> /dev/null
  then
    echo "$ANDROID_URL_SCRIPT not found in PATH. exiting..."
    return
  fi

  FILE="$1"
  if [ "$#" = "0" ] || [ ! -e "$FILE" ]; then
    echo "no input file/invalid input file given! quitting..."
    return
  fi

  MIMETYPE=$(file --brief --mime-type "$FILE")
  if [[ "$MIMETYPE" = "text/html" ]]; then
    URL=$(translate-android-link "$FILE")
    xdg-open "$URL"
  else
    xdg-open "$FILE"
  fi
}
