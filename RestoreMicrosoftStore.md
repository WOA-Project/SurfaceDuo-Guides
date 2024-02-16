# Restore the Microsoft Store (Windows)

If your Windows build lacks the Microsoft Store, follow these steps to fix this issue:

## Method 1: Use the built in Windows Store Reset tool into Windows

Provided your device is connected online, run the following command:

```batch
wsreset -i
```

You should start seeing installation progress in the notification center.

## Method 2: Manually sideload an appx

- Get access to its appx from the Microsoft Store by using, e.g., [AdGuard Store](https://store.rg-adguard.net/) and the link to the Microsoft Store:
```batch
https://apps.microsoft.com/store/detail/microsoft-store/9WZDNCRFJBMP?hl=en-us&gl=us
```

- Download the Microsoft Store appx itself, Microsoft.WindowsStore, from the page opened above:

Pick ```Microsoft.WindowsStore_22210.1401.6.0_neutral___8wekyb3d8bbwe.Msixbundle``` or later version.

- Download supporting component, Microsoft.UI.Xaml, from the page opened above:

Pick ```Microsoft.UI.Xaml.2.7_7.2208.15002.0_arm64__8wekyb3d8bbwe.appx``` or later version.

- Run Windows Powershell as Admin to install the supporting component using the command below:

```batch
Add-AppxPackage -Path .\Microsoft.UI.Xaml.2.7_7.2208.15002.0_arm64__8wekyb3d8bbwe.Appx
```

- Run Windows Powershell as Admin to install the Microsoft Store itself using the command below:

```batch
Add-AppxPackage -Path .\Microsoft.WindowsStore_22210.1401.6.0_neutral___8wekyb3d8bbwe.Msixbundle
```

---

_**© 2020-2024 The Duo WOA Authors**_

_Snapdragon is a registered trademark of Qualcomm Incorporated. Microsoft, the Microsoft Corporate Logo, Windows, Surface, Surface Duo, Windows Hello, Continuum, Hyper-V, and DirectX are registered trademarks of Microsoft Corporation in the United States. Android is a registered trademark of Google LLC. Miracast is a registered trademark of the Wi-Fi Alliance. Other binaries may be copyright Qualcomm Incorporated and Microsoft Surface._

_**Limited emergency calling**_

_Running Windows on your Surface Duo is not a replacement for a proper phone operating system and does not have emergency calling capabilities._

_**Hello from Seattle (US), France, Italy.**_