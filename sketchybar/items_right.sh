space=(
    width=8
)

# 电池剩余电量
battery=(
    script="$PLUGIN_DIR/battery.sh"
    update_freq=120
)
sketchybar --add item  battery right                           \
           --set       battery "${battery[@]}"                 \
           --subscribe battery system_woke power_source_change

sketchybar --add bracket bra_battery battery         \
           --set         bra_battery "${bracket[@]}"

sketchybar --add item space.right.1 right --set space.right.1 "${space[@]}"

# 日期与时间
date=(
    icon=􀉉
)
time=(
    icon=􀐫
    script="$PLUGIN_DIR/date_time.sh"
    update_freq=10
)
sketchybar --add item time right        \
           --set      time "${time[@]}" \
           --add item date right        \
           --set      date "${date[@]}"

sketchybar --add bracket bra_date_time time date       \
           --set         bra_date_time "${bracket[@]}"

sketchybar --add item space.right.2 right --set space.right.2 "${space[@]}"

# 消息提示
wechat=(
    icon=󰘑
    icon.font.size=32
    icon.color=0xff2fb608
    script="$PLUGIN_DIR/app_status_label.sh"
    update_freq=10
    click_script="open -a WeChat"
)
sketchybar --add item wechat right          \
           --set      wechat "${wechat[@]}"

sketchybar --add bracket bra_wechat wechat          \
           --set         bra_wechat "${bracket[@]}"

sketchybar --add item space.right.3 right --set space.right.3 "${space[@]}"

# 音量大小
volume=(
    script="$PLUGIN_DIR/volume.sh"
)
sketchybar --add item  volume right          \
           --set       volume "${volume[@]}" \
           --subscribe volume volume_change
           
sketchybar --add bracket bra_volume volume          \
           --set         bra_volume "${bracket[@]}"


# 蓝牙耳机连接提示
# airpods=(
#   icon=􀪷
#   script="$PLUGIN_DIR/airpods.sh"
#   update_freq=300
# )
# sketchybar --add item airpods right --set airpods "${airpods[@]}"    \
#            --add event bluetooth_change "com.apple.bluetooth.status" \
#            --subscribe airpods bluetooth_change                      \
#            --add bracket bra_airpods airpods --set bra_airpods "${bracket[@]}"

sketchybar --add item space.right.4 right --set space.right.4 "${space[@]}"

# 系统状态
cpu=(
    icon=􀫥
    script="$PLUGIN_DIR/cpu.sh"
    update_freq=2
)
sketchybar --add item cpu right       \
           --set      cpu "${cpu[@]}"

network_up=(
    y_offset=6
    # padding_right=0
    icon=􀄨
    icon.font.size=10
    icon.highlight_color=0xbf91acef
    label.font="$MONO_FONT"
    update_freq=2
)
sketchybar --add item network_up right              \
           --set      network_up "${network_up[@]}"

network_down=(
    padding_right=-77
    y_offset=-6
    icon=􀄩
    icon.font.size=10
    icon.highlight_color=0xbf91acef
    label.font="$MONO_FONT"
    update_freq=2
    script="$PLUGIN_DIR/network.sh"
)
sketchybar --add item network_down right                \
           --set      network_down "${network_down[@]}"

driver=(
    icon=􀥾
    script="$PLUGIN_DIR/driver.sh"
    update_freq=600
)
sketchybar --add item driver right          \
           --set      driver "${driver[@]}"

sketchybar --add bracket bra_stats cpu network_up network_down driver \
           --set         bra_stats "${bracket[@]}"
