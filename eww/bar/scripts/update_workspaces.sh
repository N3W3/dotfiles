#!/usr/bin/env zsh

eww --config ~/.config/eww/bar update workspacesRight="$(~/.config/eww/bar/scripts/workspaces.sh 0)"
eww --config ~/.config/eww/bar update workspacesLeft="$(~/.config/eww/bar/scripts/workspaces.sh 1)"
