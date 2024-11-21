import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:sunmi_printer_plus/core/enums/enums.dart';

import 'sunmi_printer_plus_method_channel.dart';

abstract class SunmiPrinterPlusPlatform extends PlatformInterface {
  /// Constructs a SunmiPrinterPlusPlatform.
  SunmiPrinterPlusPlatform() : super(token: _token);

  static final Object _token = Object();

  static SunmiPrinterPlusPlatform _instance = MethodChannelSunmiPrinterPlus();

  /// The default instance of [SunmiPrinterPlusPlatform] to use.
  ///
  /// Defaults to [MethodChannelSunmiPrinterPlus].
  static SunmiPrinterPlusPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SunmiPrinterPlusPlatform] when
  /// they register themselves.
  static set instance(SunmiPrinterPlusPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> getStatus() {
    throw UnimplementedError('getStatus() has not been implemented.');
  }

  Future<String?> getVersion() {
    throw UnimplementedError('getVersion() has not been implemented.');
  }

  Future<String?> getPaper() {
    throw UnimplementedError('getPaper() has not been implemented.');
  }

  Future<String?> getType() {
    throw UnimplementedError('getType() has not been implemented.');
  }

  Future<String?> getId() {
    throw UnimplementedError('getId() has not been implemented.');
  }

  Future<String?> printText(Map printData) {
    throw UnimplementedError('printText() has not been implemented.');
  }

  Future<String?> printQrcode(Map printData) {
    throw UnimplementedError('printQrcode() has not been implemented.');
  }

  Future<String?> printBarcode(Map printData) {
    throw UnimplementedError('printBarcode() has not been implemented.');
  }

  Future<String?> line(String? type) {
    throw UnimplementedError('line() has not been implemented.');
  }

  Future<String?> lineWrap(int times) {
    throw UnimplementedError('lineWrap() has not been implemented.');
  }

  Future<String?> cutPaper() {
    throw UnimplementedError('cutPaper() has not been implemented.');
  }

  Future<String?> printImage(Uint8List image, SunmiPrintAlign align) {
    throw UnimplementedError('cutPaper() has not been implemented.');
  }

  Future<String?> addText(Map<String, dynamic> printData) {
    throw UnimplementedError('addText() has not been implemented.');
  }

  Future<String?> printEscPos(List<int> data) {
    throw UnimplementedError('printEscPos() has not been implemented.');
  }

  Future<String?> printTSPL(String data) {
    throw UnimplementedError('printTSPL() has not been implemented.');
  }

  Future<String?> printRow({required List text, required List width, required List style}) {
    throw UnimplementedError('printRow() has not been implemented.');
  }
}
