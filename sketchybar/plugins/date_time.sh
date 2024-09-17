# sketchybar --set $NAME label="$(LC_TIME=zh_CN.UTF-8 date +'%-m月%-d日 周%a %R')"
sketchybar --set date label="$(LC_TIME=en_US.UTF-8 date +"%a, %b %-d")"
sketchybar --set time label="$(LC_TIME=en_US.UTF-8 date +"%R")"
