import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';

enum PrinterStatus {
  // ignore: constant_identifier_names
  UNKNOWN,
  // ignore: constant_identifier_names
  ERROR,
  // ignore: constant_identifier_names
  NORMAL,
  // ignore: constant_identifier_names
  ABNORMAL_COMMUNICATION,
  // ignore: constant_identifier_names
  OUT_OF_PAPER,
  // ignore: constant_identifier_names
  PREPARING,
  // ignore: constant_identifier_names
  OVERHEATED,
  // ignore: constant_identifier_names
  OPEN_THE_LID,
  // ignore: constant_identifier_names
  PAPER_CUTTER_ABNORMAL,
  // ignore: constant_identifier_names
  PAPER_CUTTER_RECOVERED,
  // ignore: constant_identifier_names
  NO_BLACK_MARK,
  // ignore: constant_identifier_names
  NO_PRINTER_DETECTED,
  // ignore: constant_identifier_names
  FAILED_TO_UPGRADE_FIRMWARE,
  // ignore: constant_identifier_names
  EXCEPTION
}

enum PrinterMode {
  // ignore: constant_identifier_names
  UNKNOWN,
  // ignore: constant_identifier_names
  NORMAL_MODE,
  // ignore: constant_identifier_names
  BLACK_LABEL_MODE,
  // ignore: constant_identifier_names
  LABEL_MODE
}

enum PrintAlign {
  // ignore: constant_identifier_names
  LEFT,
  // ignore: constant_identifier_names
  CENTER,
  // ignore: constant_identifier_names
  RIGHT,
}

class SunmiPrinter {
  static final Map _printerStatus = {
    'ERROR': 'Something went wrong.',
    'NORMAL': 'Works normally',
    'ABNORMAL_COMMUNICATION': 'Abnormal communication',
    'OUT_OF_PAPER': 'Out of paper',
    'PREPARING': 'Preparing printer',
    'OVERHEATED': 'Overheated',
    'OPEN_THE_LID': 'Open the lid',
    'PAPER_CUTTER_ABNORMAL': 'The paper cutter is abnormal',
    'PAPER_CUTTER_RECOVERED': 'The paper cutter has been recovered',
    'NO_BLACK_MARK': 'No black mark had been detected',
    'NO_PRINTER_DETECTED': 'No printer had been detected',
    'FAILED_TO_UPGRADE_FIRMWARE': 'Failed to upgrade firmware',
    'EXCEPTION': 'Unknown Error code',
  };

  static const MethodChannel _channel = MethodChannel('sunmi_printer');

  /// bind sunmi inner printer
  static Future<bool?> bindingPrinter() async {
    final bool? status = await _channel.invokeMethod('BIND_PRINTER_SERVICE');
    return status;
  }

  /// unbind sunmi inner printer
  static Future<bool?> unbindingPrinter() async {
    final bool? status = await _channel.invokeMethod('UNBIND_PRINTER_SERVICE');
    return status;
  }

  /// Printer initialization
  ///
  /// NOTE: reset the logic programs (type setting, bold, etc.) of a printer but not to clear the data in the buffer.
  ///
  /// Therefore, uncompleted print jobs will be continued after resetting.
  static Future<bool?> initPrinter() async {
    final bool? status = await _channel.invokeMethod('INIT_PRINTER');
    return status;
  }

  /// return enum status , if you want verbose status can use [getPrinterStatusWithVerbose()] .
  static Future<PrinterStatus> getPrinterStatus() async {
    final String? status = await _channel.invokeMethod('GET_UPDATE_PRINTER');
    switch (status) {
      case 'ERROR':
        return PrinterStatus.ERROR;
      case 'NORMAL':
        return PrinterStatus.NORMAL;
      case 'ABNORMAL_COMMUNICATION':
        return PrinterStatus.ABNORMAL_COMMUNICATION;
      case 'OUT_OF_PAPER':
        return PrinterStatus.OUT_OF_PAPER;
      case 'PREPARING':
        return PrinterStatus.PREPARING;
      case 'OVERHEATED':
        return PrinterStatus.OVERHEATED;
      case 'OPEN_THE_LID':
        return PrinterStatus.OPEN_THE_LID;
      case 'PAPER_CUTTER_ABNORMAL':
        return PrinterStatus.PAPER_CUTTER_ABNORMAL;
      case 'PAPER_CUTTER_RECOVERED':
        return PrinterStatus.PAPER_CUTTER_RECOVERED;
      case 'NO_BLACK_MARK':
        return PrinterStatus.NO_BLACK_MARK;
      case 'NO_PRINTER_DETECTED':
        return PrinterStatus.NO_PRINTER_DETECTED;
      case 'FAILED_TO_UPGRADE_FIRMWARE':
        return PrinterStatus.FAILED_TO_UPGRADE_FIRMWARE;
      case 'EXCEPTION':
        return PrinterStatus.EXCEPTION;
      default:
        return PrinterStatus.UNKNOWN;
    }
  }

  /// verbose explain of printer status
  static Future<String?> getPrinterStatusWithVerbose() async {
    final String? status = await _channel.invokeMethod('GET_UPDATE_PRINTER');
    final statusMsg = _printerStatus[status];
    return statusMsg;
  }

  /// mode = [  NORMAL_MODE , BLACK_LABEL_MODE, LABEL_MODE ]
  /// if want to print label please change the printer mode to label mode.
  static Future<PrinterMode> getPrinterMode() async {
    final String mode = await _channel.invokeMethod('GET_PRINTER_MODE');
    switch (mode) {
      case 'NORMAL_MODE':
        return PrinterMode.NORMAL_MODE;
      case 'BLACK_LABEL_MODE':
        return PrinterMode.BLACK_LABEL_MODE;
      case 'LABEL_MODE':
        return PrinterMode.LABEL_MODE;
      default:
        return PrinterMode.UNKNOWN;
    }
  }

  /// Print Text
  static Future<void> printText(String text) async {
    Map<String, dynamic> arguments = <String, dynamic>{"text": '$text\n'};
    await _channel.invokeMethod("PRINT_TEXT", arguments);
  }

  /// Print Text
  static Future<void> printRawData(List<int> data) async {
    Map<String, dynamic> arguments = <String, dynamic>{"data": data};
    await _channel.invokeMethod("RAW_DATA", arguments);
  }

  /// space how many next line
  static Future<void> lineWrap(int lines) async {
    Map<String, dynamic> arguments = <String, dynamic>{"lines": lines};
    await _channel.invokeMethod("LINE_WRAP", arguments);
  }

  /// alignment for your next line method ( images / text ).
  static Future<void> setAlignment(PrintAlign alignment) async {
    late int value;
    switch (alignment) {
      case PrintAlign.LEFT:
        value = 0;
        break;
      case PrintAlign.CENTER:
        value = 1;
        break;
      case PrintAlign.RIGHT:
        value = 2;
        break;
      default:
        value = 0;
    }
    Map<String, dynamic> arguments = <String, dynamic>{"alignment": value};
    await _channel.invokeMethod("SET_ALIGNMENT", arguments);
  }

  /// uint8List format image
  ///
  /// Note: the resolution of an image should be within 2M, and the width should be set in accordance with the paper spec (58: 384 Pixel, 80: 576 Pixel). It cannot be shown if it exceeds the paper width.
  static Future<void> printImage(Uint8List img) async {
    Map<String, dynamic> arguments = <String, dynamic>{};
    arguments.putIfAbsent("bitmap", () => img);
    await _channel.invokeMethod("PRINT_IMAGE", arguments);
  }

  /// Enter into the transaction printing mode
  static Future<void> startTransactionPrint([bool clear = false]) async {
    Map<String, dynamic> arguments = <String, dynamic>{"clearEnter": clear};
    await _channel.invokeMethod("ENTER_PRINTER_BUFFER", arguments);
  }

  /// Submit transaction printing
  static Future<void> submitTransactionPrint() async {
    await _channel.invokeMethod("COMMIT_PRINTER_BUFFER");
  }

  /// Exit the transaction printing mode
  static Future<void> exitTransactionPrint([bool clear = true]) async {
    Map<String, dynamic> arguments = <String, dynamic>{"clearExit": clear};
    await _channel.invokeMethod("EXIT_PRINTER_BUFFER", arguments);
  }

  /// Enter into the label printing mode
  static Future<void> startLabelPrint() async {
    await _channel.invokeMethod("LABEL_LOCATE");
  }

  /// Exit into the label printing mode
  static Future<void> exitLabelPrint() async {
    await _channel.invokeMethod("LABEL_OUTPUT");
  }
}
