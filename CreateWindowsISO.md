# Creating a Windows ISO with UUPMediaCreator

## Compatibility

### Surface Duo 1

Surface Duo 1 currently supports the following Windows OS versions:

| Operating System                                                          | Supported? |
|---------------------------------------------------------------------------|------------|
| Windows 10 Build 16299 (1709)                                             | ❌         |
| Windows 10 Build 17134 (1803)                                             | ❌         |
| Windows 10 Build 17763 (1809)                                             | ❌         |
| Windows 10 Build 18362 (1903)                                             | ⚠️         |
| Windows 10 Build 18363 (1909)                                             | ⚠️         |
| Windows 10 Build 19041 (2004)                                             | ✅         |
| Windows 10 Build 19042 (20h2)                                             | ✅         |
| Windows 10 Build 19043 (21h1)                                             | ✅         |
| Windows 10 Build 19044 (21h2)                                             | ✅         |
| Windows 10 Build 19045 (22h1)                                             | ✅         |
| Windows 10 Build 19046 (22h2)                                             | ✅         |
| Windows 11 Build 22000 (21h2)                                             | ✅         |
| Windows 11 Build 22621 (22h2)                                             | ✅         |
| Windows 11 Build 22621 (23h1)                                             | ✅         |
| Windows 11 Build 22631 (23h2)                                             | ✅         |
| Windows vNext (Gallium Semester)                                          | ✅         |


❌: Not supported, important issues present

⚠️: Not supported, minor issues present, not actively maintained anymore

✅: Fully supported, known issues present but nothing impactful, actively maintained

### Surface Duo 2

Surface Duo 2 currently supports the following Windows OS versions:

| Operating System                                                          | Supported? |
|---------------------------------------------------------------------------|------------|
| Windows 10 Build 16299 (1709)                                             | ❌         |
| Windows 10 Build 17134 (1803)                                             | ❌         |
| Windows 10 Build 17763 (1809)                                             | ❌         |
| Windows 10 Build 18362 (1903)                                             | ❌         |
| Windows 10 Build 18363 (1909)                                             | ❌         |
| Windows 10 Build 19041 (2004)                                             | ❌         |
| Windows 10 Build 19042 (20h2)                                             | ❌         |
| Windows 10 Build 19043 (21h1)                                             | ❌         |
| Windows 10 Build 19044 (21h2)                                             | ❌         |
| Windows 10 Build 19045 (22h1)                                             | ❌         |
| Windows 10 Build 19046 (22h2)                                             | ❌         |
| Windows 11 Build 22000 (21h2)                                             | ❌         |
| Windows 11 Build 22621 (22h2)                                             | ❌         |
| Windows 11 Build 22621 (23h1)                                             | ❌         |
| Windows 11 Build 22631 (23h2)                                             | ❌         |
| Windows vNext (Gallium Semester)                                          | ✅         |


❌: Not supported, important issues present

⚠️: Not supported, minor issues present, not actively maintained anymore

✅: Fully supported, known issues present but nothing impactful, actively maintained

---

It should be noted that development primarly is ongoing with the vNext release of Windows 11, and lower versions may be more broken than newer ones. Above table lists all Operating System versions ever released for ARM64 Processors. 1709, 1803 and 1809 are not supported due to being too old to support the Snapdragon™ 855 System on a Chip (SoC).

## Steps

- Presuming you are working on a Windows AMD64 machine, download and extract the ```win-x64.zip``` file from [the UUPMediaCreator repo](https://github.com/gus33000/UUPMediaCreator/releases/latest).
(if you are on a Windows ARM64 machine, use win-arm64 instead, etc..)

NOTE: For apps to be included in the image for 22H1 or higher, please run the tool on Windows 11.

- Navigate to this directory: `"win-x64\CLI"`

### Download commands

-  Inside the CLI directory, open command prompt and run one of following commands (depending on what version of Windows you would like to use):

#### Latest Production Versions (Recommended)

This will get you the latest currently supported _stable_ version of Windows 11, which is the recommended option for most people to use on your device.

Windows Insider Program's channel builds may be more unstable, and less tested for use on Surface Duo devices. They'll also break more often than production versions, and require more recurrent updating.

If you value stability, please use below's command to download the latest stable version of Windows 11:

_Windows 11 Version 23h2_
```batch
uupdownload -s Professional -e Professional -v 10.0.22621.100 -r Retail -b Retail -c ni_release -t arm64 -l en-US
```

#### Latest Windows Insider Program Versions

Microsoft releases Insider Preview builds to you through channels, which are each designed to bring you a different experience based on the quality of Windows you need for your life and your device. When choosing a channel, you should keep in mind:

- How stable you need your device to be
- What level of issues you can handle on your device
- How early in development you'd like to see features and changes
- Whether or not you need Microsoft support

As Microsoft continues to evolve the way they're building and releasing Windows in the future, they may introduce new channels to bring you new experiences.

![Windows Insider Channels, Recommended Ones](https://learn.microsoft.com/en-us/windows-insider/images/channelsmovev2.png)

For more information about the insider program, please see the [Windows Insider Program website](https://insider.windows.com)

_Windows 11 Version Next (Release Preview Channel)_
```batch
uupdownload -s Professional -e Professional -v 10.0.22621.100 -r External -b ReleasePreview -c ni_release -t arm64 -l en-US
```

_Windows 11 Version Next (Beta Channel)_
```batch
uupdownload -s Professional -e Professional -v 10.0.22621.100 -r External -b Beta -c ni_release -t arm64 -l en-US
```

_Windows vNext (Dev Channel)_
```batch
uupdownload -s Professional -e Professional -v 10.0.22621.100 -r External -b Dev -c ni_release -t arm64 -l en-US
```

_Windows vNext (Canary Channel)_
```batch
uupdownload -s Professional -e Professional -v 10.0.22621.100 -r External -b CanaryChannel -c ni_release -t arm64 -l en-US
```

---

This will download the professional edition of Windows 11 retail copy for arm64 architecture for English version. If you want to change the language,
use the standard Windows language pack commands. Installing the right language pack will save a lot of time for download.

---

- Once the download is completed, you will see a new folder with prefix "10.0.22000..." created inside the CLI folder. This
  contains all the required Windows 11 files. Let's create an ISO from the Windows 11 build download.
  Open up the command prompt as Administrator and type:

```batch
UUPMediaConverter.exe -u <10.0.22000... name of your Windows 11 build folder> -i Windows11_Pro_arm64_en-US.iso -l en-US -e Professional
```

- Once that's done, mount the newly created `Windows11_Pro_arm64_en-US.iso` on your Windows machine. You will find the install.wim file in your mounted ISO drive in `G:\sources\install.wim`.
