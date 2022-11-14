# Restore Microsoft Store (Windows 11)
If your Windows 11 build lacks Microsoft Store, follow these steps to fix this issue:

- Get access to its appx from Microsoft Store by using, e.g., [AdGuard Store](https://store.rg-adguard.net/) and the link to the Microsoft Store:
```
https://apps.microsoft.com/store/detail/microsoft-store/9WZDNCRFJBMP?hl=en-us&gl=us
```

- Download Microsoft Store appx istelf, Microsoft.WindowsStore, from the page opened above:

Pick ```Microsoft.WindowsStore_22210.1401.6.0_neutral___8wekyb3d8bbwe.Msixbundle``` or later version.


- Download supporting component, Microsoft.UI.Xaml, from the page opened above:

Pick ```Microsoft.UI.Xaml.2.7_7.2208.15002.0_arm64__8wekyb3d8bbwe.appx``` or later version.

- Run Windows Powershell as Admin to install the supporting component using the command below:

```
Add-AppxPackage -Path .\Microsoft.UI.Xaml.2.7_7.2208.15002.0_arm64__8wekyb3d8bbwe.Appx 
```

- Run Windows Powershell as Admin to install Microsoft Store itself using the command below:

```
Add-AppxPackage -Path .\Microsoft.WindowsStore_22210.1401.6.0_neutral___8wekyb3d8bbwe.Msixbundle 
```
