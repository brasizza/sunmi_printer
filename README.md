# sunmi_printer_plus

# This is a fork from [sunmi_printer](https://pub.dev/packages/sunmi_printer) , but i implemented a lot of other features described below

## Important: 
  **THIS PACKAGE WILL WORK ONLY IN ANDROID!**

Support Sunmi and Null Safety.
I build this flutter plugin based on this:
[Official Sunmi Inner Printer Doc](https://file.cdn.sunmi.com/SUNMIDOCS/%E5%95%86%E7%B1%B3%E5%86%85%E7%BD%AE%E6%89%93%E5%8D%B0%E6%9C%BA%E5%BC%80%E5%8F%91%E8%80%85%E6%96%87%E6%A1%A3EN-0224.pdf). But not all method from doc was included in this package, beacuse i don't have equipment. If you have and can help me, just contact me on github!

## Installation  

```bash
flutter pub add sunmi_printer_plus
```

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
- [x] LCD Print a image  [ytyng](https://github.com/ytyng)
- [x] LCD Print a string , multi lines as double lines Thanks to [ytyng](https://github.com/ytyng)
- [x] Open de cash drawer Thanks to [ZheruiL](https://github.com/ZheruiL)
- [x] Check if the cash drawer is connected or not 
- [x] Get how many times the cash drawer was oppened


## Tested Devices

```bash
Sunmi V2 Pro 
Sunmi T2 mini
Sunmi V2S
```


# **You can also combine this package with the package [esc_pos_utils](https://pub.dev/packages/esc_pos_utils)**

_With this package you  **can**  create a custom escpos and than you don't need to use any other command.
This is good if you already have a code that another printers use, and u can reuse this code as well_ 

#Just see the example folder!


```dart
// import packages
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';


// all method from sunmi printer need to async await
await SunmiPrinter.bindingPrinter(); // must bind the printer first. for more exmaple.. pls refer to example tab.

```
## Example code when use for transaction printing

```dart
  await SunmiPrinter.startTransactionPrint(true);

  await SunmiPrinter.setAlignment(SunmiPrintAlign.RIGHT); // Right align
  await SunmiPrinter.printText('Align right');

  await SunmiPrinter.setAlignment(SunmiPrintAlign.LEFT);// Left align
  await SunmiPrinter.printText('Align left');

  await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);// Center align
  await SunmiPrinter.printText('Align center');

  await SunmiPrinter.lineWrap(2); // Jump 2 lines

  await SunmiPrinter.setFontSize(SunmiFontSize.XL); // Set font to very large
  await SunmiPrinter.printText('Very Large font!');
  await SunmiPrinter.resetFontSize(); // Reset font to medium size

  await SunmiPrinter.setCustomFontSize(12); // SET CUSTOM FONT 12
  await SunmiPrinter.printText('Custom font size!!!');
  await SunmiPrinter.resetFontSize(); // Reset font to medium size

  await SunmiPrinter.printQRCode('https://github.com/brasizza/sunmi_printer'); // PRINT A QRCODE
  await SunmiPrinter.submitTransactionPrint(); // SUBMIT and cut paper
  await SunmiPrinter.exitTransactionPrint(true); // Close the transaction

```

# Example code for LCD functions  [@ytyng](https://github.com/ytyng)

```dart
 await SunmiPrinter.lcdInitialize(); //Initialize the LCD 
 await SunmiPrinter.lcdWakeup(); //Turn the LCD ON
 await SunmiPrinter.lcdSleep(); //Turn the LCD OFF
 await SunmiPrinter.lcdClear(); //Clear LCD screen
 await SunmiPrinter.lcdString('Hello'); //Write a simple line 
 await SunmiPrinter.lcdString('Hello'); //Write a simple line 
 await SunmiPrinter.lcdDoubleString('Hello', 'World'); //Write two lines

 Uint8List byte = await readFileBytes('assets/images/128x40.png');
 await SunmiPrinter.lcdImage(byte); // Put an image in LCD
 await SunmiPrinter.lcdFillString('abcDEFgj0123\$&=+', size: 16, fill: true); // Print a string and fill with zeros until the size is reached
 await SunmiPrinter.lcdMultiString([  'Welcome to flutter.',  'Align 2.',], [  1,  2,]); // Write multiple lines with alignent

```
# Example to open the cashier  [@ZheruiL](https://github.com/ZheruiL)

```dart
  bool await SunmiPrinter.drawerStatus(); //check if the cash drawer is connect or disconnect

  await SunmiPrinter.openDrawer(); //open de cash drawer

  int await SunmiPrinter.drawerTimesOpen(); //How many times de cash drawer was oppened

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


