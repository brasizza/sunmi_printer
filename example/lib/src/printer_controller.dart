import 'dart:typed_data';

import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_barcode_style.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_qrcode_style.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class PrinterController {
  final SunmiPrinterPlus _printer;

  PrinterController({required SunmiPrinterPlus printer}) : _printer = printer;

  Future<PrinterStatus> getStatus() async {
    final status = await _printer.getStatus();
    try {
      return PrinterStatus.values.firstWhere(
        (e) => e.toString().split('.').last == status,
      );
    } catch (e) {
      return PrinterStatus.UNKNOWN; // Return null if the string doesn't match any enum value
    }
  }

  Future<String?> getVersion() async => await _printer.getVersion();

  Future<String?> getPaper() async => await _printer.getPaper();

  Future<String?> getId() async => await _printer.getId();

  Future<String?> getType() async => await _printer.getType();

  Future<String?> printText({required SunmiText sunmiText}) async {
    return await _printer.printText(text: sunmiText.text, style: sunmiText.style);
  }

  Future<String?> addText({required List<SunmiText> sunmiTexts}) async {
    for (var i = 0; i < sunmiTexts.length; i++) {
      var sunmiText = sunmiTexts[i];
      if (i == sunmiTexts.length - 1) {
        sunmiText = sunmiText.copyWith(text: "${sunmiText.text}\n");
      }
      await _printer.addText(text: sunmiText.text, style: sunmiText.style);
    }
    return 'ok';
  }

  Future<String?> printQrcode({required String text, SunmiQrcodeStyle? style}) async {
    return await _printer.printQrcode(text: text, style: style);
  }

  Future<String?> printBarcode({required String text, SunmiBarcodeStyle? style}) async {
    return await _printer.printBarcode(text: text, style: style);
  }

  Future<String?> line({SunmiPrintLine? style}) async {
    return await _printer.line(type: style?.name);
  }

  Future<String?> lineWrap({required int times}) async {
    return await _printer.lineWrap(times: times);
  }

  Future<String?> cutPaper() async {
    return await _printer.cutPaper();
  }

  Future<String?> printImage({required Uint8List image, SunmiPrintAlign align = SunmiPrintAlign.LEFT}) async {
    return await _printer.printImage(image: image, align: align);
  }

  Future<List<int>> customEscPos() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];

    bytes += generator.reset();
    bytes += generator.text('Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ', styles: const PosStyles(codeTable: 'CP1252'));
    bytes += generator.text('Special 2: blåbærgrød', styles: const PosStyles(codeTable: 'CP1252'));

    bytes += generator.text('Bold text', styles: const PosStyles(bold: true));
    bytes += generator.text('Reverse text', styles: const PosStyles(reverse: true));
    bytes += generator.text('Underlined text', styles: const PosStyles(underline: true), linesAfter: 1);
    bytes += generator.text('Align left', styles: const PosStyles(align: PosAlign.left));
    bytes += generator.text('Align center', styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text('Align right', styles: const PosStyles(align: PosAlign.right), linesAfter: 1);
    bytes += generator.qrcode('Barcode by escpos', size: QRSize.Size4, cor: QRCorrection.H);
    bytes += generator.feed(2);

    bytes += generator.row([
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col6',
        width: 6,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
    ]);

    bytes += generator.text('Text size 200%',
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    bytes += generator.reset();
    bytes += generator.cut();

    return bytes;
  }

  Future<String?> printEscPos({required List<int> data}) async {
    return await _printer.printEscPos(data: data);
  }

  Future<String?> printTSPL({required String data}) async {
    return await _printer.printTSPL(data: data);
  }

  Future<String?> printRow({required List<SunmiColumn> cols}) async {
    return await _printer.printRow(cols: cols);
  }
}