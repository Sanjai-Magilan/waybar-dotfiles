#!/bin/bash

# Get list of available networks using nmcli
NETWORKS=$(nmcli --terse --fields SSID,SECURITY dev wifi list | grep -v '^$' | awk -F: '!seen[$1]++ {printf "%s\n", $1}')

# Check if no networks found
if [ -z "$NETWORKS" ]; then
    wofi --show dmenu < /dev/null <<< "No networks found" &
    exit 1
fi

# Show networks in wofi and get user selection
SELECTED=$(echo "$NETWORKS" | wofi --show dmenu -p "Select Network:")

if [ -z "$SELECTED" ]; then
    exit 1
fi

# Get security type for the selected network
SECURITY=$(nmcli --terse --fields SSID,SECURITY dev wifi list | grep "^$SELECTED:" | cut -d: -f2)

# If network has security, prompt for password
if [[ "$SECURITY" != *"Open"* ]]; then
    PASSWORD=$(wofi --show dmenu -p "Enter password for $SELECTED:" -x 100 -y 100 2>&1)
    if [ -z "$PASSWORD" ]; then
        exit 1
    fi
    
    # Connect with password
    nmcli dev wifi connect "$SELECTED" password "$PASSWORD"
else
    # Connect without password
    nmcli dev wifi connect "$SELECTED"
fi
