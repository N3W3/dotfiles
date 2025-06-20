#!/usr/bin/env zsh

pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]\+%' | head -n1
