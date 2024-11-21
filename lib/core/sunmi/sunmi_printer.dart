import 'package:sunmi_printer_plus/core/styles/sunmi_barcode_style.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_qrcode_style.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_text_style.dart';

import '../../sunmi_printer_plus_platform_interface.dart';

class SunmiPrinter {
  static SunmiPrinter? _instance;
  // Avoid self instance
  SunmiPrinter._();
  static SunmiPrinter get i => _instance ??= SunmiPrinter._();

  Future<String?> printText({required String text, SunmiTextStyle? style}) async {
    final printData = {
      "text": text,
      if (style != null) ...style.toMap(),
    };

    return await SunmiPrinterPlusPlatform.instance.printText(printData);
  }

  Future<String?> printQrcode({required String text, SunmiQrcodeStyle? style}) async {
    final printData = {
      "text": text,
      if (style != null) ...style.toMap(),
    };

    return await SunmiPrinterPlusPlatform.instance.printQrcode(printData);
  }

  Future<String?> printBarcode({required String text, SunmiBarcodeStyle? style}) async {
    final printData = {
      "text": text,
      if (style != null) ...style.toMap(),
    };
    return await SunmiPrinterPlusPlatform.instance.printBarcode(printData);
  }

  Future<String?> line({String? type}) async {
    return await SunmiPrinterPlusPlatform.instance.line(type);
  }
}
