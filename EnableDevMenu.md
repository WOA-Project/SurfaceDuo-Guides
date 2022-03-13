# Enabling the Developer Menu again after installing Windows
## Option 1: Do it from inside Windows directly on the Duo

- Open a command prompt directly on the Duo on Windows and run these commands:

```
bcdedit /create /application bootapp /d "Developer Menu"
```

This command above will print a GUID, copy it and replace it in the following commands:

```
bcdedit /set <GUID> nointegritychecks on
bcdedit /set <GUID> path \Windows\System32\boot\developermenu.efi
bcdedit /set <GUID> inherit {bootloadersettings}
bcdedit /set <GUID> device boot
bcdedit /displayorder <GUID> /addlast
```

Done! Enjoy.

## Option 2: Do it from outside Windows, using an external PC

- Reboot to the Duo Bootloader (power + vol down)
- Connect your Duo to your PC
- Run these commands from a command prompt:

```
fastboot boot twrp.img
adb shell
mkdir /sdcard/espmnt
mount /dev/block/sda6 /sdcard/espmnt
quit
adb pull /sdcard/espmnt/EFI/Microsoft/BOOT/BCD BCD
bcdedit /store BCD /create /application bootapp /d "Developer Menu"
```
The last command above will print a GUID, copy it and replace it in the following commands:
```
bcdedit /store BCD /set <GUID> nointegritychecks on
bcdedit /store BCD /set <GUID> path \Windows\System32\boot\developermenu.efi
bcdedit /store BCD /set <GUID> inherit {bootloadersettings}
bcdedit /store BCD /set <GUID> device boot
bcdedit /store BCD /displayorder <GUID> /addlast
adb push BCD /sdcard/espmnt/EFI/Microsoft/BOOT/BCD
```
