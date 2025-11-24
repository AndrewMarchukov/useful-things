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
        echo "Uninstalling: $app" for user 0
        adb shell pm uninstall --user 0 "$app" | grep "Success"
        echo "---"
    fi
done

for app in "${apps[@]}"; do
    if [ -n "$app" ]; then
        echo "Uninstalling: $app"
        adb shell pm uninstall "$app" | grep "Success"
        echo "---"
    fi
done

sleep 5

# Reboot the device
echo "Rebooting device..."
adb reboot

echo "Waiting for device to come back online..."
while true; do
    if adb devices | grep -q "device$"; then
        break
    fi
    sleep 5
done

echo "Device is back online!"
sleep 10  # Additional wait for full boot completion

adb shell pm compile -a -f --check-prof false -m everything
adb shell pm compile -a -f --check-prof false --compile-layouts
adb shell pm bg-dexopt-job

# Disable each app
for app in "${apps[@]}"; do
    if [ -n "$app" ]; then
        echo "Disabling: $app" for user 0
        adb shell pm disable-user --user 0 "$app"
        echo "---"
    fi
done

for app in "${apps[@]}"; do
    if [ -n "$app" ]; then
        echo "Disabling: $app"
        adb shell pm disable-user "$app"
        echo "---"
    fi
done

# Check if cached apps freezer is enabled
if ! adb shell settings get global cached_apps_freezer | grep -q "enabled"; then
    echo "Enabling cached apps freezer..."
    adb shell settings put global cached_apps_freezer enabled
    
    # Verify the change
    if adb shell settings get global cached_apps_freezer | grep -q "enabled"; then
        adb shell device_config put activity_manager_native_boot use_freezer true
        adb shell device_config put activity_manager_native_boot freeze_debounce_timeout 1000
        echo "Successfully enabled cached apps freezer"
        # Reboot the device
        echo "Rebooting device..."
        adb reboot
    else
        echo "Cached apps freezer not supported"
        exit 1
    fi
else
    echo "Cached apps freezer already enabled"
fi

#logcat | grep -i freeze 
#adb shell getprop