# sunmi_printer

Support Sunmi V2 Pro Label Version and Null Safety.
I build this flutter plugin based on this
[Official Sunmi Inner Printer Doc](https://file.cdn.sunmi.com/SUNMIDOCS/%E5%95%86%E7%B1%B3%E5%86%85%E7%BD%AE%E6%89%93%E5%8D%B0%E6%9C%BA%E5%BC%80%E5%8F%91%E8%80%85%E6%96%87%E6%A1%A3EN-0224.pdf). But not all method from doc is included in this plugins. I am only select few of important method which is important for my personal usecase only.

## Installation  

```bash
flutter pub add sunmi_printer
```

## Tested Devices

```bash
Sunmi V2 Pro 
Sunmi V2 Pro (Label Version)
```

## Getting Started

```dart
// import packages
import 'package:sunmi_printer/sunmi_printer.dart';


// all method from sunmi printer need to async await
await SunmiPrinter.bindingPrinter(); // must bind the printer first. for more exmaple.. pls refer to example tab.

```

## Common use function list

| Method      | Function Type ( Future )      |  Description | Support Devices     |
| :---        | :---  |  :---   | :---          |
| bindingPrinter()   | void   | Binding sunmi inner printer services, only init once     | Sunmi v2 pro, Sunmi v2 Pro ( label version )   |
| unbindingPrinter() | void    | You can unbind the printer base on your use case.        | Sunmi v2 pro, Sunmi v2 Pro ( label version )   |
| initPrinter() | bool    | Printer initialization. NOTE: reset the logic programs (type setting, bold, etc.) of a printer but not to clear the data in the buffer. Therefore, uncompleted print jobs will be continued after resetting. if no error when init, will return `true` value       | Sunmi v2 pro, Sunmi v2 Pro ( label version )   |
| getPrinterStatus() | enum PrinterStatus  | Return enum status, exp: PrinterStatus.NORMAL, PrinterStatus.ERROR etc....   [Refer to this list of status](#list-of-enum-printer-status)     | Sunmi v2 pro, Sunmi v2 Pro ( label version )   |
| getPrinterStatusWithVerbose() | String  | Return additional details or plain text explain. exp: 'Something went wrong.' (ERROR), 'Works normally' (NORMAL) etc.. [Refer to this list of status](#list-of-printer-verbose-status)  | Sunmi v2 pro, Sunmi v2 Pro ( label version )   |
| getPrinterMode() | enum PrinterMode   | get the printer mode. Notes: if want to print label please change the printer mode to label mode but label mode only supported for V2 Pro label version [Refer to this list of mode](#list-of-enum-printer-mode)  | Sunmi v2 pro, Sunmi v2 Pro ( label version )   |
| lineWrap(int lines) | void  | Implement n LFs on the paper. Note: line feed by force. Implement n LFs on the paper after the content has been printed. | Sunmi v2 pro, Sunmi v2 Pro ( label version )   |
| printText(String text) | void   | The text to be printed. Base on documentation from sunmi.. we need to add `\n` at last text but I already append `\n` in end of string so you no need manually add `\n`     | Sunmi v2 pro, Sunmi v2 Pro ( label version )   |
| setAlignment(PrintAlign alignment)   |  void  | alignment for your next line method. available alignment: `PrintAlign.LEFT`, `PrintAlign.CENTER` and `PrintAlign.RIGHT`        | Sunmi v2 pro, Sunmi v2 Pro ( label version )   |
| printImage(Uint8List img )   | void   | Convert image to Uint8List format to pass into arg. Note: the resolution of an image should be within 2M, and the width should be set in accordance with the paper spec (58: 384 Pixel, 80: 576 Pixel). It cannot be shown if it exceeds the paper width.    | Sunmi v2 pro, Sunmi v2 Pro ( label version )   |

## Transaction function list

### Notes on transaction printing

>When printing the queue of transactions, the printing results will be fed back after printing. However, all print jobs submitted this time will loss if errors including out of paper, overheated occured, and an error feedback will be provided. Which means, if the printer error occurred before or during a print job, the job won’t be printed

| Method      | Function Type ( Future )      |  Description | Support Devices     |
| :---        | :---  |  :---   | :---      |
| startTransactionPrint([bool clear = false])   | void   | Enter into the transaction mode. if pass parameter `true` into function, it will print all content in transaction queue. If pass parameter `false` into function, it will not to print the content in transaction queue, and the content will be saved and submitted next time. Default value is false. For more detail, pls refer to sunmi doc  | Sunmi v2 pro, Sunmi v2 Pro ( label version )   |
| submitTransactionPrint()   | void   | Submit transaction printing  | Sunmi v2 pro, Sunmi v2 Pro ( label version )   |
| exitTransactionPrint([bool clear = true])   | void   | Exit the transaction printing mode. if pass parameter `true` into function, it will print all content in the buffer. If pass parameter `false` into function, it will not to print the content in the queue of transacion and save it to submit next time. Default value is true. For more detail, pls refer to sunmi doc  | Sunmi v2 pro, Sunmi v2 Pro ( label version )   |

### Example code when use for transaction printing

```dart
// Enter into the transaction mode
await SunmiPrinter.startTransactionPrint();
// Set whatever alignment u like
await SunmiPrinter.setAlignment(PrintAlign.CENTER); 
await SunmiPrinter.printImage(img); // Note: img variable must convert to Uint8List format first
await SunmiPrinter.printText('hello sunmi');
await SunmiPrinter.lineWrap(2);
await SunmiPrinter.printText('test');
await SunmiPrinter.setAlignment(PrintAlign.RIGHT);
await SunmiPrinter.printText('printer');
await SunmiPrinter.lineWrap(1);
await SunmiPrinter.setAlignment(PrintAlign.LEFT); 
await SunmiPrinter.printText('end');
// you can add other print-relevant methods here.. 
// lastly add submit print here
await SunmiPrinter.submitTransactionPrint(); // submit and start print, you can keep submit while in loop 
// remember to exit the transaction mode after finish printing.
await SunmiPrinter.exitTransactionPrint(); 
```

## Label printing function list

### Notes on label printing

>Precondition: Set mode – to use label printing function, please open setting->inbuilt printing- >printing mode selection and choose label thermal mode. Your selection will be recorded by the device and turned the device into a label printer when printing. Please refer to sunmi doc

:warning: Attention: this only support label version of V2 Pro or other sunmi mobile devices that support label printing

>If it is the first time for you to use it or you have changed a different type of label paper, please open setting -> inbuilt printing -> label learning and click the button learn label paper. Please refer to sunmi doc

| Method      | Function Type ( Future )      |  Description | Support Devices     |
| :---        | :---  |  :---   | :--- |
| startLabelPrint()  | void   | Start label printing  | Sunmi v2 Pro ( label version )   |
| exitLabelPrint()  | void   | Exit label printing. if you are printing more than one label at same time.. just only run this function at last item/index of list in loop. [Refer to this example](#example-code-when-use-for-label-printing-more-than-one)   | Sunmi v2 Pro ( label version )   |

### Example code when use for label printing

```dart
// Enter into the label mode
await SunmiPrinter.startLabelPrint();
// Set whatever alignment u like
await SunmiPrinter.setAlignment(PrintAlign.CENTER); 
await SunmiPrinter.printImage(img); // Note: img variable must convert 
// remember to exit the label mode after finish printing.
await SunmiPrinter.exitLabelPrint(); 
```

### Example code when use for label printing more than one

```dart
// get the last index
int lastIndex = imgURLList.length - 1;

await Future.forEach(imgURLList, (String url) async {
    // Enter into the label mode
    await SunmiPrinter.startLabelPrint();

    // Start your label content
    int index = imgURLList.indexOf(url);
    // example images from internet
    String url = 'https://pngimg.com/uploads/nike/small/nike_PNG18.png';
      // convert image to Uint8List format
    Uint8List byte = (await NetworkAssetBundle(Uri.parse(url)).load(url)).buffer.asUint8List();

    await SunmiPrinter.printImage(bytes);
    // END your label content

    // check if last item
    if (index == lastIndex) {
      // you only run this function when is last item to print
      await SunmiPrinter.exitLabelPrint();
    }
});
```

### List of enum printer status

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

## Future Plan

> Currently, I am still busy on other project.. so it will not be roll out below features very soon. Hope you all understand. Thanks.

add `getPrinterPaper()` method  
add `getPrinterSerialNo()` method  
add `setFontSize()` method  
add `printBarCode()` method  
add `printQRCode()` method  
