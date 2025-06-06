#!/usr/bin/env zsh

EWW=`which eww`
C="$HOME/.config/eww/bar"

## Run eww daemon if not running already
if [[ ! `pidof eww` ]]; then
	${EWW} daemon
	sleep 1
fi

## Open widgets
run_eww() {
	${EWW} --config "$C" open-many \
        barMonitor0 \
        barMonitor1
}

## Launch or close widgets accordingly
run_eww
