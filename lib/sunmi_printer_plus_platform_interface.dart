import 'package:plugin_platform_interface/plugin_platform_interface.dart';

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
}
