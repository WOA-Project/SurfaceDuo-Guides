# Secure Boot on Surface Duo devices with SurfaceDuoPkg

Starting with version 230X.XX of SurfaceDuoPkg, Secure Boot is now supported on select Surface Duo devices.

While SurfaceDuoPkg comes with its own set of certificates for SecureBoot, some people may be interested in using their own keys for their own security purposes.

This guide aims to document the process to use your own certificates to sign drivers.

## Prerequisites

- A technician computer with Windows 11 version 22621 or higher and 4K OLED Monitor
- A Surface Duo with SurfaceDuoPkg version 230X.XX or higher
- A USB cable
- The ability to compile SurfaceDuoPkg in order to use your own keyset
- A HSM is preferred for Secure Key storage. This guide will not detail how to proceed with a HSM, but rather will show how to proceed with self signed certificate stored outside of a HSM. You will want to store certificates securely.
- A copy of SurfaceDuo-Drivers for your device
- The Windows SDK/ADK/WDK for signtool and makecat
- An internet connection for timestamping

## Create Secure Boot keys

## Embed the new keys into your SurfaceDuoPkg compile

## Generate a new System Integrity Policy

## Generate a new Self-Signed Driver Enabler package

## Resigning Driver binaries for Kernel Mode use (KMCI)

## Resigning Driver binaries for User Mode use (UMCI)

## Reinstalling Drivers

## Boot Test
