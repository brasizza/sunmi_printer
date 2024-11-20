import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelSunmiPrinterPlus platform = MethodChannelSunmiPrinterPlus();
  const MethodChannel channel = MethodChannel('sunmi_printer_plus');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
