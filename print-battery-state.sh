#!/bin/sh

upower -i $(upower -e | grep BAT)
