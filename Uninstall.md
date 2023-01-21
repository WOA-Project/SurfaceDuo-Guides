# Uninstall Windows and revert your Surface Duo to stock

## Files/Tools Needed 📃
- TWRP image: [twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/twrp.img)
- Parted: [parted](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/parted)
- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)
- A PC.

## Warnings ⚠️

**THIS WILL WIPE ALL YOUR ANDROID™ AND WINDOWS DATA**

We don't take any responsibility for any damage done to your phone. By following this guide, you agree to take full responsibility of your actions. 
We have done some testing, but this is **AN EARLY PREVIEW** and things can go wrong.

**PLEASE READ AND BE SURE TO UNDERSTAND THE ENTIRE GUIDE BEFORE STARTING**

## What you'll get 🛒

A normal Surface Duo, with Android™ only. Just like you had it before installing Windows. If you haven't broke anything else in the meantime.

Android™ will have access to the whole memory back again.

## Steps 🛠️

### Booting to TWRP

- Reboot your phone to Surface Duo Bootloader: Press Volume Down + Power until the Microsoft logo appears on the left, then release the power 
  button and keep pressing the volume down button until the bootloader appears.
- Plug your phone to your PC, open a command prompt and run the following command:

```
fastboot boot twrp.img
```

You will now boot to TWRP. Reminder that touch doesn't work on TWRP for now, so you'll have to work through your PC.

### Restoring the original partitions

- Let's copy and run parted:

```
adb push <path to parted> /sdcard/
adb shell "cp /sdcard/parted /sbin/ && chmod 755 /sbin/parted"
adb shell
parted /dev/block/sda
print
```

You'll get a list of partitions.

- Make sure that partitions 6, 7 and 8 are your ESP, Windows and userdata partitions. We'll assume they are for this guide.
  If they aren't, take note of these numbers and use them in the next steps. Please make sure these are right, or you'll end up 
  bricking your Surface Duo.
  
⚠️ The next command will wipe all your data. Please make sure that you have backed everything up. ⚠️
  
```
rm 6
rm 7
rm 8

# FOR 128GB DEVICES ONLY: ---
mkpart userdata ext4 51.9MB 112GB

# FOR 256GB DEVICES ONLY: ---
mkpart userdata ext4 51.9MB 240GB
```

- Once done, run the command `quit` two times.

### Relocking the Bootloader

- Reboot your Surface Duo to the Bootloader: Press Volume Down + Power until the Microsoft logo appears on the left, then release the power 
  button and keep pressing the volume down button until the bootloader appears.

- Run this command:

```
fastboot flashing lock
```

- Reboot your Surface Duo, and Android™ should boot.
