#!/bin/bash

set -x

MONITORS=$(xrandr -q | grep '.* connected' | awk '{ print $1 }')
N_MONITORS=$(echo "$MONITORS" | wc -l)

echo "Detected $N_MONITORS connected monitor(s):" $MONITORS

# Built-in monitor
EDP_MONITOR=$(echo "$MONITORS" | grep '^eDP')
EDP_MONITOR=${EDP_MONITOR:-unknown}

# External monitor (left, portrait) connected to the DisplayPort output
DP_MONITOR=$(echo "$MONITORS" | grep '^DP')
DP_MONITOR=${DP_MONITOR:-unknown}

# External monitor (right) connected to the HDMI output
HDMI_MONITOR=$(echo "$MONITORS" | grep '^HDMI')
HDMI_MONITOR=${HDMI_MONITOR:-unknown}

# Extra xrandr parameters for each monitor
EDP_ARGS='--mode 1366x768 --pos 0x749'
DP_ARGS='--mode 1920x1200 --rotate left --pos 1366x0'
HDMI_ARGS='--mode 2560x1080 --pos 2566x706'

# Set primary monitor giving priority to the external displays
if [ $HDMI_MONITOR != 'unknown' ]; then
  xrandr --output $HDMI_MONITOR --primary
elif [ $DP_MONITOR != 'unknown' ]; then
  xrandr --output $DP_MONITOR --primary
else
  xrandr --output $EDP_MONITOR --primary
fi

case $N_MONITORS in
  1)
    echo No external monitors detected
    xrandr --auto
    ;;
  2)
    echo Single external monitor detected
    xrandr --auto --output $EDP_MONITOR $EDP_ARGS \
           --output $DP_MONITOR $DP_ARGS --above $EDP_MONITOR \
           --output $HDMI_MONITOR $HDMI_ARGS --above $EDP_MONITOR
    ;;
  3)
    echo Dual external monitors detected
    xrandr --auto --output $EDP_MONITOR $EDP_ARGS \
           --output $DP_MONITOR $DP_ARGS \
           --output $HDMI_MONITOR $HDMI_ARGS
    ;;
esac
