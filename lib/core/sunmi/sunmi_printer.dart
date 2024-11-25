import 'dart:typed_data';

import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_barcode_style.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_qrcode_style.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_text_style.dart';
import 'package:sunmi_printer_plus/core/types/sunmi_column.dart';
import 'package:sunmi_printer_plus/core/types/sunmi_text.dart';

import '../../sunmi_printer_plus_platform_interface.dart';

sealed class SunmiPrinter {
  SunmiPrinter._();

  static Future<String?> printText(String text, {SunmiTextStyle? style}) async {
    final printData = {
      "text": text,
      if (style != null) ...style.toMap(),
    };

    return await SunmiPrinterPlusPlatform.instance.printText(printData);
  }

  static Future<String?> printCustomText({required SunmiText sunmiText}) async {
    final printData = {
      "text": sunmiText.text,
      if (sunmiText.style != null) ...sunmiText.style!.toMap(),
    };
    return await SunmiPrinterPlusPlatform.instance.printText(printData);
  }

  static Future<String?> printQRCode(String text, {SunmiQrcodeStyle? style}) async {
    final printData = {
      "text": text,
      if (style != null) ...style.toMap(),
    };

    return await SunmiPrinterPlusPlatform.instance.printQrcode(printData);
  }

  static Future<String?> printBarcode({required String text, SunmiBarcodeStyle? style}) async {
    final printData = {
      "text": text,
      if (style != null) ...style.toMap(),
    };
    return await SunmiPrinterPlusPlatform.instance.printBarcode(printData);
  }

  static Future<String?> line({String? type}) async {
    return await SunmiPrinterPlusPlatform.instance.line(type);
  }

  static Future<String?> lineWrap(int times) async {
    return await SunmiPrinterPlusPlatform.instance.lineWrap(times);
  }

  static Future<String?> cutPaper() async {
    return await SunmiPrinterPlusPlatform.instance.cutPaper();
  }

  static Future<String?> printImage({required Uint8List image, required SunmiPrintAlign align}) async {
    return await SunmiPrinterPlusPlatform.instance.printImage(image, align);
  }

  static Future<String?> addText({required String text, SunmiTextStyle? style}) async {
    final printData = {
      "text": text,
      if (style != null) ...style.toMap(),
    };

    return await SunmiPrinterPlusPlatform.instance.addText(printData);
  }

  static Future<String?> printEscPos({required List<int> data}) async {
    return await SunmiPrinterPlusPlatform.instance.printEscPos(data);
  }

  static Future<String?> printTSPL({required String data}) async {
    return await SunmiPrinterPlusPlatform.instance.printTSPL(data);
  }

  static Future<String?> printRow({required List<SunmiColumn> cols}) async {
    List<List<dynamic>> separateProperties(List<SunmiColumn> columns) {
      List<String> textList = [];
      List<int> widthList = [];
      List<Map?> styleList = [];

      for (var column in columns) {
        textList.add(column.text);
        widthList.add(column.width);
        styleList.add(column.style?.toMap()); // Handle null case for style
      }

      return [textList, widthList, styleList];
    }

    List<List<dynamic>> separatedProperties = separateProperties(cols);
    return await SunmiPrinterPlusPlatform.instance.printRow(text: separatedProperties[0], width: separatedProperties[1], style: separatedProperties[2]);
  }
}
