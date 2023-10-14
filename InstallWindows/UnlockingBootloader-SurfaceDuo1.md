# Unlocking the Bootloader on Surface Duo (1st Gen)

## Files/Tools Needed 📃

- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)
- A Windows PC

> [!WARNING]
> - Don't create partitions from Mass Storage Mode on Windows (because ABL will break with blank/spaces in names), your phone may be irrecoverable otherwise
> - If you see a warning and/or error during the process, it is not normal. Contact us on telegram if you see anything odd, but do not continue or proceed on your own, you will break things further.
> - Don't rerun the commands if you interrupt the process. You may break your partition table.
> - Do not run all commands at once.
> - Do not commit *any* typo with *any* commands.
> - Be familiar with command line interfaces.
> - When using TWRP, it is normal and expected for the phone to be detected as a Xiaomi phone and for touch to not work.

> [!IMPORTANT]
> **THIS WILL WIPE ALL YOUR ANDROID™ DATA**
>
> We don't take any responsibility for any damage done to your phone. By following this guide, you agree to take full responsibility of your actions. We have done some testing,
>
> but this is **STILL IN PREVIEW** and things can go wrong.

**PLEASE READ AND BE SURE TO UNDERSTAND THE ENTIRE GUIDE BEFORE STARTING**

## What you will get 🛒

You will end up with both Android™ and Windows on your Surface Duo. Android™ and Windows will both split the internal storage (64GB and 64GB or 128GB and 128GB).

Android™ will boot normally, and you will have to use a PC to boot Windows when needed, unless you create a dual boot image (explained later).

# Steps 🛠️

## Unlocking the bootloader

- Backup all your data. **_You will lose everything you have on Android™ and will start from scratch_**.

- In Android™ settings, enable the Developer Settings menu (7 consecutive taps on Build Number), and turn on "OEM Unlock" and "USB Debugging" inside it.

Assuming your Surface Duo is booted to Android™, plugged to your PC:

- Open a command prompt on your PC and run this command:
```batch
adb reboot bootloader
```

You will be rebooted to Surface Duo's bootloader.

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

- From there:

```batch
fastboot flashing unlock
```

Your phone will wipe itself and reboot to the Out of Box Experience in Android™ (OOBE). From there:

- In Android™ settings, enable the Developer Settings menu (7 consecutive taps on Build Number), and turn on "USB debugging" inside it.

## The End

And we're done, please continue to [Partitioning](Partitioning-SurfaceDuo1.md)