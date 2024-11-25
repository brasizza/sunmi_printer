
# Sunmi printer 4.0.0

Package Sunmi printer will support all sunmi devices with different behaviours

## Important

THIS PACKAGE WILL WORK ONLY IN ANDROID!

This flutter plugin based  Official Sunmi Inner Printer Doc using the latest implementation libs [Documentation](https://developer.sunmi.com/docs/en-US/xeghjk491/mafeghjk535)

You can help me out to keep this package updated!
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/donate?business=5BMWJ9CYNVDAE&no_recurring=0&currency_code=BRL)

## Installation

```bash
 flutter pub add sunmi_printer_plus
```

# Should be a bit break change between versions below 4.0

## What this package do
- [x] Write some text (with style or not!)
- [x] Change font size
- [x] Jump (n) lines
- [x] Draw a divisor line
- [x] Bold mode on/off
- [x] Print all types of Barcodes (see enum below)
- [x] Print Qrcodes with custom width and error-level
- [x] Print image from asset or from web (example show how to print both)
- [x] Print rows like recepit with custom width and alignment
- [x] Able to combine with some esc/pos code that you already have!
- [x] Cut paper - Dedicated method just to cut the line
- [x] Printer serial no - Get the serial number of the printer
- [x] Printer version - Get the printer's version
- [x] Printer paper size - Get the paper size ( 0: 80mm 1: 58mm)
- [x] LCD Print a image  
- [x] LCD Print a string
- [x] Open de cash drawer 
- [x] Check if the cash drawer is open of close

# You can run the project cloning the repository below
[Repository](https://github.com/brasizza/sunmi_printer.git) - then change branch to **version-4.0**
![Logo](https://github.com/brasizza/sunmi_printer/blob/version-4.0/doc/screen.png?raw=true)



# **You can also combine this package with the package [esc_pos_utils](https://pub.dev/packages/esc_pos_utils)**

_With this package you  **can**  create a custom escpos and than you don't need to use any other command.
This is good if you already have a code that another printers use, and u can reuse this code as well_ 

```dart
// import packages
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';




```
## Example code when use SunmiPrinter

```dart
        await SunmiPrinter.printText('Simple raw text');
        await SunmiPrinter.printText('Bold text centered',
            style: SunmiTextStyle(
            bold: true,
            align: SunmiPrintAlign.CENTER,
            ));

        await SunmiPrinter.lineWrap(2); // Jump 2 lines
        await SunmiPrinter.printText('Very Large font!',
            style: SunmiTextStyle(
            fontSize: 80,
            ));
                          
        await SunmiPrinter.printText('Custom font size!!!',
            style: SunmiTextStyle(
            fontSize: 32,
            ));
                          
        await SunmiPrinter.printQRCode(
            'https://github.com/brasizza/sunmi_printer',
            style: SunmiQrcodeStyle(
            qrcodeSize: 3,
            errorLevel: SunmiQrcodeLevel.LEVEL_H,
            )); // PRINT A QRCODE

```

# Example code for LCD functions 

```dart
await SunmiLcd.configLCD(SunmiLCDStatus)
 await SunmiLcd.lcdString('Hello'); //Write a simple line 
 await SunmiLcd.lcdString('Hello' , 12 , true); //Write a simple line with 12 in size and fill screen

 Uint8List byte = await readFileBytes('assets/images/128x40.png');
 await SunmiLcd.lcdImage(byte); // Put an image in LCD

```
# Example to open the cashier 

```dart
  bool await SunmiDrawer.i.isDrawerOpen(); //check if the cash drawer is connect or disconnect

  await SunmiDrawer.i.openDrawer(); //open de cash drawer


 ```

### List of enum printer mode

```dart
enum PrinterMode {
  NORMAL_MODE,
  BLACK_LABEL_MODE, 
  LABEL_MODE
}
```

### List of enum Alignments
```dart
enum SunmiPrintAlign {
  LEFT,
  CENTER,
  RIGHT,
}
```

### List of enum Qrcode levels
```dart
enum SunmiQrcodeLevel {
  LEVEL_L,
  LEVEL_M,
  LEVEL_Q,
  LEVEL_H,
}
```

### List of enum Barcode types
```dart
enum SunmiBarcodeType {
  UPCA,
  UPCE,
  JAN13,
  JAN8,
  CODE39,
  ITF,
  CODABAR,
  CODE93,
  CODE128,
}
```


### List of enum Text position in barcode
```dart
enum SunmiBarcodeTextPos {
  NO_TEXT,
  TEXT_ABOVE,
  TEXT_UNDER,
  BOTH,
}
```


### List of enum Font sizes
```dart
enum SunmiFontSize {
  XS,
  SM,
  MD,
  LG,
  XL,
}
```

### List of enum SunmiLCDStatus
```dart
enum SunmiLCDStatus {
  INIT,
  WAKE,
  SLEEP,
  CLEAR,
}
```