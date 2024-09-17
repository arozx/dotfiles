#!/bin/bash

# Scan for devices using bluetoothctl and format the output
scan_devices() {
    bluetoothctl scan on & sleep 5; bluetoothctl scan off
    bluetoothctl devices | awk '{print $2 " " substr($0, index($0,$3))}'
}

# List paired devices
list_paired_devices() {
    bluetoothctl devices | awk '{print $2 " " substr($0, index($0,$3))}'
}

# List connected devices
list_connected_devices() {
    bluetoothctl info | grep "Device" | awk '{print $2 " " substr($0, index($0,$3))}'
}

# Prompt the user to select a device via rofi
select_device() {
    devices=$(scan_devices)
    if [ -z "$devices" ]; then
        echo "No devices found"
        exit 1
    fi

    selected_device=$(echo "$devices" | rofi -dmenu -p "Bluetooth Devices" | awk '{print $1}')
    echo "$selected_device"
}

# Connect to a selected device
connect_device() {
    device_mac="$1"
    if [ -n "$device_mac" ]; then
        bluetoothctl connect "$device_mac"
    else
        echo "No device selected"
        exit 1
    fi
}

# Disconnect from a selected device
disconnect_device() {
    device_mac="$1"
    if [ -n "$device_mac" ]; then
        bluetoothctl disconnect "$device_mac"
    else
        echo "No device selected"
        exit 1
    fi
}

# Main menu using rofi
main_menu() {
    options="Scan Devices\nList Paired Devices\nDisconnect Device\nExit"
    selected=$(echo -e "$options" | rofi -dmenu -p "Bluetooth Menu")

    case $selected in
        "Scan Devices")
            device_mac=$(select_device)
            connect_device "$device_mac"
            ;;
        "List Paired Devices")
            paired_devices=$(list_paired_devices)
            selected_paired=$(echo "$paired_devices" | rofi -dmenu -p "Paired Devices" | awk '{print $1}')
            connect_device "$selected_paired"
            ;;
        "Disconnect Device")
            paired_devices=$(list_paired_devices)
            selected_connected=$(echo "$paired_devices" | rofi -dmenu -p "Connected Devices" | awk '{print $1}')
            disconnect_device "$selected_connected"
            ;;
        "Exit")
            exit 0
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
}

# Start the script
main_menu

