import 'package:sunmi_printer_plus/sunmi_printer_plus_platform_interface.dart';

class SunmiDrawer {
  static SunmiDrawer? _instance;
  // Avoid self instance
  SunmiDrawer._();
  static SunmiDrawer get i => _instance ??= SunmiDrawer._();

  Future<String?> openDrawer() async {
    return await SunmiPrinterPlusPlatform.instance.openDrawer();
  }

  Future<bool> isDrawerOpen() async {
    return await SunmiPrinterPlusPlatform.instance.isDrawerOpen();
  }
}
