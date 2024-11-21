import 'package:flutter_test/flutter_test.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus_platform_interface.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSunmiPrinterPlusPlatform
    with MockPlatformInterfaceMixin
    implements SunmiPrinterPlusPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SunmiPrinterPlusPlatform initialPlatform =
      SunmiPrinterPlusPlatform.instance;

  test('$MethodChannelSunmiPrinterPlus is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSunmiPrinterPlus>());
  });

  test('getPlatformVersion', () async {
    SunmiPrinterPlus sunmiPrinterPlusPlugin = SunmiPrinterPlus();
    MockSunmiPrinterPlusPlatform fakePlatform = MockSunmiPrinterPlusPlatform();
    SunmiPrinterPlusPlatform.instance = fakePlatform;

    expect(await sunmiPrinterPlusPlugin.getPlatformVersion(), '42');
  });
}
