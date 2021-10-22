# sunmi_printer_plus

# This is a fork from [sunmi_printer](https://pub.dev/packages/sunmi_printer) , but i implemented a lot of other features described below



Support Sunmi V2 Pro Label Version and Null Safety.
I build this flutter plugin based on this:
[Official Sunmi Inner Printer Doc](https://file.cdn.sunmi.com/SUNMIDOCS/%E5%95%86%E7%B1%B3%E5%86%85%E7%BD%AE%E6%89%93%E5%8D%B0%E6%9C%BA%E5%BC%80%E5%8F%91%E8%80%85%E6%96%87%E6%A1%A3EN-0224.pdf). But not all method from doc is included in this plugins. I am only select few of important method which is important for my personal usecase only.

## Installation  

```bash
flutter pub add sunmi_printer_plus
```

## What this package do
- [x] Write some text
- [x] Change font size
- [x] Jump (n) lines
- [x] Draw a divisor line
- [x] Bold mode on/off
- [x] Print all types of Barcodes (see enum below)
- [x] Print Qrcodes with custom width and error-level
- [x] Print image from asset or from web (example show how to print both)
- [x] Print rows like recepit with custom width and alignment
- [x] Able to combine with some esc/pos code that you already have!

## Tested Devices

```bash
Sunmi V2 Pro 
Sunmi V2 Pro (Label Version)
```


# **You can also combine this package with the package [esc_pos_utils](https://pub.dev/packages/esc_pos_utils)**

_With this package you  **can**  create a custom escpos and than you don't need to use any other command.
This is good if you already have a code that another printers use, and u can reuse this code as well_ 

#Just see the example folder!


# Getting Started

```dart
// import packages
import 'package:sunmi_printer/sunmi_printer_plus.dart';


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

  await SunmiPrinter.printQRCode('https://github.com/brasizza/sunmi_printer'); // PRINT A QRCODE
  await SunmiPrinter.submitTransactionPrint(); // SUBMIT and cut paper
  await SunmiPrinter.exitTransactionPrint(true); // Close the transaction

```

## Example code when use for label printing

```dart
// Enter into the label mode
await SunmiPrinter.startLabelPrint();
// Set whatever alignment u like
await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER); 
await SunmiPrinter.printText("Label mode for some printers"); 
// remember to exit the label mode after finish printing.
await SunmiPrinter.exitLabelPrint(); 
```


## List of enum printer status

```dart
enum PrinterStatus {
  ERROR,
  NORMAL, 
  ABNORMAL_COMMUNICATION, 
  OUT_OF_PAPER, 
  PREPARING,
  OVERHEATED,
  OPEN_THE_LID, 
  PAPER_CUTTER_ABNORMAL,
  PAPER_CUTTER_RECOVERED,
  NO_BLACK_MARK,
  NO_PRINTER_DETECTED,
  FAILED_TO_UPGRADE_FIRMWARE,
  EXCEPTION
}
```

### List of printer verbose status

```dart
{
    'ERROR': 'Something went wrong.', 
    'NORMAL': 'Works normally', 
    'ABNORMAL_COMMUNICATION': 'Abnormal communication',
    'OUT_OF_PAPER': 'Out of paper',
    'PREPARING': 'Preparing printer',
    'OVERHEATED': 'Overheated',
    'OPEN_THE_LID': 'Open the lid',
    'PAPER_CUTTER_ABNORMAL': 'The paper cutter is abnormal',
    'PAPER_CUTTER_RECOVERED': 'The paper cutter has been recovered',
    'NO_BLACK_MARK': 'No black mark had been detected',
    'NO_PRINTER_DETECTED': 'No printer had been detected',
    'FAILED_TO_UPGRADE_FIRMWARE': 'Failed to upgrade firmware',
    'EXCEPTION': 'Unknown Error code',
}
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
enum SunmiPrintAlign { LEFT, CENTER, RIGHT }
```

### List of enum Qrcode levels
```dart
enum SunmiQrcodeLevel { LEVEL_L, LEVEL_M, LEVEL_Q, LEVEL_H }
```

### List of enum Barcode types
```dart
enum SunmiBarcodeType { UPCA, UPCE, JAN13, JAN8, CODE39, ITF, CODABAR, CODE93, CODE128 }
```


### List of enum Text position in barcode
```dart
enum SunmiBarcodeTextPos { NO_TEXT, TEXT_ABOVE, TEXT_UNDER, BOTH }
```


### List of enum Font sizes
```dart
enum SunmiFontSize { XS, SM, MD, LG, XL }
```


