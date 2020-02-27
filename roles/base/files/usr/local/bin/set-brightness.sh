#!/bin/bash

# Set brightness for the given display output. Omit the display name for
# adjusting the brightness for all connected displays to the same value.

function set_brightness() {
  if [ "$#" -eq 1 ]; then
    xrandr -q | grep ' connected' | awk '{print $1}' | xargs -I {} xrandr --output {} --brightness "$1"
  elif [ "$#" -eq 2 ]; then
    xrandr --output "$2" --brightness "$1"
  else
    echo "Usage: $0 [DISPLAY_ID] [BRIGHTNESS]"
  fi
}

set_brightness "$@"
