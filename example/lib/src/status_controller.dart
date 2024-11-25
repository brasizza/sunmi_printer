import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class StatusController {
  final SunmiPrinterPlus _printer;

  StatusController({required SunmiPrinterPlus printer}) : _printer = printer;

  Future<PrinterStatus> getStatus() async {
    final status = await _printer.getStatus();
    try {
      return PrinterStatus.values.firstWhere(
        (e) => e.toString().split('.').last == status,
      );
    } catch (e) {
      return PrinterStatus
          .UNKNOWN; // Return null if the string doesn't match any enum value
    }
  }

  Future<String?> getVersion() async => await _printer.getVersion();

  Future<String?> getPaper() async => await _printer.getPaper();

  Future<String?> getId() async => await _printer.getId();

  Future<String?> getType() async => await _printer.getType();
}
