# Platform Debugging Setup

> [!NOTE]
> This documentation is work in progress

## Requirements

- MTP8150 or MTP8350 (Depending on SoC)
- Hana Debug board (for MTP8150) or Kona Debug Board (for MTP8350)
- USBA to USB Micro Connector
- USBA to USB Type C Connector
- 12V DC Bench Power Supply
- Lauterbach Trace32 Software
- Up to 2 Lauterbach Trace32 ARMv8 Hardware Header (one for main SoC, one for secondary SoC (Modem))
- Up to 2 JTAG cables (one for main SoC, one for secondary SoC (Modem))
- Paper Clip or Sim Eject Tool (for Dip Switches)
- WinDBG X (For Windows Debugging)

## General Station Setup

> [!WARNING]
> Unplug and remove all batteries from the MTP before use!

- Position the MTP on your desk; the screen facing downwards
- Take the matching debug board; making sure the FACE UP Arrow is facing upwards; to the top of the device
- Align the debug board with the 2 mezzanine connectors on the MTP, taking special attention to not misalign the board
- Push down on opposing diagonal empty areas of the debug board til you hear both connectors click. Do not press hard or press on the shield or you will damage them
- Flip the MTP and Debug board Combo back up
- Plug in the DC 12V line into the 12V power in socket of the debug board
- Plug in the USB Micro connector/cable into the UART out port of the debug board
- (Optional) Plug in one or both JTAG connectors into the debug board for JTAG use
- Configure Dip Switches using your paper clip/sim ejector tool as follows:
    - MTP8150:
    - MTP8350:
```
+-ON--------------+
| | | | | | | | | |
| v v v v v v v v |
| 1 2 3 4 5 6 7 8 |
+-----------------+
         S1

+-ON--------------+
| | ^ ^ ^ | | | | |
| v | | | v v v v |
| 1 2 3 4 5 6 7 8 |
+-----------------+
         S4

+-ON--------------+
| | | | | ^ | | | |
| v v v v | v v v |
| 1 2 3 4 5 6 7 8 |
+-----------------+
         S5

+-ON--------------+
| | | | | | | | | |
| v v v v v v v v |
| 1 2 3 4 5 6 7 8 |
+-----------------+
         S6

+-ON--+
| | | |
| v v |
| 1 2 |
+-----+
   S8
```