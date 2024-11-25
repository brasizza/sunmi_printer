import 'dart:typed_data';

import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus_platform_interface.dart';

/// A utility class for controlling the Sunmi printer's LCD screen.
///
/// Provides methods for configuring the LCD, displaying text, showing digital values,
/// and sending images to the LCD.
class SunmiLcd {
  // Private constructor to prevent instantiation.
  SunmiLcd._();

  /// Configures the LCD screen with a specific status.
  ///
  /// [status]: The desired LCD status, e.g., `SunmiLCDStatus.INIT`, `SunmiLCDStatus.CLEAR`.
  ///
  /// Returns a [String] message from the printer if successful, or `null` otherwise.
  static Future<String?> configLCD({required SunmiLCDStatus status}) async {
    return await SunmiPrinterPlusPlatform.instance.configLCD(status: status);
  }

  /// Sends a text string to the LCD screen.
  ///
  /// [text]: The text to display.
  /// [size]: The font size for the text.
  /// [fill]: Whether to fill the remaining space on the LCD with blank characters.
  ///
  /// Returns a [String] message from the printer if successful, or `null` otherwise.
  static Future<String?> lcdString(String text,
      {required int size, required bool fill}) async {
    return await SunmiPrinterPlusPlatform.instance
        .sendTextLCD(text: text, size: size, fill: fill);
  }

  /// Displays a digital number on the LCD screen.
  ///
  /// [digital]: The digital value to display as a string.
  ///
  /// Returns a [String] message from the printer if successful, or `null` otherwise.
  static Future<String?> showDigital(String digital) async {
    return await SunmiPrinterPlusPlatform.instance.showDigital(digital);
  }

  /// Sends an image to the LCD screen.
  ///
  /// [image]: The image data as a [Uint8List].
  ///
  /// Returns a [String] message from the printer if successful, or `null` otherwise.
  static Future<String?> sendImageLCD({required Uint8List image}) async {
    return await SunmiPrinterPlusPlatform.instance.sendImageLCD(image: image);
  }
}
