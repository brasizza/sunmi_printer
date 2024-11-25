import '../../sunmi_printer_plus_platform_interface.dart';

sealed class SunmiConfig {
  // Avoid self instance
  SunmiConfig._();

  static Future<String?> getStatus() async {
    return await SunmiPrinterPlusPlatform.instance.getStatus();
  }

  static Future<String?> getVersion() async {
    return await SunmiPrinterPlusPlatform.instance.getVersion();
  }

  static Future<String?> getPaper() async {
    return await SunmiPrinterPlusPlatform.instance.getPaper();
  }

  static Future<String?> getType() async {
    return await SunmiPrinterPlusPlatform.instance.getType();
  }

  static Future<String?> getId() async {
    return await SunmiPrinterPlusPlatform.instance.getId();
  }
}
