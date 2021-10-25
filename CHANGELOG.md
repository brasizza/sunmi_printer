# Changelog

## 2.0.8
* Removed Label Printing Support , because the aidl don't give the support anymore (updated the IWoyouService)
* Update the printText method, now you can set the style, bold and size in the method.
* [x] cutPaper - Dedicated method just to cut the line
* [x] getPrinterSerialNo - Get the serial number of the printer
* [x] getPrinterVersion - Get the printer's version
* [x] getPrinterPaper - Get the paper size ( 0: 80mm 1: 58mm)
## 2.0.7
* Code format

## 2.0.6
* Fix enum.dart to format issues

## 2.0.5
* Fix enum.dart to format issues

## 2.0.4
* Fix some code to increase Pub points

## 2.0.3
* Fixed Barcode Example

## 2.0.2
* Fixed pubspec.yaml

## 2.0.1
* Fixed Readme

## 2.0.0

* 2.0.0 release
* Update Readme
* Enable Null Safety Support
* Label Printing Support For Sunmi V2 Pro
* Refine existing features
* Minor bug fixed
* Included Qrcode print
* Included Column print
* Included Barcode print
* Included method to print with escpos
* Included bold mode On/Off
* Included font size change:
    - Extra small
    - Small
    - Medium (default)
    - Large
    - Extra Large
