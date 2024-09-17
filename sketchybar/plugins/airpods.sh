DEVICE=$(system_profiler SPBluetoothDataType -json | jq '.SPBluetoothDataType[0].device_connected[] | select (.[] | .device_minorType=="Headphones")' 2> /dev/null | jq '.[]')

echo $DEVICE
if [ "$DEVICE" = "" ]
then
    sketchybar --set $NAME drawing=off
else
    left="$(echo $DEVICE | jq -r .device_batteryLevelLeft)"
    right="$(echo $DEVICE | jq -r .device_batteryLevelRight)"

    sketchybar --set $NAME drawing=on label="L:$left R:$right"
fi
