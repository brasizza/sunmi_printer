import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sunmi_printer_plus/core/enums/enums.dart';

import 'sunmi_printer_plus_platform_interface.dart';

/// An implementation of [SunmiPrinterPlusPlatform] that uses method channels.
class MethodChannelSunmiPrinterPlus extends SunmiPrinterPlusPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sunmi_printer_plus');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
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
  Future<String?> printText(Map printData) async {
    return await methodChannel
        .invokeMethod<String>('printText', {'data': printData});
  }

  @override
  Future<String?> printQrcode(Map printData) async {
    return await methodChannel
        .invokeMethod<String>('printQrcode', {'data': printData});
  }

  @override
  Future<String?> printBarcode(Map printData) async {
    return await methodChannel
        .invokeMethod<String>('printBarcode', {'data': printData});
  }

  @override
  Future<String?> line(String? type) async {
    return await methodChannel
        .invokeMethod<String>('printLine', {'data': type});
  }

  @override
  Future<String?> lineWrap(int times) async {
    return await methodChannel
        .invokeMethod<String>('lineWrap', {'times': times});
  }

  @override
  Future<String?> cutPaper() async {
    return await methodChannel.invokeMethod<String>('cutPaper');
  }

  @override
  Future<String?> printImage(Uint8List image, SunmiPrintAlign align) async {
    return await methodChannel.invokeMethod<String>(
        'printImage', {'image': image, "align": align.name});
  }

  @override
  Future<String?> addText(Map printData) async {
    return await methodChannel
        .invokeMethod<String>('addText', {'data': printData});
  }

  @override
  Future<String?> printEscPos(List<int> data) async {
    return await methodChannel
        .invokeMethod<String>('printEscPos', {'data': data});
  }

  @override
  Future<String?> printTSPL(String data) async {
    return await methodChannel
        .invokeMethod<String>('printTSPL', {'data': data});
  }

  @override
  Future<String?> printRow(
      {required List text, required List width, required List style}) async {
    return await methodChannel.invokeMethod<String>('printRow', {
      'data': {
        "text": text,
        "width": width,
        "style": style,
      }
    });
  }

  @override
  Future<String?> configLCD({required SunmiLCDStatus status}) async {
    return await methodChannel
        .invokeMethod<String>('configLCD', {'status': status.name});
  }

  @override
  Future<String?> sendTextLCD(
      {required String text, required int size, required bool fill}) async {
    return await methodChannel.invokeMethod<String>(
        'sendTextLCD', {'text': text, 'size': size, 'fill': fill});
  }

  @override
  Future<String?> showDigital(String digital) async {
    return await methodChannel
        .invokeMethod<String>('showDigital', {'digital': digital});
  }

  @override
  Future<String?> sendImageLCD({required Uint8List image}) async {
    return await methodChannel
        .invokeMethod<String>('sendImageLCD', {'image': image});
  }

  @override
  Future<String?> openDrawer() async {
    return await methodChannel.invokeMethod<String>('openDrawer');
  }

  @override
  Future<bool> isDrawerOpen() async {
    return await methodChannel.invokeMethod<bool>('isDrawerOpen') ?? false;
  }
}
