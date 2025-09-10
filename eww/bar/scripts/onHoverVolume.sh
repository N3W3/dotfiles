#!/usr/bin/env zsh

EWW=$(which eww)
CONFIG=(--config "$HOME/.config/eww/bar")
main(){
    local isHover=$1
    if [[ "$isHover" == "1" ]]; then
       $EWW "${CONFIG[@]}" update isVolumeSelect=true
    else
       $EWW "${CONFIG[@]}" update isVolumeSelect=false
    fi
}

main "$1"
