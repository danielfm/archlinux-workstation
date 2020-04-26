#!/bin/bash

# Set color scheme
wal -l --theme base16-harmonic

# Set background image
# hsetroot -solid "#dadee3"
nitrogen --restore

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar --reload top &

echo "Polybar launched..."
