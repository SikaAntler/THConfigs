for sid in $(aerospace list-workspaces --all); do
    workspace=(
        icon=$sid
        icon.font="$FONT_FAMILY:Bold:16"
        icon.y_offset=0
        icon.padding_left=0
        icon.padding_right=2
        icon.highlight_color=$HIGHLIGHT
        label.font="$APP_FONT"
        label.y_offset=-2
        label.padding_left=2
        label.padding_right=8
        label.highlight_color=$HIGHLIGHT
        background.height=2
        background.color=$HIGHLIGHT
        background.y_offset=-12
        background.drawing=off
        padding_left=8
        padding_right=8
        click_script="aerospace workspace $sid"
    )
    sketchybar --add item workspace.$sid left              \
               --set      workspace.$sid "${workspace[@]}"
done

chevron=(
    icon=􀆊
    icon.y_offset=1
    icon.padding_left=8
    icon.padding_right=8
    label.drawing=off
    label.padding_left=0
    label.padding_right=0
    script="$PLUGIN_DIR/aerospace.sh"
)

sketchybar --add event aerospace_workspace_change         \
           --add  item chevron left                       \
           --set       chevron "${chevron[@]}"            \
           --subscribe chevron space_windows_change aerospace_workspace_change

front_app=(
    icon.font="$APP_FONT"
    icon.y_offset=0
    icon.padding_left=8
    icon.padding_right=4
    label.y_offset=0
    label.padding_left=4
    label.padding_right=8
    script="$PLUGIN_DIR/front_app.sh"
)

sketchybar --add item  front_app left               \
           --set       front_app "${front_app[@]}"  \
           --subscribe front_app front_app_switched

sketchybar --add bracket bra_front_app front_app "/workspace\.*/" \
           --set         bra_front_app "${bracket[@]}"
