#!/bin/sh

COMMAND=$1

usage() {
    echo
    echo "Usage $(basename $0) [turn-hdmi-off | turn-hdmi-on | turn-screen-off]"
    echo
}

if [ -z "$COMMAND" ]; then
    usage
    exit 1
fi

case $COMMAND in
    turn-hdmi-off)
        xrandr --output HDMI2 --off
        ;;
    turn-hdmi-on)
        xrandr --output HDMI2 --auto --right-of LVDS1
        ;;
    turn-screen-off)
        xset dpms force off
        ;;
esac
