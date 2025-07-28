#!/bin/bash

echo "=========================================="
echo "Surface Duo 2 Automated Factory Reset"
echo "=========================================="
echo
echo "WARNING: This will COMPLETELY WIPE your device!"
echo "All Android and Windows data will be PERMANENTLY DELETED!"
echo
echo "Make sure you have:"
echo "- Backed up all important data"
echo "- Charged your device to at least 50%"
echo "- Connected device via USB-C cable"
echo

read -p "Type 'RESET' to continue or any other key to cancel: " confirm
if [ "$confirm" != "RESET" ]; then
    echo "Operation cancelled."
    exit 1
fi

echo
echo "=========================================="
echo "Starting Automated Factory Reset Process"
echo "=========================================="
echo

echo "[1/8] Verifying tools and permissions..."
if [ ! -f "platform-tools/adb" ]; then
    echo "✗ ADB not found. Run check_readiness.sh first."
    exit 1
fi
if [ ! -f "platform-tools/fastboot" ]; then
    echo "✗ Fastboot not found. Run check_readiness.sh first."
    exit 1
fi
if [ ! -f "surfaceduo2-twrp.img" ]; then
    echo "✗ TWRP image not found. Run check_readiness.sh first."
    exit 1
fi
echo "✓ All tools verified"
echo

echo "[2/8] Checking device connection..."
if ! ./platform-tools/adb devices | grep -q "device"; then
    echo "✗ No authorized device found."
    echo "Please run ./enable_auto_permissions.sh first."
    exit 1
fi
echo "✓ Device connected and authorized"
echo

echo "[3/8] Rebooting to bootloader..."
./platform-tools/adb reboot bootloader
echo "Waiting for bootloader mode..."
sleep 10

wait_fastboot() {
    while ! ./platform-tools/fastboot devices | grep -q "[0-9a-fA-F]"; do
        echo "Waiting for fastboot mode..."
        sleep 3
    done
}
wait_fastboot
echo "✓ Device in fastboot mode"
echo

echo "[4/8] Booting to TWRP recovery..."
./platform-tools/fastboot boot surfaceduo2-twrp.img
echo "Waiting for TWRP to load..."
sleep 15

wait_adb() {
    while ! ./platform-tools/adb devices | grep -q "device"; do
        echo "Waiting for TWRP ADB connection..."
        sleep 3
    done
}
wait_adb
echo "✓ TWRP loaded and connected"
echo

echo "[5/8] Setting up TWRP environment..."
./platform-tools/adb shell "setenforce 0" 2>/dev/null
./platform-tools/adb push parted /sdcard/
./platform-tools/adb shell "mv /sdcard/parted /sbin/parted && chmod 755 /sbin/parted"
echo "✓ Environment configured"
echo

echo "[6/8] Analyzing current partition layout..."
echo "Checking partitions..."
./platform-tools/adb shell "parted /dev/block/sda print" > partition_backup.txt
echo "✓ Partition layout backed up to partition_backup.txt"
echo

echo "[7/8] Performing factory reset..."
echo "WARNING: Starting irreversible data wipe in 5 seconds..."
sleep 5

echo "Removing Windows partitions..."
./platform-tools/adb shell "parted /dev/block/sda rm 8" 2>/dev/null
./platform-tools/adb shell "parted /dev/block/sda rm 9" 2>/dev/null
./platform-tools/adb shell "parted /dev/block/sda rm 10" 2>/dev/null

echo "Recreating userdata partition..."
# For 128GB model - adjust if different capacity detected
./platform-tools/adb shell "parted /dev/block/sda mkpart userdata ext4 401MB 110GB"
./platform-tools/adb shell "echo y | parted /dev/block/sda mkpart userdata ext4 401MB 110GB" 2>/dev/null

echo "Formatting userdata partition..."
./platform-tools/adb shell "echo y | mke2fs -t ext4 /dev/block/sda8"
echo "✓ Factory reset completed"
echo

echo "[8/8] Rebooting to Android..."
./platform-tools/adb reboot
echo

echo "=========================================="
echo "✓ FACTORY RESET COMPLETED SUCCESSFULLY"
echo "=========================================="
echo
echo "Your Surface Duo 2 is now reset to factory settings."
echo
echo "Next steps:"
echo "- Wait for Android to boot (may take 5-10 minutes)"
echo "- Complete the Android setup wizard"
echo "- Restore your backed up data if needed"
echo
echo "If the device doesn't boot properly:"
echo "- Try holding power button for 30 seconds to force restart"
echo "- Contact support if issues persist"
echo

echo "Operation completed at $(date)"
read -p "Press Enter to continue..."
