import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class CashDrawer {
  final SunmiPrinterPlus _printer;

  CashDrawer({required this._printer});

  Future<String?> openDrawer() async {
    return await _printer.openDrawer();
  }

  Future<bool> isDrawerOpen() async {
    return await _printer.isDrawerOpen();
  }
}
