# Enabling Dual Boot on Duo

⚠️ Hard requirements: This will only work for **Surface Duo 1** running **Android 12 2022.819.16**.

## Files/Tools Needed 📃
- BOOT image: [boot.img](LINK)
 
## Steps🛠️

- Go to stock recovery
```
adb reboot recovery
```
- Go to fastbootd. To do that, on recovery:
  1. Press and hold **Power** then press **Volume Up**
  2. Release **Volume Up**, release **Power**
     * Do not release the **Power** button before pressing the **Volume Up** button.
  4. Go to "fastboot" in the menu

- Get the Current slot (*Search for current-slot:<slot\>)*
```
fastboot getvar all
```

- Flash the boot img to that slot
```
fastboot flash boot_<slot> <boot.img>
```

## How it Works
- To boot Android, leave Duo open while turning it on
- To boot Windows, close Duo as soon as you turn it on and wait a while to open it again
  
## Troubleshooting
If the device keeps going back to the bootloader menu
```
fastboot set_active <alternative slot from current>
```
