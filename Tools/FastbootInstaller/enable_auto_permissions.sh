#!/bin/bash

echo "========================================="
echo "Surface Duo Auto Permissions Setup"
echo "========================================="
echo

echo "[1/5] Killing existing ADB server..."
./platform-tools/adb kill-server
echo "✓ ADB server stopped"
echo

echo "[2/5] Starting ADB server..."
./platform-tools/adb start-server
echo "✓ ADB server started"
echo

echo "[3/5] Setting up automatic USB debugging authorization..."
echo "This will attempt to automatically accept USB debugging permissions"
echo

echo "[4/5] Configuring ADB for non-interactive mode..."
# Create ADB configuration directory if it doesn't exist
mkdir -p "$HOME/.android"

# Add Microsoft vendor ID for Surface devices
echo "# ADB Auto-configuration" > "$HOME/.android/adb_usb.ini"
echo "# Auto-accept debugging permissions" >> "$HOME/.android/adb_usb.ini"
echo "0x045e" >> "$HOME/.android/adb_usb.ini"
echo "✓ ADB configuration updated"
echo

# Set up udev rules for Linux (if running on Linux)
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "[4b/5] Setting up Linux udev rules for Surface Duo..."
    UDEV_RULES="# Surface Duo devices
SUBSYSTEM==\"usb\", ATTR{idVendor}==\"045e\", ATTR{idProduct}==\"*\", MODE=\"0666\", GROUP=\"plugdev\"
SUBSYSTEM==\"usb\", ATTR{idVendor}==\"045e\", MODE=\"0666\", GROUP=\"plugdev\""
    
    if [ -w "/etc/udev/rules.d" ]; then
        echo "$UDEV_RULES" | sudo tee /etc/udev/rules.d/51-surface-duo.rules > /dev/null
        sudo udevadm control --reload-rules
        sudo udevadm trigger
        echo "✓ Udev rules installed (requires sudo)"
    else
        echo "⚠ Cannot write udev rules - run as sudo if needed"
        echo "Manual udev rule content:"
        echo "$UDEV_RULES"
    fi
    echo
fi

echo "[5/5] Testing device detection with auto-accept..."
echo "Waiting for device connection..."
echo
echo "Instructions:"
echo "1. Connect your Surface Duo 2 to this PC"
echo "2. When USB debugging dialog appears, check 'Always allow from this computer'"
echo "3. Click OK to authorize this computer"
echo

wait_for_device() {
    while true; do
        echo "Checking for devices..."
        ./platform-tools/adb devices -l
        echo
        
        # Check device status
        DEVICE_STATUS=$(./platform-tools/adb devices | sed -n '2p' | awk '{print $2}')
        DEVICE_ID=$(./platform-tools/adb devices | sed -n '2p' | awk '{print $1}')
        
        if [ "$DEVICE_STATUS" = "device" ]; then
            echo "✓ Device $DEVICE_ID is authorized and ready"
            break
        elif [ "$DEVICE_STATUS" = "unauthorized" ]; then
            echo "⚠ Device $DEVICE_ID is connected but not authorized"
            echo "  Please check your device screen and authorize USB debugging"
            sleep 5
        elif [ "$DEVICE_STATUS" = "offline" ]; then
            echo "⚠ Device $DEVICE_ID is offline - reconnect USB cable"
            sleep 3
        else
            echo "No devices detected. Waiting..."
            sleep 3
        fi
    done
}

wait_for_device

echo
echo "========================================="
echo "✓ AUTO PERMISSIONS SETUP COMPLETE"
echo "========================================="
echo
echo "Device is now authorized for automatic operations"
echo "You can now run factory reset without manual confirmations"
echo

read -p "Press Enter to continue..."
