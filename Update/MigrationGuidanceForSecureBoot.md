# Migration Guidance for Secure Boot

Previous installations require a tiny configuration change in order to be bootable again with Secure Boot enabled.

## Switching to Mass Storage Mode

- Start by booting TWRP:

```
fastboot boot surfaceduo1-twrp.img
```

- Once inside TWRP, touch will not be working and the device will say it is locked. This is completely normal. Keep the phone plugged to your PC and do these commands ONE BY ONE WITH NO TYPO!:

```
adb push <path to downloaded surfaceduo1-msc.tar> /sdcard/
adb shell "tar -xf /sdcard/surfaceduo1-msc.tar -C /sdcard --no-same-owner"
adb shell "chmod +x /sdcard/msc.sh"
adb shell "/sdcard/msc.sh"
```

- Make sure you are in Mass Storage Mode, that your Surface Duo is plugged into your PC
- Mount the partitions you have created using diskpart and assign them some letters:

```
⚠️ THESE ARE NOT ALL COMMANDS. DISKPART COMMANDS VARY A LOT, SO THESE ARE SOME ROUGH INSTRUCTIONS.
ACTUAL COMMANDS START WITH AN HASHTAG (which you will need to remove)
YOU DO NOT HAVE TO USE Y or X, THEY ONLY NEED TO BE FREE LETTERS. IF LETTERS DONT ASSIGN FINE, USE ANOTHER ONE.
IF ONE PARTITION IS ALREADY ASSIGNED, YOU ALSO DO NOT NEED TO ASSIGN IT AGAIN IF YOU DONT WANT TO.

# list disk
Find the Surface Duo Disk, and take note of the number.
# select disk <number>
# list partition
You will be able to recognize the partitions we made earlier by their size. take note of the ESP and WIN partition numbers.
# select partition <esp-partition-number>
# assign letter=Y:
# select partition <win-partition-number>
# assign letter=X:
```

- You will have two partitions loaded, one is the ESP partition, and the other is the Win partition. Take note of the letters you've used.

- Now we want to enable driver signature checks (otherwise Windows will go to automatic repair at boot):

```
bcdedit /store "Y:\EFI\Microsoft\BOOT\BCD" /deletevalue "{default}" testsigning
```

- Once it is done, you can reboot your phone using ```adb reboot bootloader```. You will be able to boot to Android and your phone will work normally. Set it up if you need it.

You will be back into Surface Duo's bootloader. 