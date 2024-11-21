import '../../sunmi_printer_plus_platform_interface.dart';

class SunmiConfig {
  static SunmiConfig? _instance;
  // Avoid self instance
  SunmiConfig._();
  static SunmiConfig get i => _instance ??= SunmiConfig._();

  Future<String?> getStatus() async {
    return await SunmiPrinterPlusPlatform.instance.getStatus();
  }

  Future<String?> getVersion() async {
    return await SunmiPrinterPlusPlatform.instance.getVersion();
  }

  Future<String?> getPaper() async {
    return await SunmiPrinterPlusPlatform.instance.getPaper();
  }

  Future<String?> getType() async {
    return await SunmiPrinterPlusPlatform.instance.getType();
  }

  Future<String?> getId() async {
    return await SunmiPrinterPlusPlatform.instance.getId();
  }
}
