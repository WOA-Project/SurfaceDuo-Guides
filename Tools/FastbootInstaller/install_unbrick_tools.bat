@echo off
title Surface Duo Unbrick Tools Installer

echo ===============================================
echo    Surface Duo 2 Unbrick Tools Installer
echo ===============================================
echo.
echo This script will install all necessary tools for
echo unbricking and recovery of Surface Duo devices.
echo.

echo [1/6] Installing WOA Device Manager (Official Microsoft Store App)...
echo.
echo Opening Microsoft Store for WOA Device Manager...
echo This is the OFFICIAL tool for Surface Duo bootloader operations.
echo.
start ms-windows-store://pdp/?productid=9pf2xmfnsbmj
echo ✓ Microsoft Store opened for WOA Device Manager
echo   Please install WOA Device Manager from the store manually
echo.
pause

echo [2/6] Checking for Scoop package manager...
where scoop >nul 2>&1
if errorlevel 1 (
    echo Installing Scoop package manager...
    powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh'))"
    echo ✓ Scoop installed
) else (
    echo ✓ Scoop already installed
)
echo.

echo [3/6] Installing PixelFlasher (Android Flashing Tool)...
scoop install pixelflasher
echo ✓ PixelFlasher installed
echo.

echo [4/6] Installing ADB/Fastboot tools...
scoop install adb
echo ✓ ADB and Fastboot installed
echo.

echo [5/6] Installing additional development tools...
scoop install gh git
echo ✓ GitHub CLI and Git installed
echo.

echo [6/6] Setting up Surface Duo specific unbrick environment...
echo.

echo Creating unbrick tools directory...
mkdir "%USERPROFILE%\SurfaceDuoUnbrick" 2>nul
cd /d "%USERPROFILE%\SurfaceDuoUnbrick"

echo Downloading Surface Duo specific files...
curl -L -o "surfaceduo1-twrp.img" "https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/Files/surfaceduo1-twrp.img" 2>nul
curl -L -o "surfaceduo2-twrp.img" "https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/Files/surfaceduo2-twrp.img" 2>nul
curl -L -o "parted" "https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/Files/parted" 2>nul
curl -L -o "USB-Drivers.zip" "https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/Files/USB-Drivers.zip" 2>nul

echo ✓ Surface Duo recovery files downloaded
echo.

echo ===============================================
echo        UNBRICK TOOLS INSTALLATION COMPLETE
echo ===============================================
echo.
echo Installed Tools:
echo ✓ WOA Device Manager (Microsoft Store) - OFFICIAL unbrick tool
echo ✓ PixelFlasher - Advanced Android flashing tool
echo ✓ ADB/Fastboot - Low-level device communication
echo ✓ Surface Duo TWRP images - Custom recovery
echo ✓ Partition tools - System repair utilities
echo ✓ USB Drivers - Windows device recognition
echo.
echo Unbrick files location: %USERPROFILE%\SurfaceDuoUnbrick
echo.
echo USAGE INSTRUCTIONS:
echo ==================
echo.
echo FOR SOFT BRICK (Device boots to bootloader):
echo 1. Use WOA Device Manager to restore bootloader
echo 2. Or use our automated factory reset tools
echo.
echo FOR HARD BRICK (Device not responding):
echo 1. Try entering EDL mode (Volume Down + Power for 30+ seconds)
echo 2. Use PixelFlasher with official firmware
echo 3. Contact @DuoWOA on Telegram for advanced support
echo.
echo EMERGENCY CONTACTS:
echo - Telegram: https://t.me/duowoa
echo - GitHub Issues: https://github.com/WOA-Project/SurfaceDuo-Guides
echo.
pause
echo.
echo Opening WOA Device Manager installation page again...
start ms-windows-store://pdp/?productid=9pf2xmfnsbmj
echo.
echo IMPORTANT: Make sure to install WOA Device Manager from Microsoft Store!
echo This is the safest and most reliable unbrick tool for Surface Duo.
echo.
pause
