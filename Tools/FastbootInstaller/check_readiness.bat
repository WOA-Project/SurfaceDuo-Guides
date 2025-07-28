@echo off
echo ======================================
echo Surface Duo Fastboot Readiness Check
echo ======================================
echo.

echo [1/6] Checking ADB availability...
if exist "platform-tools\adb.exe" (
    echo ✓ ADB found
    platform-tools\adb.exe version | findstr "Android Debug Bridge"
) else (
    echo ✗ ADB not found
    goto :error
)
echo.

echo [2/6] Checking Fastboot availability...
if exist "platform-tools\fastboot.exe" (
    echo ✓ Fastboot found
    platform-tools\fastboot.exe --version | findstr "fastboot version"
) else (
    echo ✗ Fastboot not found
    goto :error
)
echo.

echo [3/6] Checking TWRP image...
if exist "surfaceduo2-twrp.img" (
    echo ✓ Surface Duo 2 TWRP image found
    for %%I in (surfaceduo2-twrp.img) do echo   Size: %%~zI bytes
) else (
    echo ✗ TWRP image not found
    goto :error
)
echo.

echo [4/6] Checking parted tool...
if exist "parted" (
    echo ✓ Parted tool found
    for %%I in (parted) do echo   Size: %%~zI bytes
) else (
    echo ✗ Parted tool not found
    goto :error
)
echo.

echo [5/6] Checking USB drivers...
if exist "USB-Drivers.zip" (
    echo ✓ USB drivers archive found
    for %%I in (USB-Drivers.zip) do echo   Size: %%~zI bytes
) else (
    echo ✗ USB drivers not found
    goto :error
)
echo.

echo [6/6] Checking for connected devices...
echo Checking ADB devices:
platform-tools\adb.exe devices
echo.
echo Checking Fastboot devices:
platform-tools\fastboot.exe devices
echo.

echo ======================================
echo ✓ SYSTEM READY FOR SURFACE DUO FASTBOOT
echo ======================================
echo.
echo Next steps:
echo 1. Connect your Surface Duo 2 to this PC
echo 2. Enable USB Debugging in Developer Options
echo 3. If device not detected, install USB drivers from USB-Drivers.zip
echo 4. Run factory reset script when ready
echo.
goto :end

:error
echo.
echo ======================================
echo ✗ SYSTEM NOT READY
echo ======================================
echo Please ensure all required files are downloaded.
echo.

:end
pause
