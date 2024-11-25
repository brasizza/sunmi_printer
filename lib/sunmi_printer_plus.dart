import 'dart:typed_data';

import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_barcode_style.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_qrcode_style.dart';
import 'package:sunmi_printer_plus/core/sunmi/sunmi_config.dart';
import 'package:sunmi_printer_plus/core/sunmi/sunmi_lcd.dart';
import 'package:sunmi_printer_plus/core/types/sunmi_column.dart';

import 'core/styles/sunmi_text_style.dart';
import 'core/sunmi/sunmi_printer.dart';
import 'core/types/sunmi_text.dart';
import 'sunmi_printer_plus_platform_interface.dart';

export 'core/helpers/sunmi_helper.dart';
export 'core/types/sunmi_column.dart';
export 'core/types/sunmi_text.dart';

class SunmiPrinterPlus {
  Future<String?> getPlatformVersion() async {
    return SunmiPrinterPlusPlatform.instance.getPlatformVersion();
  }

  Future<String?> getStatus() async {
    return await SunmiConfig.getStatus();
  }

  Future<String?> getVersion() async {
    return await SunmiConfig.getVersion();
  }

  Future<String?> getPaper() async {
    return await SunmiConfig.getPaper();
  }

  Future<String?> getType() async {
    return await SunmiConfig.getType();
  }

  Future<String?> getId() async {
    return await SunmiConfig.getId();
  }

  Future<String?> printText({required String text, SunmiTextStyle? style}) async {
    return await SunmiPrinter.printText(text, style: style);
  }

  Future<String?> printCustomText({required SunmiText sunmiText}) async {
    return await SunmiPrinter.printCustomText(sunmiText: sunmiText);
  }

  Future<String?> printQrcode({required String text, SunmiQrcodeStyle? style}) async {
    return await SunmiPrinter.printQRCode(text, style: style);
  }

  Future<String?> printBarcode({required String text, SunmiBarcodeStyle? style}) async {
    return await SunmiPrinter.printBarcode(text: text, style: style);
  }

  Future<String?> line({String? type}) async {
    return await SunmiPrinter.line(type: type);
  }

  Future<String?> lineWrap({required int times}) async {
    return await SunmiPrinter.lineWrap(times);
  }

  Future<String?> cutPaper() async {
    return await SunmiPrinter.cutPaper();
  }

  Future<String?> printImage({required Uint8List image, required SunmiPrintAlign align}) async {
    return await SunmiPrinter.printImage(image: image, align: align);
  }

  Future<String?> addText({required List<SunmiText> sunmiTexts}) async {
    for (var i = 0; i < sunmiTexts.length; i++) {
      var sunmiText = sunmiTexts[i];
      if (i == sunmiTexts.length - 1) {
        sunmiText = sunmiText.copyWith(text: "${sunmiText.text}\n");
      }
      await SunmiPrinter.addText(text: sunmiText.text, style: sunmiText.style);
    }
    return "ok";
  }

  Future<String?> printEscPos({required List<int> data}) async {
    return await SunmiPrinter.printEscPos(data: data);
  }

  Future<String?> printTSPL({required String data}) async {
    return await SunmiPrinter.printTSPL(data: data);
  }

  Future<String?> printRow({required List<SunmiColumn> cols}) async {
    return await SunmiPrinter.printRow(cols: cols);
  }

  Future<String?> configLCD({required SunmiLCDStatus status}) async {
    return await SunmiLcd.configLCD(status: status);
  }

  Future<String?> sendTextLCD({required String text, required int size, required bool fill}) async {
    return await SunmiLcd.lcdString(text, size: size, fill: fill);
  }

  Future<String?> showDigital(String digital) async {
    return await SunmiLcd.showDigital(digital);
  }

  Future<String?> lcdImage({required Uint8List image}) async {
    return await SunmiLcd.sendImageLCD(image: image);
  }

  Future<String?> openDrawer() async {
    return await SunmiPrinterPlusPlatform.instance.openDrawer();
  }

  Future<bool> isDrawerOpen() async {
    return await SunmiPrinterPlusPlatform.instance.isDrawerOpen();
  }
}
