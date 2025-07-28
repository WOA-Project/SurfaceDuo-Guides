@echo off
title Surface Duo 2 Automated Factory Reset Installer

:menu
cls
echo ===============================================
echo    Surface Duo 2 Automated Factory Reset
echo           Bootable Fastboot Installer
echo ===============================================
echo.
echo What would you like to do?
echo.
echo 1. Check system readiness
echo 2. Setup automatic permissions
echo 3. Run automated factory reset
echo 4. Install unbrick tools
echo 5. View help and documentation
echo 6. Exit
echo.
set /p choice="Enter your choice (1-6): "

if "%choice%"=="1" goto :readiness
if "%choice%"=="2" goto :permissions
if "%choice%"=="3" goto :reset
if "%choice%"=="4" goto :unbrick
if "%choice%"=="5" goto :help
if "%choice%"=="6" goto :exit
echo Invalid choice. Please try again.
pause
goto :menu

:readiness
cls
echo Running system readiness check...
echo.
call check_readiness.bat
echo.
echo Press any key to return to main menu...
pause >nul
goto :menu

:permissions
cls
echo Setting up automatic permissions...
echo.
echo IMPORTANT: Connect your Surface Duo 2 now if not already connected.
echo Make sure USB Debugging is enabled in Developer Options.
echo.
pause
call enable_auto_permissions.bat
echo.
echo Press any key to return to main menu...
pause >nul
goto :menu

:reset
cls
echo ===============================================
echo         FINAL WARNING - FACTORY RESET
echo ===============================================
echo.
echo This will PERMANENTLY DELETE all data on your Surface Duo 2!
echo.
echo Before continuing, ensure you have:
echo ✓ Backed up all important data (photos, contacts, documents)
echo ✓ Device charged to at least 50%%
echo ✓ USB-C cable connected securely
echo ✓ Completed automatic permissions setup (option 2)
echo.
echo This process cannot be undone!
echo.
set /p final="Are you absolutely sure? Type 'YES DELETE EVERYTHING' to continue: "
if /i not "%final%"=="YES DELETE EVERYTHING" (
    echo Operation cancelled for safety.
    pause
    goto :menu
)

echo.
echo Starting automated factory reset...
call auto_factory_reset.bat
echo.
echo Press any key to return to main menu...
pause >nul
goto :menu

:unbrick
cls
echo ===============================================
echo         UNBRICK TOOLS INSTALLATION
echo ===============================================
echo.
echo This will install comprehensive unbrick tools for Surface Duo:
echo.
echo ✓ WOA Device Manager (Official Microsoft Store)
echo ✓ PixelFlasher (Advanced flashing tool)
echo ✓ Additional ADB/Fastboot utilities
echo ✓ Surface Duo recovery images
echo ✓ Emergency recovery guides
echo.
echo These tools can help recover bricked devices that
echo cannot be fixed with normal factory reset.
echo.
set /p unbrick_confirm="Install unbrick tools? (Y/N): "
if /i "%unbrick_confirm%"=="Y" (
    echo.
    echo Installing unbrick tools...
    call install_unbrick_tools.bat
    echo.
    echo Unbrick tools installation completed!
    echo See UNBRICK_GUIDE.md for usage instructions.
) else (
    echo Installation cancelled.
)
echo.
echo Press any key to return to main menu...
pause >nul
goto :menu

:help
cls
echo ===============================================
echo      Surface Duo 2 Factory Reset - Help
echo ===============================================
echo.
echo OVERVIEW:
echo This tool provides a complete automated solution for factory
echo resetting your Surface Duo 2 device using fastboot commands.
echo.
echo PROCESS STEPS:
echo 1. System Readiness Check - Verifies all tools are available
echo 2. Automatic Permissions - Sets up device authorization
echo 3. Automated Factory Reset - Performs the actual reset
echo.
echo REQUIREMENTS:
echo - Surface Duo 2 with unlocked bootloader
echo - USB-C cable for connection
echo - USB Debugging enabled in Developer Options
echo - Windows PC with this installer
echo.
echo WHAT GETS WIPED:
echo - All Android user data and apps
echo - All Windows installations (if present)
echo - All personal files and settings
echo - Device returns to out-of-box state
echo.
echo WHAT STAYS:
echo - Android operating system
echo - Bootloader (remains unlocked)
echo - Hardware functionality
echo.
echo FILES INCLUDED:
echo - Platform Tools (ADB/Fastboot)
echo - Surface Duo 2 TWRP Recovery
echo - Partition management tools
echo - USB drivers for Windows
echo.
echo SAFETY FEATURES:
echo - Multiple confirmation prompts
echo - Partition backup before changes
echo - Device state verification
echo - Automatic error detection
echo.
echo SUPPORT:
echo If you encounter issues, check the partition_backup.txt file
echo created during the process and contact the WOA Project team.
echo.
echo For more information, see README.md
echo.
pause
goto :menu

:exit
cls
echo Thank you for using Surface Duo 2 Factory Reset Installer
echo.
echo Remember to safely disconnect your device after any operations.
echo.
pause
exit

:error
cls
echo ===============================================
echo                    ERROR
echo ===============================================
echo.
echo An error occurred during the operation.
echo Please check the following:
echo.
echo - Device is properly connected
echo - USB Debugging is enabled
echo - Device is authorized for ADB
echo - All required files are present
echo.
echo Try running the readiness check (option 1) to diagnose issues.
echo.
pause
goto :menu
