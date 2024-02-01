# Flashing a Full Flash Update Image (.FFU) on Surface Duo (1st Gen)

![Surface Duo Dual Screen Windows](https://user-images.githubusercontent.com/3755345/170788230-a42e624a-d2ed-4070-b289-a9b34774bcd0.png)

## Files/Tools Needed 📃

- Windows UEFI: [Surface.Duo.1st.Gen.UEFI.Fast.Boot.zip/uefi.img](https://github.com/WOA-Project/SurfaceDuoPkg/releases/)
- [Platform Tools from Google (ADB and Fastboot)](https://developer.android.com/studio/releases/platform-tools)
- [FFU Tools](https://github.com/WOA-Project/SurfaceDuo-Guides/raw/main/InstallWindows/Files/FFU-Loader-Tools.zip)
- An FFU file for Surface Duo (1st Gen): [FFU Release Channel](https://t.me/DuoWOA_FFUs)
- A Windows PC to flash the device

> [!WARNING]
> - If you see a warning and/or error during the process, it is not normal. Contact us on telegram if you see anything odd, but do not continue or proceed on your own, you will break things further.
> - Do not run all commands at once.
> - Do not commit *any* typo with *any* commands.
> - Be familiar with command line interfaces.

> [!IMPORTANT]
> **THIS WILL WIPE ALL YOUR ANDROID™ DATA AND WINDOWS DATA!**
>
> We don't take any responsibility for any damage done to your phone. By following this guide, you agree to take full responsibility of your actions. We have done some testing,
>
> but this is **STILL IN PREVIEW** and things can go wrong.

**PLEASE READ AND BE SURE TO UNDERSTAND THE ENTIRE GUIDE BEFORE STARTING**

## What you will get 🛒

You will end up with both Android™ and Windows on your Surface Duo. Android™ and Windows will both split the internal storage.

Android™ will boot normally, and you will have to use a PC to boot Windows when needed, unless you create a dual boot image (explained later).

# Steps 🛠️

## Unlocking the Bootloader

If not already done, please first proceed with the [Unlocking the Bootloader](UnlockingBootloader-SurfaceDuo1.md) guide for Surface Duo (1st Gen). Come back once you're done. If you already followed this guide, please skip the unlocking section.

## Getting to FFU Loader

- Reboot into the Bootloader mode by running this command while inside Android™:

```batch
adb reboot bootloader
```

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

- Start by booting the UEFI:

```batch
fastboot boot uefi.img
```

- Press the Volume Down Key on the side of your device til you see something like shown below on screen:

![Surface Duo in FFU Loader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/f35ba53d-70c6-41de-9cca-ad31368a35fb)

Congratulations, you're now in FFU Loader.

## Flashing the Windows FFU Image

- Open a command prompt where you extracted the FFU-Loader-Tools archive, and run the following commands:

```batch
ImageUtility.exe FlashDevice -Path <Path to the FFU File you downloaded>
```

![Surface Duo in FFU Loader mode, flashing](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/7770ef0a-62d9-49de-a9b0-f8e4f3a58933)

- You should now see the device flashing on both your computer and on the device, wait til the process is complete. In case the PC complains the device was not found, try using an USB-2 port or cable that downgrades your connection to USB-2, there are known issues with the UEFI that prevent USB-3 from functioning properly at the moment, and will be addressed in a future update.

- Once done you should be seeing the following screen:

![Surface Duo in FFU Loader mode, flashed](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/ba3c33df-9eb5-4b21-90da-7b8b0c3a5faf)

- Now reboot the device, you should be back to the bootloader menu:

```batch
ImageUtility.exe RebootDevice
```

- In case the bootloader menu does not automatically come up, press the volume down when running above command to be 100% sure you go into the bootloader menu.

- Run the following two commands:

```batch
fastboot set_active other
fastboot set_active other
```

- If this is your first time flashing this FFU file, please also erase your Android userdata partition (this is not required if you already flashed this FFU file, or, you previously installed windows manually using our guides on a 128gb device (256gb users need to follow these commands regardless)) (You will have to setup Android again after)

```batch
REM Only if you meet above criteria
fastboot erase userdata
```

## Boot Windows 🚀

We are ready to boot for the first time!

Reboot your device to the Bootloader mode, using adb or from the recovery.

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

Let's boot the UEFI, from a command prompt:

```batch
fastboot boot surfaceduo1-uefi.img
```

This step above will be needed every time you will want to boot Windows and needs to be done from the Bootloader mode.

If you did everything right, Windows will now boot! Enjoy!

**Note:** If the Touch keyboard won't show up in OOBE, touch somewhere else (to let the text box loose focus) and then touch into the text box again. As an alternative, you can use the On-Screen Keyboard.

Let Windows set itself up, and come back once you're on the Windows Desktop on your Surface Duo

**Note 2:** If you get a BSOD (bugcheck screen) during initial setup, you can try erasing both the esp and win partitions using "fastboot erase esp" and "fastboot erase win", and reflash the FFU file, then it should work. This issue will get fixed in later FFU revisions.

## Boot Windows again after initial installation

You'll have two methods of booting Windows.

- Manual booting with a PC
    - Pros: You can freely update Android™
    - Cons: You will need a PC to boot to Windows

- Enabling Dual Boot
    - Pros: You'll be able to boot Windows directly from the device
    - Cons: Every time you update Android™, you'll have to follow [this guide](https://github.com/WOA-Project/SurfaceDuo-Guides/blob/main/InstallWindows/DualBoot-SurfaceDuo.md)

In case you want the dual boot option, then follow [this guide](https://github.com/WOA-Project/SurfaceDuo-Guides/blob/main/InstallWindows/DualBoot-SurfaceDuo.md)

---
<details>
  <summary>In case you want to manually boot each time: (Click to expand)</summary>
  <p>

Reboot your device to the Bootloader mode, using adb or from the recovery.

![Surface Duo in Bootloader mode](https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/eb19d500-4849-4ded-bd0c-894e4ac56486)
_Image of what you should see right now: Surface Duo in Bootloader mode_

Let's boot the UEFI, from a command prompt:

```batch
fastboot boot surfaceduo1-uefi.img
```

This step above will be needed every time you will want to boot Windows and needs to be done from the Bootloader mode.

If you did everything right, Windows will now boot! Enjoy!

**Note:** If the Touch keyboard won't show up in OOBE, touch somewhere else (to let the text box loose focus) and then touch into the text box again. As an alternative, you can use the On-Screen Keyboard.
  </p>
</details>
