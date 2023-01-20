# Using SurfaceDuoPkg with Android Verified Boot (AVB)

Starting with version 230X.XX of SurfaceDuoPkg, Verified Boot is now supported on select Surface Duo devices.

While SurfaceDuoPkg comes with its own set of certificates for VerifiedBoot, some people may be interested in using their own keys for their own security purposes.

This guide aims to document the process to use your own certificates to sign the hybrid boot image.

## Prerequisites

- A technician computer with Windows 11 version 22621 or higher and Windows Subsystem for Linux v2 or equivalent Linux Distribution
- A Surface Duo with SurfaceDuoPkg version 230X.XX or higher
- A USB cable
- A HSM is preferred for Secure Key storage. This guide will not detail how to proceed with a HSM, but rather will show how to proceed with self signed certificate stored outside of a HSM. You will want to store certificates securely.
- A copy of SurfaceDuoPkg
- A copy of the AVB signature transplant utility
- An internet connection for timestamping

## A word of caution

## Create Verified Boot keys

## Create Hybrid UEFI FV / Kernel Boot Image

## Generate AVB Signed Hybrid Boot Image

## Flashing Hybrid Boot Image

## Relocking the Bootloader
