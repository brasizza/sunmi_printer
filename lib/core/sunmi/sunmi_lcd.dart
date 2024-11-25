import 'dart:typed_data';

import 'package:sunmi_printer_plus/core/enums/enums.dart';

import '../../sunmi_printer_plus_platform_interface.dart';

sealed class SunmiLcd {
  // Avoid self instance
  SunmiLcd._();

  static Future<String?> configLCD({required SunmiLCDStatus status}) async {
    return await SunmiPrinterPlusPlatform.instance.configLCD(status: status);
  }

  static Future<String?> lcdString(String text,
      {required int size, required bool fill}) async {
    return await SunmiPrinterPlusPlatform.instance
        .sendTextLCD(text: text, size: size, fill: fill);
  }

  static Future<String?> showDigital(String digital) async {
    return await SunmiPrinterPlusPlatform.instance.showDigital(digital);
  }

  static Future<String?> sendImageLCD({required Uint8List image}) async {
    return await SunmiPrinterPlusPlatform.instance.sendImageLCD(image: image);
  }
}
