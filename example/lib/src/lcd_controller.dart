import 'dart:typed_data';

import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class LcdController {
  final SunmiPrinterPlus _printer;

  LcdController({required SunmiPrinterPlus printer}) : _printer = printer;

  Future<String?> config({required SunmiLCDStatus status}) async {
    return await _printer.configLCD(status: status);
  }

  Future<String?> sendTextLCD(String text,
      {int size = 32, bool fill = false}) async {
    return await _printer.sendTextLCD(text: text, size: size, fill: fill);
  }

  Future<String?> showDigital(String digital) async {
    return await _printer.showDigital(digital);
  }

  Future<String?> lcdImage({required Uint8List image}) async {
    return await _printer.lcdImage(image: image);
  }
}
