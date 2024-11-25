import 'package:sunmi_printer_plus/sunmi_printer_plus_platform_interface.dart';

/// A utility class for controlling the Sunmi printer drawer.
class SunmiDrawer {
  // Private constructor to prevent instantiation.
  SunmiDrawer._();

  /// Opens the drawer connected to the Sunmi printer.
  ///
  /// Returns a [String] message from the printer if successful, or `null` otherwise.
  static Future<String?> openDrawer() async {
    return await SunmiPrinterPlusPlatform.instance.openDrawer();
  }

  /// Checks if the Sunmi printer drawer is open.
  ///
  /// Returns `true` if the drawer is open, or `false` otherwise.
  static Future<bool> isDrawerOpen() async {
    return await SunmiPrinterPlusPlatform.instance.isDrawerOpen();
  }
}
