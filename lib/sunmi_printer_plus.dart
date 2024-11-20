import 'package:sunmi_printer_plus/core/styles/sunmi_qrcode_style.dart';
import 'package:sunmi_printer_plus/core/sunmi/sunmi_config.dart';

import 'core/styles/sunmi_text_style.dart';
import 'core/sunmi/sunmi_printer.dart';
import 'sunmi_printer_plus_platform_interface.dart';

class SunmiPrinterPlus {
  Future<String?> getPlatformVersion() async {
    return SunmiPrinterPlusPlatform.instance.getPlatformVersion();
  }

  Future<String?> getStatus() async {
    return await SunmiConfig.i.getStatus();
  }

  Future<String?> getVersion() async {
    return await SunmiConfig.i.getVersion();
  }

  Future<String?> getPaper() async {
    return await SunmiConfig.i.getPaper();
  }

  Future<String?> getType() async {
    return await SunmiConfig.i.getType();
  }

  Future<String?> getId() async {
    return await SunmiConfig.i.getId();
  }

  Future<String?> printText({required String text, SunmiTextStyle? style}) async {
    return await SunmiPrinter.i.printText(text: text, style: style);
  }

  Future<String?> printQrcode({required String text, SunmiQrcodeStyle? style}) async {
    return await SunmiPrinter.i.printQrcode(text: text, style: style);
  }
}
