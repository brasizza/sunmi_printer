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
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }
}
