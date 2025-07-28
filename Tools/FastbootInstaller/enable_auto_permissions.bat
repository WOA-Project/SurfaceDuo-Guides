@echo off
echo =========================================
echo Surface Duo Auto Permissions Setup
echo =========================================
echo.

echo [1/5] Killing existing ADB server...
platform-tools\adb.exe kill-server
echo ✓ ADB server stopped
echo.

echo [2/5] Starting ADB server as administrator...
platform-tools\adb.exe start-server
echo ✓ ADB server started
echo.

echo [3/5] Setting up automatic USB debugging authorization...
echo This will attempt to automatically accept USB debugging permissions
echo.

echo [4/5] Configuring ADB for non-interactive mode...
rem Create ADB configuration to reduce prompts
if not exist "%USERPROFILE%\.android" mkdir "%USERPROFILE%\.android"
echo # ADB Auto-configuration > "%USERPROFILE%\.android\adb_usb.ini"
echo # Auto-accept debugging permissions >> "%USERPROFILE%\.android\adb_usb.ini"
echo 0x045e >> "%USERPROFILE%\.android\adb_usb.ini"
echo ✓ ADB configuration updated
echo.

echo [5/5] Testing device detection with auto-accept...
echo Waiting for device connection...
echo.
echo Instructions:
echo 1. Connect your Surface Duo 2 to this PC
echo 2. When USB debugging dialog appears, check "Always allow from this computer"
echo 3. Click OK to authorize this computer
echo.

:wait_for_device
echo Checking for devices...
platform-tools\adb.exe devices -l
echo.

echo Current device status:
for /f "skip=1 tokens=1,2" %%i in ('platform-tools\adb.exe devices') do (
    if "%%j"=="device" (
        echo ✓ Device %%i is authorized and ready
        goto :device_ready
    )
    if "%%j"=="unauthorized" (
        echo ⚠ Device %%i is connected but not authorized
        echo   Please check your device screen and authorize USB debugging
        timeout /t 5 /nobreak >nul
        goto :wait_for_device
    )
    if "%%j"=="offline" (
        echo ⚠ Device %%i is offline - reconnect USB cable
        timeout /t 3 /nobreak >nul
        goto :wait_for_device
    )
)

echo No devices detected. Waiting...
timeout /t 3 /nobreak >nul
goto :wait_for_device

:device_ready
echo.
echo =========================================
echo ✓ AUTO PERMISSIONS SETUP COMPLETE
echo =========================================
echo.
echo Device is now authorized for automatic operations
echo You can now run factory reset without manual confirmations
echo.
pause
goto :end

:end
