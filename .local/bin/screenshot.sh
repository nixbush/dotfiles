#!/usr/bin/env bash
# ------------------------------
# Flag functions
# ------------------------------
usage() {
   echo "Usage: ./screenshot.sh [flags]"
   echo "Flags:"
   echo "  -h       Print this help message"
   echo "  -s       Select a part of the screen to capture"
   echo "  -e       Edit the screenshot afterwards"
   echo "  -f=...   Filename to save to"
}

# ------------------------------
# Handle flags
# ------------------------------
DIRECTORY="$HOME/Pictures/Screenshots"

DATE=$(date +%Y-%m-%d)
TIME=$(date +%H-%M-%S)

FILENAME="$DIRECTORY/screenshot_$DATE-$TIME.png"

SELECT_AREA=false
EDIT_IMAGE=false

while getopts "hsef:" opt; do
   case "$opt" in
      h)
         usage
         exit 0
         ;;
      s)
         SELECT_AREA=true
         ;;
      e)
         EDIT_IMAGE=true
         ;;
      f)
         FILENAME="$OPTARG"
         ;;
      \?) 
         usage
         exit 1
         ;;
   esac
done

# ------------------------------
# Handle flags
# ------------------------------
notify-send -u normal -t 5000 "Screenshot" "Saved screenshot at <i>$FILENAME</i>"
if $SELECT_AREA; then
   grim -g "$(slurp)" "$FILENAME"
else
   grim "$FILENAME"
fi

if $EDIT_IMAGE; then
   swappy -f "$FILENAME" -o "${FILENAME%.png}-edit.png"
fi
