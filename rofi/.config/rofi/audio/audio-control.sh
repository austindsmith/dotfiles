#!/bin/bash

# Audio Control Script for Rofi
# Provides volume control and device switching via wpctl/pactl

get_volume() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}'
}

get_mute_status() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo "yes" || echo "no"
}

get_sinks() {
    pactl list sinks short | awk '{print $1, $2}'
}

get_sources() {
    pactl list sources short | grep -v monitor | awk '{print $1, $2}'
}

get_default_sink() {
    pactl get-default-sink
}

get_default_source() {
    pactl get-default-source
}

set_volume() {
    wpctl set-volume @DEFAULT_AUDIO_SINK@ "$1%"
}

toggle_mute() {
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
}

set_sink() {
    pactl set-default-sink "$1"
}

set_source() {
    pactl set-default-source "$1"
}

main_menu() {
    vol=$(get_volume)
    muted=$(get_mute_status)

    if [ "$muted" = "yes" ]; then
        vol_icon="󰝟 Muted"
    else
        vol_icon="󰕾 Volume: ${vol}%"
    fi

    default_sink=$(get_default_sink)
    default_source=$(get_default_source)

    # Shorten device names for display
    sink_short=$(echo "$default_sink" | sed 's/.*\.\(.*\)/\1/' | cut -c1-30)
    source_short=$(echo "$default_source" | sed 's/.*\.\(.*\)/\1/' | cut -c1-30)

    choice=$(printf "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s" \
        "$vol_icon" \
        "󰝚 Volume Up (+10%)" \
        "󰝞 Volume Down (-10%)" \
        "󰖁 Toggle Mute" \
        "─────────────" \
        "󰓃 Output: $sink_short" \
        "󰍬 Input: $source_short" \
        "─────────────" \
        | rofi -dmenu -i -p "Audio" -theme-str 'window {width: 400px;}')

    case "$choice" in
        *"Volume Up"*)
            new_vol=$((vol + 10))
            [ $new_vol -gt 100 ] && new_vol=100
            set_volume $new_vol
            main_menu
            ;;
        *"Volume Down"*)
            new_vol=$((vol - 10))
            [ $new_vol -lt 0 ] && new_vol=0
            set_volume $new_vol
            main_menu
            ;;
        *"Toggle Mute"*)
            toggle_mute
            main_menu
            ;;
        *"Output:"*)
            sink_menu
            ;;
        *"Input:"*)
            source_menu
            ;;
        "$vol_icon")
            volume_slider
            ;;
    esac
}

volume_slider() {
    vol=$(get_volume)

    # Generate volume options
    options=""
    for i in 100 90 80 70 60 50 40 30 20 10 0; do
        if [ $i -eq $vol ] || [ $((vol / 10 * 10)) -eq $i ]; then
            options="${options}󰕾 ${i}% ◀\n"
        else
            options="${options}  ${i}%\n"
        fi
    done

    choice=$(printf "$options" | rofi -dmenu -i -p "Volume" -theme-str 'window {width: 300px;}')

    if [ -n "$choice" ]; then
        new_vol=$(echo "$choice" | grep -oE '[0-9]+')
        [ -n "$new_vol" ] && set_volume "$new_vol"
    fi
    main_menu
}

sink_menu() {
    default=$(get_default_sink)

    options=""
    while IFS= read -r line; do
        id=$(echo "$line" | awk '{print $1}')
        name=$(echo "$line" | awk '{print $2}')
        short_name=$(echo "$name" | sed 's/.*\.\(.*\)/\1/')

        if [ "$name" = "$default" ]; then
            options="${options}󰓃 ${short_name} ◀\n"
        else
            options="${options}  ${short_name}\n"
        fi
    done < <(get_sinks)

    choice=$(printf "$options" | rofi -dmenu -i -p "Output Device" -theme-str 'window {width: 450px;}')

    if [ -n "$choice" ]; then
        # Find the full sink name from the short name
        short_selected=$(echo "$choice" | sed 's/^[󰓃 ]*//' | sed 's/ ◀$//')
        full_name=$(pactl list sinks short | awk '{print $2}' | grep "$short_selected")
        [ -n "$full_name" ] && set_sink "$full_name"
    fi
    main_menu
}

source_menu() {
    default=$(get_default_source)

    options=""
    while IFS= read -r line; do
        id=$(echo "$line" | awk '{print $1}')
        name=$(echo "$line" | awk '{print $2}')
        short_name=$(echo "$name" | sed 's/.*\.\(.*\)/\1/')

        if [ "$name" = "$default" ]; then
            options="${options}󰍬 ${short_name} ◀\n"
        else
            options="${options}  ${short_name}\n"
        fi
    done < <(get_sources)

    choice=$(printf "$options" | rofi -dmenu -i -p "Input Device" -theme-str 'window {width: 450px;}')

    if [ -n "$choice" ]; then
        short_selected=$(echo "$choice" | sed 's/^[󰍬 ]*//' | sed 's/ ◀$//')
        full_name=$(pactl list sources short | grep -v monitor | awk '{print $2}' | grep "$short_selected")
        [ -n "$full_name" ] && set_source "$full_name"
    fi
    main_menu
}

main_menu
