NETWORK=$(ifstat -i "en0" -b 0.1 1 | tail -n1)

DOWN=$(echo $NETWORK | awk "{print \$1}" | cut -f1 -d ".")
if [[ $DOWN -gt 0 ]]
then
    DOWN_HIGHLIGHT=on
else
    DOWN_HIGHLIGHT=off
fi
if [[ $DOWN -ge 1000 ]]
then
    DOWN=$(echo $DOWN | awk '{printf "%03.0f mbps", $1/1000}')
else
    DOWN=$(echo $DOWN | awk '{printf "%03.0f kbps", $1}')
fi

UP=$(echo $NETWORK | awk "{print \$2}" | cut -f1 -d ".")
if [[ $UP -gt 0 ]]
then
    UP_HIGHLIGHT=on
else
    UP_HIGHLIGHT=off
fi
if [[ $UP -ge 1000 ]]
then
    UP=$(echo $UP | awk '{printf "%03.0f mbps", $1/1000}')
else
    UP=$(echo $UP | awk '{printf "%03.0f kbps", $1}')
fi

sketchybar --set network_up label="$UP" icon.highlight=$UP_HIGHLIGHT       \
           --set network_down label="$DOWN" icon.highlight=$DOWN_HIGHLIGHT
