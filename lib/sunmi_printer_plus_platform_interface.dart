import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'core/enums/enums.dart';
import 'sunmi_printer_plus_method_channel.dart';

/// Abstract platform interface for interacting with the Sunmi Printer Plus.
///
/// This class defines the methods for Sunmi Printer Plus functionality.
/// Concrete implementations should override these methods for their specific platforms (e.g., Android, iOS).
abstract class SunmiPrinterPlusPlatform extends PlatformInterface {
  /// Constructs a [SunmiPrinterPlusPlatform].
  SunmiPrinterPlusPlatform() : super(token: _token);

  static final Object _token = Object();

  static SunmiPrinterPlusPlatform _instance = MethodChannelSunmiPrinterPlus();

  /// The default instance of [SunmiPrinterPlusPlatform] to use.
  ///
  /// By default, this is set to [MethodChannelSunmiPrinterPlus], but can be overridden
  /// for platform-specific implementations.
  static SunmiPrinterPlusPlatform get instance => _instance;

  /// Set a custom platform instance.
  ///
  /// Platform-specific implementations should set this to their own instance
  /// that extends [SunmiPrinterPlusPlatform].
  static set instance(SunmiPrinterPlusPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Fetch the platform version.
  Future<String?> getPlatformVersion() {
    throw UnimplementedError('getPlatformVersion() has not been implemented.');
  }

  /// Fetch the printer's status.
  Future<String?> getStatus() {
    throw UnimplementedError('getStatus() has not been implemented.');
  }

  /// Fetch the printer's version.
  Future<String?> getVersion() {
    throw UnimplementedError('getVersion() has not been implemented.');
  }

  /// Fetch the paper status.
  Future<String?> getPaper() {
    throw UnimplementedError('getPaper() has not been implemented.');
  }

  /// Fetch the printer type.
  Future<String?> getType() {
    throw UnimplementedError('getType() has not been implemented.');
  }

  /// Fetch the printer's ID.
  Future<String?> getId() {
    throw UnimplementedError('getId() has not been implemented.');
  }

  /// Print text with custom settings.
  Future<String?> printText(Map printData) {
    throw UnimplementedError('printText() has not been implemented.');
  }

  /// Print a QR code with custom settings.
  Future<String?> printQrcode(Map printData) {
    throw UnimplementedError('printQrcode() has not been implemented.');
  }

  /// Print a barcode with custom settings.
  Future<String?> printBarcode(Map printData) {
    throw UnimplementedError('printBarcode() has not been implemented.');
  }

  /// Print a line with an optional type (e.g., dashed, solid).
  Future<String?> line(String? type) {
    throw UnimplementedError('line() has not been implemented.');
  }

  /// Add line breaks.
  Future<String?> lineWrap(int times) {
    throw UnimplementedError('lineWrap() has not been implemented.');
  }

  /// Cut the paper.
  Future<String?> cutPaper() {
    throw UnimplementedError('cutPaper() has not been implemented.');
  }

  /// Print an image with specified alignment.
  Future<String?> printImage(Uint8List image, SunmiPrintAlign align) {
    throw UnimplementedError('printImage() has not been implemented.');
  }

  /// Add custom text with styling.
  Future<String?> addText(Map<String, dynamic> printData) {
    throw UnimplementedError('addText() has not been implemented.');
  }

  /// Print ESC/POS commands.
  Future<String?> printEscPos(List<int> data) {
    throw UnimplementedError('printEscPos() has not been implemented.');
  }

  /// Print a TSPL (TSC printer language) command.
  Future<String?> printTSPL(String data) {
    throw UnimplementedError('printTSPL() has not been implemented.');
  }

  /// Print a row of text with specified columns, widths, and styles.
  Future<String?> printRow(
      {required List text, required List width, required List style}) {
    throw UnimplementedError('printRow() has not been implemented.');
  }

  /// Configure the LCD status.
  Future<String?> configLCD({required SunmiLCDStatus status}) {
    throw UnimplementedError('configLCD() has not been implemented.');
  }

  /// Send text to the LCD screen with specified size and fill option.
  Future<String?> sendTextLCD(
      {required String text, required int size, required bool fill}) {
    throw UnimplementedError('sendTextLCD() has not been implemented.');
  }

  /// Show a digital value on the LCD screen.
  Future<String?> showDigital(String digital) async {
    throw UnimplementedError('showDigital() has not been implemented.');
  }

  /// Send an image to the LCD screen.
  Future<String?> sendImageLCD({required Uint8List image}) {
    throw UnimplementedError('sendImageLCD() has not been implemented.');
  }

  /// Open the drawer.
  Future<String?> openDrawer() async {
    throw UnimplementedError('openDrawer() has not been implemented.');
  }

  /// Check if the drawer is open.
  Future<bool> isDrawerOpen() async {
    throw UnimplementedError('isDrawerOpen() has not been implemented.');
  }
}
