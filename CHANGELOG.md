
# Changelog
## 4.1.0#
Improve doc, remove IOS needs and make a few changes in code trying to maintain compatible as possible with 3.0.0

## 4.0.2#
Improve doc and remove the required alignment in image(Default LEFT)
## 4.0.1#
Just improve pub points with documentation.
## 4.0.0#
# A WHOLE NEW package (minor break change)
## One important breakchange is the column in printRow.
I was needed to improve this method to get the benefits of the implementation.
- The older version (from aidl) , sometimes that was not possible to print arabic or chinese text, now it is!
- The other improvment: now in printRow you can send a whole sunmiStyle to do a new cusomization as you need!

# Now i am using the dependencie from gradle and abandon the aidlservice.

Doing that, i have a lot of control with the printer methods and the whole device!
I took me 3 weeks to make this code good to be release, so before you upgrade to 4.0.0 consider to test all your project before GO LIVE


## 3.0.1#
-Make compatible with dart >=3.5.0
## 3.0.0#
-Upgrade to latest flutter version.


## 2.1.03#
-Upgrade gradle to compileSdkVersion 34 in android core!
Tks to [Shelmo](https://github.com/Shelmo)


## 2.1.02#
* Print label returns!


## 2.1.01#
* Add the querie 
 <queries>
      <package android:name="woyou.aidlservice.jiuiv5" />
    </queries>
to work with V2s devices
Thanks to [@FrenkyDema](https://github.com/FrenkyDema)


## 2.1.00#
* Create some cash drawer methods to use when it's connected in the USB
* Upgrade de flutter version to 1.15.1
* Upgrade the kotlin and gradle to major versions


## 2.0.13#
* Replace the method to print row to native sunmi (but will cannot print arabic at this moment)
* build a custom size font method called setCustomFontSize and you can put any integer to fit an not use the pre defined like XL, SM and etc!

## 2.0.12#
* LCD functions fot T2mini
**Thanks to make this AWESOME PR [@ytyng](https://github.com/ytyng)**

## 2.0.11#
* Fixed exceptions with a device that is not sunmi.
* This is good if you have a hybrid app with just a condition to start or not sunmi printer.
**Thanks to open the issue [@aoeminh](https://github.com/aoeminh)**


# 2.0.10
* Print the arabic text in ColumnMaker wasn't working. Now it's fixed and the example will print chinese, russian and arabic.<br>
**Thanks AGAIN!!! to open the issue [@akshaykalola28](https://github.com/akshaykalola28)**

## 2.0.9
* This package still ( and i think will never) woks in IOS, but now you can generate your apps in IOS without exceptions.<br>
**Thanks to open the issue [@akshaykalola28](https://github.com/akshaykalola28)**

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
