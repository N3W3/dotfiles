#!/usr/bin/env zsh


workspaces() {
    local isActive=false
    local monitor_id=$1
    local buf=""

    # Read workspaces, split on newline (handle spaces properly)
    workspaces=("${(@f)$(hyprctl workspaces -j | jq --argjson id "$monitor_id" -r '[.[] | select(.monitorID==$id) | .name] | .[]' | sort -n)}")

    # Get the active workspace name
    activeWorkspace=$(hyprctl monitors -j | jq --argjson id "$monitor_id" -r '.[] | select(.id == $id) | .activeWorkspace.name')

    for ws in "${workspaces[@]}"; do
        #Find the active workspace in the boucle
        if [[ "$ws" == "$activeWorkspace" ]]; then
            isActive=true
        else
            isActive=false
        fi

        icon="(image :path \"$HOME/.config/eww/bar/images/image${ws}.svg\" :image-width 24 :image-height 24)"

        if $isActive; then
            buf+="(button :class \"isActive\" :onclick \"hyprctl dispatch workspace $ws\" $icon)"
        else
            buf+="(button :onclick \"sh -c 'hyprctl dispatch workspace $ws; /home/newe/.config/eww/bar/scripts/update_workspaces.sh'\" $icon)"
        fi

    done

    echo "(box :class \"workspaces\" :halign \"center\" :valign \"center\" :vexpand true :hexpand true $buf)"
}

workspaces "$1"
