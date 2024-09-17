USAGE=$(df -H /System/Volumes/Data | awk 'END {print $5}')

sketchybar --set $NAME label=$USAGE
