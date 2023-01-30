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
| Windows vNext (Zinc Semester)                                             | ✅         |


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
| Windows vNext (Zinc Semester)                                             | ✅         |


❌: Not supported, important issues present

⚠️: Not supported, minor issues present, not actively maintained anymore

✅: Fully supported, known issues present but nothing impactful, actively maintained

---

It should be noted that development primarly is ongoing with the vNext release of Windows 11, and lower versions may be more broken than newer ones. Above table lists all Operating System versions ever released for ARM64 Processors. 1709, 1803 and 1809 are not supported due to being too old to support the Snapdragon 855 System on a Chip (SoC).

While Surface Duo *technically* supports Windows 10X, no appropriate Windows 10X image is available for *dual screen* ARM64 devices, *only* Single Screen, therefore Windows 10X is not provided as an option. It is still however possible to install it if you're curious, documentation on how to do this may get published at a later time.

## Steps

- Presuming you are working on a Windows AMD64 machine, download and extract the ```win-x64.zip``` file from [the UUPMediaCreator repo](https://github.com/gus33000/UUPMediaCreator/releases/latest).
(if you are on a Windows ARM64 machine, use win-arm64 instead, etc..)

NOTE: For apps to be included in the image for 22H1 or higher, please run the tool on Windows 11.

- Navigate to this directory: `"win-x64\CLI"`

### Download commands

-  Inside the CLI directory, open command prompt and run one of following commands (depending on what version of Windows you would like to use):

_Windows 11 Version 22h2_
```batch
uupdownload -s Professional -e Professional -v 10.0.22621.100 -r Retail -b Retail -c ni_release -t arm64 -l en-US
```

_Windows 11 Version Next (Release Preview)_
```batch
uupdownload -s Professional -e Professional -v 10.0.22621.100 -r External -b ReleasePreview -c ni_release -t arm64 -l en-US
```

_Windows 11 Version Next (Beta)_
```batch
uupdownload -s Professional -e Professional -v 10.0.22621.100 -r External -b Beta -c ni_release -t arm64 -l en-US
```

_Windows vNext (Dev)_
```batch
uupdownload -s Professional -e Professional -v 10.0.22000.100 -r External -b Dev -c co_release -t arm64 -l en-US
```

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
