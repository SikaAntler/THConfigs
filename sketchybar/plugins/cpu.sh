CPU=$(ps -A -o %cpu | awk '{s+=$1} END {print s}')
THREADS=$(sysctl -n machdep.cpu.thread_count)
USAGE=$(echo $CPU / $THREADS | bc)

sketchybar --set $NAME label="${USAGE}%"
