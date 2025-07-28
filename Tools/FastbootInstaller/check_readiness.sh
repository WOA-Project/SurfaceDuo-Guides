#!/bin/bash

echo "======================================"
echo "Surface Duo Fastboot Readiness Check"
echo "======================================"
echo

echo "[1/6] Checking ADB availability..."
if [ -f "platform-tools/adb" ]; then
    echo "✓ ADB found"
    ./platform-tools/adb version | grep "Android Debug Bridge"
else
    echo "✗ ADB not found"
    exit 1
fi
echo

echo "[2/6] Checking Fastboot availability..."
if [ -f "platform-tools/fastboot" ]; then
    echo "✓ Fastboot found"
    ./platform-tools/fastboot --version | grep "fastboot version"
else
    echo "✗ Fastboot not found"
    exit 1
fi
echo

echo "[3/6] Checking TWRP image..."
if [ -f "surfaceduo2-twrp.img" ]; then
    echo "✓ Surface Duo 2 TWRP image found"
    echo "  Size: $(stat -c%s surfaceduo2-twrp.img 2>/dev/null || stat -f%z surfaceduo2-twrp.img) bytes"
else
    echo "✗ TWRP image not found"
    exit 1
fi
echo

echo "[4/6] Checking parted tool..."
if [ -f "parted" ]; then
    echo "✓ Parted tool found"
    echo "  Size: $(stat -c%s parted 2>/dev/null || stat -f%z parted) bytes"
else
    echo "✗ Parted tool not found"
    exit 1
fi
echo

echo "[5/6] Checking USB drivers (Windows only)..."
if [ -f "USB-Drivers.zip" ]; then
    echo "✓ USB drivers archive found"
    echo "  Size: $(stat -c%s USB-Drivers.zip 2>/dev/null || stat -f%z USB-Drivers.zip) bytes"
else
    echo "⚠ USB drivers not found (not needed on Linux/Mac)"
fi
echo

echo "[6/6] Checking for connected devices..."
echo "Checking ADB devices:"
./platform-tools/adb devices
echo
echo "Checking Fastboot devices:"
./platform-tools/fastboot devices
echo

echo "======================================"
echo "✓ SYSTEM READY FOR SURFACE DUO FASTBOOT"
echo "======================================"
echo
echo "Next steps:"
echo "1. Connect your Surface Duo 2 to this PC"
echo "2. Enable USB Debugging in Developer Options"
echo "3. On Linux: Install android-tools-adb if needed"
echo "4. Run factory reset script when ready"
echo

read -p "Press Enter to continue..."
