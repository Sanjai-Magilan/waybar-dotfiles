#!/bin/bash

# Fast network menu - optimized for speed

# Get list of available networks using nmcli (scan in background)
WIFI_DATA=$(nmcli --terse --fields SSID,SECURITY dev wifi list 2>/dev/null)

if [ -z "$WIFI_DATA" ]; then
    notify-send "No networks found" 2>/dev/null
    exit 1
fi

# Extract unique networks and keep SSID:SECURITY mapping
NETWORKS=$(echo "$WIFI_DATA" | grep -v '^$' | awk -F: '!seen[$1]++ {print $1}')

# Show networks in wofi and get user selection
SELECTED=$(echo "$NETWORKS" | wofi --show dmenu -p "Select Network:" 2>/dev/null)

if [ -z "$SELECTED" ]; then
    exit 1
fi

# Get security type from cached data
SECURITY=$(echo "$WIFI_DATA" | grep "^$SELECTED:" | cut -d: -f2 | head -1)

# Connect based on security
if [[ "$SECURITY" == *"Open"* ]] || [ -z "$SECURITY" ]; then
    # Open network - connect directly
    nmcli dev wifi connect "$SELECTED" > /dev/null 2>&1
    notify-send "✓ Connected to $SELECTED" 2>/dev/null
else
    # Secured network - prompt for password
    PASSWORD=$(wofi --show dmenu -p "Password for $SELECTED:" 2>/dev/null)
    if [ -z "$PASSWORD" ]; then
        exit 1
    fi
    
    # Connect with password
    if nmcli dev wifi connect "$SELECTED" password "$PASSWORD" > /dev/null 2>&1; then
        notify-send "✓ Connected to $SELECTED" 2>/dev/null
    else
        notify-send "✗ Failed to connect" 2>/dev/null
    fi
fi
