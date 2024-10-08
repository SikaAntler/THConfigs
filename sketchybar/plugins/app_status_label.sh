if lsappinfo -all list | grep $NAME >> /dev/null; then
    LABEL=$(lsappinfo -all list | grep $NAME | egrep -o "\"StatusLabel\"=\{ \"label\"=\"?(.*?)\"? \}" | sed 's/\"StatusLabel\"={ \"label\"=\(.*\) }/\1/g')
    if [[ $LABEL =~ ^\".*\"$ ]]; then
        LABEL=$(echo $LABEL | sed 's/^"//' | sed 's/"$//')
        if [ -z "$LABEL" ]; then
            LABEL=0
        fi
    else
        LABEL=0
    fi
else
    LABEL="?"
fi

if [[ $LABEL =~ ^[0-9]+$ ]] && [[ $LABEL -gt 0 ]]; then
    # sketchybar --set $NAME label=$LABEL label.drawing=on icon.drawing=on
    sketchybar --set $NAME label=$LABEL drawing=on
    sketchybar --set space.right.3 drawing=on
else
    # sketchybar --set $NAME icon.drawing=off label.drawing=off
    sketchybar --set $NAME drawing=off
    sketchybar --set space.right.3 drawing=off
fi
