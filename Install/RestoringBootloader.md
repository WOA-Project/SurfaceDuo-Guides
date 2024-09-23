# Restoring the Bootloader on Surface Duo

Table of Contents:

* [Restoring the Bootloader on Surface Duo](#restoring-the-bootloader-on-surface-duo)
   * [Files/Tools Needed](#filestools-needed)
* [Steps](#steps)
   * [Acquiring all files](#acquiring-all-files)
   * [Restoring the bootloader](#restoring-the-bootloader)
   * [The End](#the-end)

## Files/Tools Needed

- A Windows PC

## Disclaimers

> [!WARNING]
> - If you see a warning and/or error during the process, it is not normal. Contact us on telegram if you see anything odd, but do not continue or proceed on your own, you will break things further.

> [!IMPORTANT]
> **THIS WILL WIPE ALL YOUR ANDROID™ DATA**
>
> We don't take any responsibility for any damage done to your phone. By following this guide, you agree to take full responsibility of your actions. We have done some testing,
>
> but this is **STILL IN PREVIEW** and things can go wrong.

**PLEASE READ AND BE SURE TO UNDERSTAND THE ENTIRE GUIDE BEFORE STARTING**

If you caused modifications to Android™ system partitions and are not knowingly using Custom Trusted Boot certificates or do not know what we're talking about here but flashed a dual boot image onto your device, you need to revert this. Please see the dual boot guide for assistance first and foremost. Otherwise below's steps will brick your device.

# Steps

## Make sure you have not done any dual boot guide!

If you have followed a guide to use dual boot, please first remove dual boot by following the uninstall section in the dual boot guide, this is important: [DualBoot](/Install/DualBoot.md)

## Install WOA Device Manager

| Steps | Illustration |
|-|-|
| Visit WOA Device Manager in the Microsoft Store | <a href="https://apps.microsoft.com/detail/WOA%20Device%20Manager/9pf2xmfnsbmj?mode=direct"><img src="https://get.microsoft.com/images/en-us%20dark.svg" width="200"/></a> |
| Tap the View in Store button | <img align="right" width="425" alt="image"  src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/1be9c5fa-5434-4167-b23c-1899e0192134"> |
| Tap Install | <img align="right" width="425" alt="image"  src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/4ffe3b30-e8a7-44a4-a7a2-57e1f105a9ab"> |
| Wait til the installation is completed | <img align="right" width="425" alt="image"  src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/6c7ef3dd-13b3-4371-bae4-f6629a61cc71"> |
| And click open | <img align="right" width="425" alt="image"  src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/26e48e1b-96b8-4c87-a2a5-4d1e0049f7e9"> |
| WOA Device Manager should now open on your screen. | <img align="right" width="425" alt="Screenshot 2024-06-22 183133" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/ba7b4289-1c23-4138-9428-1d9e8c90af10"> |

Congratulations, you successfully installed WOA Device Manager.

## In order to relock the bootloader

> [!IMPORTANT]
> Backup all your data.
> **_You will lose everything you have on Android™ and will start from scratch_**.

| Steps | Illustration |
|-|-|
| Assuming your Surface Duo is booted to Android™, plugged to your PC, Using the Microsoft Launcher, find the settings app | <img align="right" width="425" alt="A1 Android™ - Open Settings" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/36ef925c-fe98-4ec6-9861-c1037d8ced19"> |
| Open the Android™ Settings app | <img align="right" width="425" alt="A2 Android™ - Settings Opened" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/02b78630-d2b2-4211-abe1-c89255fe9bc6"> |
| Scroll down to the about section, and open it | <img align="right" width="425" alt="A3 Android™ - Settings About" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/0dad0ac3-21f3-42fd-a02c-78e9eb399118"> |
| Scroll all the way down til you see the Build Number field | <img align="right" width="425" alt="A4 Android™ - Settings About Down" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/afac2404-9624-4298-9785-b6a21bc31699"> |
| Press the Build number field 7 times consecutively, you should first start to see a popup after 3 taps | <img align="right" width="425" alt="A5 Android™ - Settings About Down Tap Dev" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/b850bef7-2938-47a0-b781-c54178e3cf7d"> |
| Once done tapping 7 times, you should be seeing this popup instead | <img align="right" width="425" alt="A6 Android™ - Settings About Down Tap Dev Done" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/8afef456-00a4-41e7-9653-c91a901e16c1"> |
| Now go to the System section, you should see a new Developer options section like shown below | <img align="right" width="425" alt="A7 Android™ - Settings System with Dev" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/a2de44f2-b492-450a-830a-5e7141e232b7"> |
| Go to the Developer options section | <img align="right" width="425" alt="Android™ Settings System Dev Options" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/ffbbcee9-98ab-4b83-8eaa-57487c1c1cf0"> |
| Scroll all the way down til you see the "USB debugging" option | <img align="right" width="425" alt="Android™ Settings - Dev - Debugging Option" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/3847fdcb-c19c-4c5d-aa4c-00a60e85c2b0"> |
| And turn on the "USB debugging" option | <img align="right" width="425" alt="Android™ Settings - Dev - Debugging Option Confirmation" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/60b52b98-8c6a-4845-833d-470378206fb2"> |
| WOA Device Manager should now stop showing the previous error banner after you allowed the connection | <img align="right" width="425" alt="" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/001215d0-4bbb-4ba1-839c-552890fbc1b7"> |
| In WOA Device Manager, go to Restore Bootloader | <img align="right" width="425" alt="" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/80bb8fcb-c62d-43c9-89ff-6d1bb75635ea"> |
| And click Restore Bootloader | <img align="right" width="425" alt="" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/95ff6e39-f4f8-43c7-8bff-a1cd93acfb1c"> |
| Confirm the dialog asking you if you are really sure to do this | <img align="right" width="425" alt="" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/4d17812d-6c4e-453c-b005-04e512f66fc9"> |
| Confirm that you want to restore the bootloader using your device side buttons, your device will erase itself and restart into the Android™ Out of box Experience Again.
If your device doesn't go into Android™ but the bootloader menu, this means you performed additional modifications to your device previously, and you must undo them. You need to reunlock your device now using "fastboot flashing unlock", and undo them according to the instructions you or someone else provided you) | <img align="right" width="425" alt="" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/263cd8c1-2597-4c65-9dfe-344b6e363dfb"> |

Congratulations, you successfully relocked your bootloader.

You should now be seeing the Android™ Out of Box Experience (OOBE).

| Steps | Illustration |
|-|-|
| Setup your phone to confirm it works correctly. | <img align="right" width="425" alt="Android™ - OOBE" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/5f86cbbe-df08-4ba6-92aa-b7fd2a7f72b3"> |

Now, you may want to forbid unlocking the bootloader again for additional security and peace of mind

## In order to turn off the ability to unlock the bootloader of the device

| Steps | Illustration |
|-|-|
| Assuming your Surface Duo is booted to Android™, plugged to your PC, Using the Microsoft Launcher, find the settings app | <img align="right" width="425" alt="A1 Android™ - Open Settings" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/36ef925c-fe98-4ec6-9861-c1037d8ced19"> |
| Open the Android™ Settings app | <img align="right" width="425" alt="A2 Android™ - Settings Opened" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/02b78630-d2b2-4211-abe1-c89255fe9bc6"> |
| Scroll down to the about section, and open it | <img align="right" width="425" alt="A3 Android™ - Settings About" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/0dad0ac3-21f3-42fd-a02c-78e9eb399118"> |
| Scroll all the way down til you see the Build Number field | <img align="right" width="425" alt="A4 Android™ - Settings About Down" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/afac2404-9624-4298-9785-b6a21bc31699"> |
| Press the Build number field 7 times consecutively, you should first start to see a popup after 3 taps | <img align="right" width="425" alt="A5 Android™ - Settings About Down Tap Dev" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/b850bef7-2938-47a0-b781-c54178e3cf7d"> |
| Once done tapping 7 times, you should be seeing this popup instead | <img align="right" width="425" alt="A6 Android™ - Settings About Down Tap Dev Done" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/8afef456-00a4-41e7-9653-c91a901e16c1"> |
| Now go to the System section, you should see a new Developer options section like shown below | <img align="right" width="425" alt="A7 Android™ - Settings System with Dev" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/a2de44f2-b492-450a-830a-5e7141e232b7"> |
| Go to the Developer options section | <img align="right" width="425" alt="Android™ Settings System Dev Options" src="https://github.com/WOA-Project/SurfaceDuo-Guides/assets/3755345/ffbbcee9-98ab-4b83-8eaa-57487c1c1cf0"> |
| Turn off the "OEM unlocking" option as shown above, then turn off the developer options toggle at the very top | |

Congratulations, your Surface Duo is back to factory settings.

## The End

And we're done, please continue with the previous guide that made you land here :)

---

_**© 2020-2024 The Duo WOA Authors**_

_Snapdragon is a registered trademark of Qualcomm Incorporated. Microsoft, the Microsoft Corporate Logo, Windows, Surface, Surface Duo, Windows Hello, Continuum, Hyper-V, and DirectX are registered trademarks of Microsoft Corporation in the United States. Android is a registered trademark of Google LLC. Miracast is a registered trademark of the Wi-Fi Alliance. Other binaries may be copyright Qualcomm Incorporated and Microsoft Surface._

_**Limited emergency calling**_

_Running Windows on your Surface Duo is not a replacement for a proper phone operating system and does not have emergency calling capabilities._

_**Hello from Seattle (US), France, Italy.**_
