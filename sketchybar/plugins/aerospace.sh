update_workspaces() {
    for sid in $(aerospace list-workspaces --all); do
        apps=$(aerospace list-windows --workspace $sid | awk -F '|' '{print $2}')
        label=""
        if [[ "$apps" != "" ]]; then
            while read -r app; do
                label+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
            done <<< "${apps}"
        else
            label=" -"
        fi

        sketchybar --set workspace.$sid label="$label"

        if [[ $1 == true ]]; then
            if [[ $sid == $AEROSPACE_FOCUSED_WORKSPACE ]]; then
                highlight=on
                drawing=on
            else
                highlight=off
                drawing=off
            fi

            sketchybar --set workspace.$sid icon.highlight=$highlight label.highlight=$highlight background.drawing=$drawing
        fi

    done
}

if [[ $SENDER = aerospace_workspace_change ]]; then
    selected_change=true
else
    selected_change=false
fi

update_workspaces $selected_change
