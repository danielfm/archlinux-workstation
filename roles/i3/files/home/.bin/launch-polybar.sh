#!/bin/bash

# Set color scheme
hsetroot -solid "#dadee3"
wal --theme base16-classic -l

# Set background image
nitrogen --restore

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar --reload top &

echo "Polybar launched..."
