import 'package:sunmi_printer_plus/sunmi_printer_plus_platform_interface.dart';

/// A utility class for retrieving configuration and status information from the Sunmi printer.
class SunmiConfig {
  // Private constructor to prevent instantiation.
  SunmiConfig._();

  /// Retrieves the current status of the Sunmi printer.
  ///
  /// Returns a [String] message indicating the printer's status, or `null` if unavailable.
  static Future<String?> getStatus() async {
    return await SunmiPrinterPlusPlatform.instance.getStatus();
  }

  /// Retrieves the firmware version of the Sunmi printer.
  ///
  /// Returns a [String] representing the firmware version, or `null` if unavailable.
  static Future<String?> getVersion() async {
    return await SunmiPrinterPlusPlatform.instance.getVersion();
  }

  /// Retrieves the paper size or type information from the Sunmi printer.
  ///
  /// Returns a [String] describing the paper configuration, or `null` if unavailable.
  static Future<String?> getPaper() async {
    return await SunmiPrinterPlusPlatform.instance.getPaper();
  }

  /// Retrieves the printer type or model information.
  ///
  /// Returns a [String] indicating the printer type, or `null` if unavailable.
  static Future<String?> getType() async {
    return await SunmiPrinterPlusPlatform.instance.getType();
  }

  /// Retrieves the unique identifier of the Sunmi printer.
  ///
  /// Returns a [String] containing the printer ID, or `null` if unavailable.
  static Future<String?> getId() async {
    return await SunmiPrinterPlusPlatform.instance.getId();
  }
}
