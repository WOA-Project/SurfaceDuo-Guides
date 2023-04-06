# Uninstall Windows 10X

## Files/Tools Needed 📃
- TWRP image: [twrp.img](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/twrp.img)
- Parted: [parted](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/parted)
- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)
- A PC.

## Warnings ⚠️

**THIS WILL WIPE WINDOWS 10X AND ITS DATA**

We don't take any responsibility for any damage done to your phone. By following this guide, you agree to take full responsibility of your actions.
We have done some testing, but this is **AN EARLY PREVIEW** and things can go wrong.

**PLEASE READ AND BE SURE TO UNDERSTAND THE ENTIRE GUIDE BEFORE STARTING**

## What you'll get 🛒

A Surface Duo with the partitions ready to install Windows 11/10, or ready to follow the unistall guide if you want to leave it stock.

## Steps 🛠️

### Not needed but recommended: uninstall the dual boot image:

If you have followed a guide to use dual boot, please first remove dual boot by following the uninstall section in the dual boot guide, this is not necesary but is recommended in case you want update the UEFI image or Android™.

### Booting to TWRP

- Reboot your phone to Surface Duo Bootloader: Press Volume Down + Power until the Microsoft Corporation logo appears on the left, then release the power
  button and keep pressing the volume down button until the bootloader appears.
- Plug your phone to your PC, open a command prompt and run the following command:

```
fastboot boot twrp.img
```

You will now boot to TWRP. Reminder that touch doesn't work on TWRP for now, so you'll have to work through your PC.

### Removing the Windows partition

- Let's copy and run parted:

```
adb push <path to parted> /sdcard/
adb shell "cp /sdcard/parted /sbin/ && chmod 755 /sbin/parted"
adb shell
parted /dev/block/sda
print
```

You'll get a list of partitions.

- Make sure that partition 7 is your Windows partition. We'll assume it is for this guide.
  If it's not, take note of the number and use it in the next steps. Please make sure these are right, or you'll end up
  bricking your Surface Duo.

⚠️ The next command will wipe and remove the Windows 10X partition. ⚠️

```
rm 7
```

### Recreating the Windows partition
Now we need to create the Windows partition again.

<details>
  <summary>If you used the default splits to make the partitions you can just use this command, just be sure to check it correctly depending on your storage variant</summary>
  <p>

- 128GB variant (use this only if you choosed 64GB for Android™ and 64GB for Windows when making the partitions!)
```
mkpart win ntfs 564MB 57344MB
```

- 256GB variant (use this only if you choosed 128GB for Android™ and 128GB for Windows when making the partitions!)
```
mkpart win ntfs 564MB 114688MB
```
    
  </p>
  </details>

If you used a different split between Android™ and Windows you'll need to check where the partition before the Windows one ends, and where the next one starts:
```
mkpart win ntfs [END OF THE PARTITION BEFORE] [START OF THE NEXT PARTITION]
```
To check where the partions ends and start you just need to take a look at the partition table, so type this to show it:
```
print
```
The partition before should be the ESP partition and the next one should be userdata, so we'll asume they are. Take note of the end of ESP, and of the start of userdata and put them in the command.

<details>
  <summary>Example on how to use it</summary>
  <p>    
    
Using this partitions:
```
 6      51.9MB  564MB   512MB   fat16        esp       boot, esp
 8      176GB   240GB   63.7GB               userdata
```
The command should be:
```
# mkpart win ntfs 564MB 176GB
⚠️Don't use this command as it is, it won't probably fit your device and it can damage it. This is only meant to show how the command should be used.
```
  </p>
  </details>

The Windows partition should have been recreated now, we only need to format it. To do so we first need to exit parted:
```
quit
```
And then format the partition 7 (that should be the Windows one) to NTFS:
```
mkfs.ntfs -f /dev/block/sda7
```

Finally, check that Android™ still boots and your data is still there.

After this you will probably want to follow the [reinstall guide](https://github.com/WOA-Project/SurfaceDuo-Guides/blob/main/InstallWindows/ReinstallWindows-SurfaceDuo1.md) if you want to install Windows 11/10 or the [uninstall guide](https://github.com/WOA-Project/SurfaceDuo-Guides/blob/main/InstallWindows/Uninstall-SurfaceDuo1.md) if you want to leave the Duo to stock.
