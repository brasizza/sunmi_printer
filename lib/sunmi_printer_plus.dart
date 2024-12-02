import 'dart:typed_data';

import 'package:sunmi_printer_plus/sunmi_printer_plus_platform_interface.dart';

import 'core/enums/enums.dart';
import 'core/styles/sunmi_barcode_style.dart';
import 'core/styles/sunmi_qrcode_style.dart';
import 'core/styles/sunmi_text_style.dart';
import 'core/sunmi/sunmi_config.dart';
import 'core/sunmi/sunmi_lcd.dart';
import 'core/sunmi/sunmi_printer.dart';
import 'core/types/sunmi_column.dart';
import 'core/types/sunmi_text.dart';

/// A utility class for interacting with Sunmi printers and associated devices (e.g., LCD, drawer).
///
/// This class provides methods to manage printer operations, such as printing text, barcodes, QR codes, and images.
/// It also includes functionalities for interacting with the device's LCD and drawer.
class SunmiPrinterPlus {
  // Constructor

  /// Gets the platform version of the Sunmi Printer Plus device.
  ///
  /// Returns the platform version as a [String] or `null` if unsuccessful.
  Future<String?> getPlatformVersion() async {
    return await SunmiPrinterPlusPlatform.instance.getPlatformVersion();
  }

  /// Retrieves the current status of the printer.
  ///
  /// Returns the printer status as a [String] or `null` if unsuccessful.
  Future<String?> getStatus() async {
    return await SunmiConfig.getStatus();
  }

  /// Retrieves the printer version.
  ///
  /// Returns the version as a [String] or `null` if unsuccessful.
  Future<String?> getVersion() async {
    return await SunmiConfig.getVersion();
  }

  /// Retrieves the paper status (e.g., paper out, paper loaded).
  ///
  /// Returns the paper status as a [String] or `null` if unsuccessful.
  Future<String?> getPaper() async {
    return await SunmiConfig.getPaper();
  }

  /// Retrieves the printer type.
  ///
  /// Returns the printer type as a [String] or `null` if unsuccessful.
  Future<String?> getType() async {
    return await SunmiConfig.getType();
  }

  /// Retrieves the unique printer ID.
  ///
  /// Returns the printer ID as a [String] or `null` if unsuccessful.
  Future<String?> getId() async {
    return await SunmiConfig.getId();
  }

  /// Prints plain text with an optional [SunmiTextStyle].
  ///
  /// [text]: The text to print.
  /// [style]: Optional text style to apply.
  ///
  /// Returns a [String] indicating the result or `null` if unsuccessful.
  Future<String?> printText(
      {required String text, SunmiTextStyle? style}) async {
    return await SunmiPrinter.printText(text, style: style);
  }

  /// Prints custom text using a [SunmiText] object.
  ///
  /// [sunmiText]: The custom text object containing text and optional style.
  ///
  /// Returns a [String] indicating the result or `null` if unsuccessful.
  Future<String?> printCustomText({required SunmiText sunmiText}) async {
    return await SunmiPrinter.printCustomText(sunmiText: sunmiText);
  }

  /// Prints a QR code with optional [SunmiQrcodeStyle].
  ///
  /// [text]: The QR code content.
  /// [style]: Optional style for the QR code.
  ///
  /// Returns a [String] indicating the result or `null` if unsuccessful.
  Future<String?> printQrcode(
      {required String text, SunmiQrcodeStyle? style}) async {
    return await SunmiPrinter.printQRCode(text, style: style);
  }

  /// Prints a barcode with optional [SunmiBarcodeStyle].
  ///
  /// [text]: The barcode content.
  /// [style]: Optional style for the barcode.
  ///
  /// Returns a [String] indicating the result or `null` if unsuccessful.
  Future<String?> printBarcode(String text, {SunmiBarcodeStyle? style}) async {
    return await SunmiPrinter.printBarCode(text, style: style);
  }

  /// Prints a line with an optional [type] (e.g., solid or dashed).
  ///
  /// [type]: The type of line to print (optional).
  ///
  /// Returns a [String] indicating the result or `null` if unsuccessful.
  Future<String?> line({String? type}) async {
    return await SunmiPrinter.line(type: type);
  }

  /// Adds a specified number of blank lines to the print output.
  ///
  /// [times]: The number of blank lines to insert.
  ///
  /// Returns a [String] indicating the result or `null` if unsuccessful.
  Future<String?> lineWrap({required int times}) async {
    return await SunmiPrinter.lineWrap(times);
  }

  /// Cuts the paper after printing.
  ///
  /// Returns a [String] indicating the result or `null` if unsuccessful.
  Future<String?> cutPaper() async {
    return await SunmiPrinter.cutPaper();
  }

  /// Prints an image with a specified [align] (left, center, or right).
  ///
  /// [image]: The image data as a [Uint8List].
  /// [align]: The alignment of the image (e.g., left, center, right).
  ///
  /// Returns a [String] indicating the result or `null` if unsuccessful.
  Future<String?> printImage(Uint8List image,
      {required SunmiPrintAlign align}) async {
    return await SunmiPrinter.printImage(image, align: align);
  }

  /// Adds multiple [SunmiText] objects to the print buffer.
  ///
  /// [sunmiTexts]: A list of [SunmiText] objects to add.
  ///
  /// Returns a [String] ("ok") upon success, or `null` if unsuccessful.
  Future<String?> addText({required List<SunmiText> sunmiTexts}) async {
    for (var i = 0; i < sunmiTexts.length; i++) {
      var sunmiText = sunmiTexts[i];
      if (i == sunmiTexts.length - 1) {
        sunmiText = sunmiText.copyWith(text: "${sunmiText.text}\n");
      }
      await SunmiPrinter.addText(text: sunmiText.text, style: sunmiText.style);
    }
    return "ok";
  }

  /// Sends raw ESC/POS command data to the printer.
  ///
  /// [data]: The ESC/POS data as a list of integers.
  ///
  /// Returns a [String] indicating the result or `null` if unsuccessful.
  Future<String?> printEscPos(List<int> data) async {
    return await SunmiPrinter.printEscPos(data);
  }

  /// Sends raw TSPL command data to the printer.
  ///
  /// [data]: The TSPL data as a string.
  ///
  /// Returns a [String] indicating the result or `null` if unsuccessful.
  Future<String?> printTSPL({required String data}) async {
    return await SunmiPrinter.printTSPL(data: data);
  }

  /// Prints a row of columns with specified text, width, and styles.
  ///
  /// [cols]: A list of [SunmiColumn] objects to print.
  ///
  /// Returns a [String] indicating the result or `null` if unsuccessful.
  Future<String?> printRow({required List<SunmiColumn> cols}) async {
    return await SunmiPrinter.printRow(cols: cols);
  }

  /// Configures the LCD screen with a specified [status].
  ///
  /// [status]: The desired status for the LCD (e.g., INIT, WAKE).
  ///
  /// Returns a [String] indicating the result or `null` if unsuccessful.
  Future<String?> configLCD({required SunmiLCDStatus status}) async {
    return await SunmiLcd.configLCD(status: status);
  }

  /// Sends text to be displayed on the LCD screen.
  ///
  /// [text]: The text to display on the LCD.
  /// [size]: The size of the text.
  /// [fill]: Whether the text should fill the screen.
  ///
  /// Returns a [String] indicating the result or `null` if unsuccessful.
  Future<String?> sendTextLCD(
      {required String text, required int size, required bool fill}) async {
    return await SunmiLcd.lcdString(text, size: size, fill: fill);
  }

  /// Displays a digital value on the LCD screen.
  ///
  /// [digital]: The digital value to display (e.g., a number or time).
  ///
  /// Returns a [String] indicating the result or `null` if unsuccessful.
  Future<String?> showDigital(String digital) async {
    return await SunmiLcd.showDigital(digital);
  }

  /// Displays an image on the LCD screen.
  ///
  /// [image]: The image data as [Uint8List].
  ///
  /// Returns a [String] indicating the result or `null` if unsuccessful.
  Future<String?> lcdImage({required Uint8List image}) async {
    return await SunmiLcd.sendImageLCD(image: image);
  }

  /// Opens the drawer.
  ///
  /// Returns a [String] indicating the result or `null` if unsuccessful.
  Future<String?> openDrawer() async {
    return await SunmiPrinterPlusPlatform.instance.openDrawer();
  }

  /// Checks if the drawer is currently open.
  ///
  /// Returns `true` if the drawer is open, otherwise `false`.
  Future<bool> isDrawerOpen() async {
    return await SunmiPrinterPlusPlatform.instance.isDrawerOpen();
  }
}
