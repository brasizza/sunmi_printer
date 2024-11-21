import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_barcode_style.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_qrcode_style.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_text_style.dart';
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

  Future<String?> printText({required String text, SunmiTextStyle? style}) async {
    return await _printer.printText(text: text, style: style);
  }

  Future<String?> printQrcode({required String text, SunmiQrcodeStyle? style}) async {
    return await _printer.printQrcode(text: text, style: style);
  }

  Future<String?> printBarcode({required String text, SunmiBarcodeStyle? style}) async {
    return await _printer.printBarcode(text: text, style: style);
  }

  Future<String?> line({SunmiPrintLine? style}) async {
    return await _printer.line(style?.name);
  }
}
