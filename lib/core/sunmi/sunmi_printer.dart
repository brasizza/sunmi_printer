import 'dart:typed_data';

import 'package:sunmi_printer_plus/sunmi_printer_plus_platform_interface.dart';

import '../enums/enums.dart';
import '../styles/sunmi_barcode_style.dart';
import '../styles/sunmi_qrcode_style.dart';
import '../styles/sunmi_text_style.dart';
import '../types/sunmi_column.dart';
import '../types/sunmi_text.dart';

/// A utility class for interacting with the Sunmi printer.
///
/// Provides methods to print text, QR codes, barcodes, images, and more.
class SunmiPrinter {
  // Private constructor to prevent instantiation.
  SunmiPrinter._();

  /// Prints plain text with an optional [SunmiTextStyle].
  ///
  /// [text]: The text to print.
  /// [style]: The optional style for the text.
  ///
  /// Returns a [String] indicating the result of the print operation, or `null`.
  static Future<String?> printText(String text, {SunmiTextStyle? style}) async {
    final printData = {
      "text": text,
      if (style != null) ...style.toMap(),
    };

    return await SunmiPrinterPlusPlatform.instance.printText(printData);
  }

  /// Prints custom text using a [SunmiText] object.
  ///
  /// [sunmiText]: The text and style to print.
  ///
  /// Returns a [String] indicating the result of the print operation, or `null`.
  static Future<String?> printCustomText({required SunmiText sunmiText}) async {
    final printData = {
      "text": sunmiText.text,
      if (sunmiText.style != null) ...sunmiText.style!.toMap(),
    };
    return await SunmiPrinterPlusPlatform.instance.printText(printData);
  }

  /// Prints a QR code with optional [SunmiQrcodeStyle].
  ///
  /// [text]: The text for the QR code.
  /// [style]: The optional style for the QR code.
  ///
  /// Returns a [String] indicating the result of the print operation, or `null`.
  static Future<String?> printQRCode(String text,
      {SunmiQrcodeStyle? style}) async {
    final printData = {
      "text": text,
      if (style != null) ...style.toMap(),
    };

    return await SunmiPrinterPlusPlatform.instance.printQrcode(printData);
  }

  /// Prints a barcode with optional [SunmiBarcodeStyle].
  ///
  /// [text]: The text for the barcode.
  /// [style]: The optional style for the barcode.
  ///
  /// Returns a [String] indicating the result of the print operation, or `null`.
  static Future<String?> printBarcode(
      {required String text, SunmiBarcodeStyle? style}) async {
    final printData = {
      "text": text,
      if (style != null) ...style.toMap(),
    };
    return await SunmiPrinterPlusPlatform.instance.printBarcode(printData);
  }

  /// Prints a line using an optional line [type].
  ///
  /// [type]: The type of line to print (e.g., solid or dashed).
  ///
  /// Returns a [String] indicating the result of the print operation, or `null`.
  static Future<String?> line({String? type}) async {
    return await SunmiPrinterPlusPlatform.instance.line(type);
  }

  /// Adds a specified number of blank lines to the print output.
  ///
  /// [times]: The number of blank lines to add.
  ///
  /// Returns a [String] indicating the result of the operation, or `null`.
  static Future<String?> lineWrap(int times) async {
    return await SunmiPrinterPlusPlatform.instance.lineWrap(times);
  }

  /// Cuts the paper.
  ///
  /// Returns a [String] indicating the result of the operation, or `null`.
  static Future<String?> cutPaper() async {
    return await SunmiPrinterPlusPlatform.instance.cutPaper();
  }

  /// Prints an image with a specified alignment.
  ///
  /// [image]: The image data as [Uint8List].
  /// [align]: The alignment for the image (e.g., left, center, right).
  ///
  /// Returns a [String] indicating the result of the print operation, or `null`.
  static Future<String?> printImage(
      {required Uint8List image, required SunmiPrintAlign align}) async {
    return await SunmiPrinterPlusPlatform.instance.printImage(image, align);
  }

  /// Adds text to the print buffer with an optional [SunmiTextStyle].
  ///
  /// [text]: The text to add.
  /// [style]: The optional style for the text.
  ///
  /// Returns a [String] indicating the result of the operation, or `null`.
  static Future<String?> addText(
      {required String text, SunmiTextStyle? style}) async {
    final printData = {
      "text": text,
      if (style != null) ...style.toMap(),
    };

    return await SunmiPrinterPlusPlatform.instance.addText(printData);
  }

  /// Sends raw ESC/POS commands to the printer.
  ///
  /// [data]: The raw ESC/POS command data as a list of integers.
  ///
  /// Returns a [String] indicating the result of the operation, or `null`.
  static Future<String?> printEscPos({required List<int> data}) async {
    return await SunmiPrinterPlusPlatform.instance.printEscPos(data);
  }

  /// Sends raw TSPL commands to the printer.
  ///
  /// [data]: The raw TSPL command data as a string.
  ///
  /// Returns a [String] indicating the result of the operation, or `null`.
  static Future<String?> printTSPL({required String data}) async {
    return await SunmiPrinterPlusPlatform.instance.printTSPL(data);
  }

  /// Prints a row of columns with specified text, width, and styles.
  ///
  /// [cols]: A list of [SunmiColumn] objects representing the row content.
  ///
  /// Returns a [String] indicating the result of the operation, or `null`.
  static Future<String?> printRow({required List<SunmiColumn> cols}) async {
    List<List<dynamic>> separateProperties(List<SunmiColumn> columns) {
      List<String> textList = [];
      List<int> widthList = [];
      List<Map?> styleList = [];

      for (var column in columns) {
        textList.add(column.text);
        widthList.add(column.width);
        styleList.add(column.style?.toMap());
      }

      return [textList, widthList, styleList];
    }

    List<List<dynamic>> separatedProperties = separateProperties(cols);
    return await SunmiPrinterPlusPlatform.instance.printRow(
        text: separatedProperties[0],
        width: separatedProperties[1],
        style: separatedProperties[2]);
  }
}
