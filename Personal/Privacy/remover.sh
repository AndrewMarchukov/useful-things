#!/bin/bash

# Check if ADB is available
if ! command -v adb &> /dev/null; then
    echo "Error: ADB is not installed or not in PATH" >&2
    exit 1
fi

# Check if device is connected
if ! adb devices | grep -q "device$"; then
    echo "Error: No connected device found" >&2
    exit 1
fi

# Process apps from arguments or stdin
if [ $# -gt 0 ]; then
    # Apps provided as arguments
    apps=("$@")
else
    # Read apps from stdin
    apps=()
    while IFS= read -r app; do
        apps+=("$app")
    done
fi

# Uninstall each app
for app in "${apps[@]}"; do
    if [ -n "$app" ]; then
        echo "Uninstalling: $app"
        adb shell pm uninstall --user 0 "$app"
        echo "---"
    fi
done

sleep 5

# Reboot the device
echo "Rebooting device..."
adb reboot

# Wait for device to become available again
echo "Waiting for device to come back online..."
while ! adb devices | grep -qE "[*a-zA-Z0-9-]*[[:space:]]*device$"; do
    sleep 5
done

echo "Waiting for device to come back online..."
while true; do
    if adb devices | grep -q "device$"; then
        break
    fi
    sleep 5
done

echo "Device is back online!"
sleep 10  # Additional wait for full boot completion

# Disable each app
for app in "${apps[@]}"; do
    if [ -n "$app" ]; then
        echo "Disabling: $app"
        adb shell pm disable-user --user 0 "$app"
        echo "---"
    fi
done