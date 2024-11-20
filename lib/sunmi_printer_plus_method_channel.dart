import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'sunmi_printer_plus_platform_interface.dart';

/// An implementation of [SunmiPrinterPlusPlatform] that uses method channels.
class MethodChannelSunmiPrinterPlus extends SunmiPrinterPlusPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sunmi_printer_plus');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> getStatus() async {
    return await methodChannel.invokeMethod<String>('getStatus');
  }

  @override
  Future<String?> getVersion() async {
    return await methodChannel.invokeMethod<String>('getVersion');
  }

  @override
  Future<String?> getPaper() async {
    return await methodChannel.invokeMethod<String>('getPaper');
  }

  @override
  Future<String?> getId() async {
    return await methodChannel.invokeMethod<String>('getId');
  }

  @override
  Future<String?> getType() async {
    return await methodChannel.invokeMethod<String>('getType');
  }

  @override
  Future<String?> printText(Map<String, dynamic> printData) async {
    return await methodChannel.invokeMethod<String>('printText', {'data': printData});
  }

  @override
  Future<String?> printQrcode(Map<String, dynamic> printData) async {
    return await methodChannel.invokeMethod<String>('printQrcode', {'data': printData});
  }
}
