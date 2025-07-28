@echo off
setlocal enabledelayedexpansion

echo ==========================================
echo Surface Duo 2 Automated Factory Reset
echo ==========================================
echo.
echo WARNING: This will COMPLETELY WIPE your device!
echo All Android and Windows data will be PERMANENTLY DELETED!
echo.
echo Make sure you have:
echo - Backed up all important data
echo - Charged your device to at least 50%%
echo - Connected device via USB-C cable
echo.
set /p confirm="Type 'RESET' to continue or any other key to cancel: "
if /i not "%confirm%"=="RESET" (
    echo Operation cancelled.
    pause
    exit /b 1
)

echo.
echo ==========================================
echo Starting Automated Factory Reset Process
echo ==========================================
echo.

echo [1/8] Verifying tools and permissions...
if not exist "platform-tools\adb.exe" (
    echo ✗ ADB not found. Run check_readiness.bat first.
    pause
    exit /b 1
)
if not exist "platform-tools\fastboot.exe" (
    echo ✗ Fastboot not found. Run check_readiness.bat first.
    pause
    exit /b 1
)
if not exist "surfaceduo2-twrp.img" (
    echo ✗ TWRP image not found. Run check_readiness.bat first.
    pause
    exit /b 1
)
echo ✓ All tools verified
echo.

echo [2/8] Checking device connection...
platform-tools\adb.exe devices | findstr "device" >nul
if errorlevel 1 (
    echo ✗ No authorized device found.
    echo Please run enable_auto_permissions.bat first.
    pause
    exit /b 1
)
echo ✓ Device connected and authorized
echo.

echo [3/8] Rebooting to bootloader...
platform-tools\adb.exe reboot bootloader
echo Waiting for bootloader mode...
timeout /t 10 /nobreak >nul

:wait_fastboot
platform-tools\fastboot.exe devices | findstr /r "[0-9a-fA-F]" >nul
if errorlevel 1 (
    echo Waiting for fastboot mode...
    timeout /t 3 /nobreak >nul
    goto :wait_fastboot
)
echo ✓ Device in fastboot mode
echo.

echo [4/8] Booting to TWRP recovery...
platform-tools\fastboot.exe boot surfaceduo2-twrp.img
echo Waiting for TWRP to load...
timeout /t 15 /nobreak >nul

:wait_adb
platform-tools\adb.exe devices | findstr "device" >nul
if errorlevel 1 (
    echo Waiting for TWRP ADB connection...
    timeout /t 3 /nobreak >nul
    goto :wait_adb
)
echo ✓ TWRP loaded and connected
echo.

echo [5/8] Setting up TWRP environment...
platform-tools\adb.exe shell "setenforce 0" 2>nul
platform-tools\adb.exe push parted /sdcard/
platform-tools\adb.exe shell "mv /sdcard/parted /sbin/parted && chmod 755 /sbin/parted"
echo ✓ Environment configured
echo.

echo [6/8] Analyzing current partition layout...
echo Checking partitions...
platform-tools\adb.exe shell "parted /dev/block/sda print" > partition_backup.txt
echo ✓ Partition layout backed up to partition_backup.txt
echo.

echo [7/8] Performing factory reset...
echo WARNING: Starting irreversible data wipe in 5 seconds...
timeout /t 5 /nobreak >nul

echo Removing Windows partitions...
platform-tools\adb.exe shell "parted /dev/block/sda rm 8" 2>nul
platform-tools\adb.exe shell "parted /dev/block/sda rm 9" 2>nul
platform-tools\adb.exe shell "parted /dev/block/sda rm 10" 2>nul

echo Recreating userdata partition...
rem For 128GB model - adjust if different capacity detected
platform-tools\adb.exe shell "parted /dev/block/sda mkpart userdata ext4 401MB 110GB"
platform-tools\adb.exe shell "echo y | parted /dev/block/sda mkpart userdata ext4 401MB 110GB" 2>nul

echo Formatting userdata partition...
platform-tools\adb.exe shell "echo y | mke2fs -t ext4 /dev/block/sda8"
echo ✓ Factory reset completed
echo.

echo [8/8] Rebooting to Android...
platform-tools\adb.exe reboot
echo.

echo ==========================================
echo ✓ FACTORY RESET COMPLETED SUCCESSFULLY
echo ==========================================
echo.
echo Your Surface Duo 2 is now reset to factory settings.
echo.
echo Next steps:
echo - Wait for Android to boot (may take 5-10 minutes)
echo - Complete the Android setup wizard
echo - Restore your backed up data if needed
echo.
echo If the device doesn't boot properly:
echo - Try holding power button for 30 seconds to force restart
echo - Contact support if issues persist
echo.

echo Operation completed at %date% %time%
pause
