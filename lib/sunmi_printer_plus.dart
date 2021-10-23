import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/column_maker.dart';
export 'package:sunmi_printer_plus/column_maker.dart';
export 'package:sunmi_printer_plus/enums.dart';

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

  static const MethodChannel _channel = MethodChannel('sunmi_printer_plus');

  static Future<bool?> bindingPrinter() async {
    final bool? status = await _channel.invokeMethod('BIND_PRINTER_SERVICE');
    return status;
  }

  static Future<bool?> unbindingPrinter() async {
    final bool? status = await _channel.invokeMethod('UNBIND_PRINTER_SERVICE');
    return status;
  }

  static Future<bool?> initPrinter() async {
    final bool? status = await _channel.invokeMethod('INIT_PRINTER');
    return status;
  }

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

  static Future<String?> getPrinterStatusWithVerbose() async {
    final String? status = await _channel.invokeMethod('GET_UPDATE_PRINTER');
    final statusMsg = _printerStatus[status];
    return statusMsg;
  }

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

  static Future<void> printText(String text) async {
    Map<String, dynamic> arguments = <String, dynamic>{"text": '$text\n'};
    await _channel.invokeMethod("PRINT_TEXT", arguments);
  }

  static Future<void> printRow({required List<ColumnMaker> cols}) async {
    final _jsonCols = List<Map<String, String>>.from(
        cols.map<Map<String, String>>((ColumnMaker col) => col.toJson()));
    Map<String, dynamic> arguments = <String, dynamic>{
      "cols": json.encode(_jsonCols)
    };
    await _channel.invokeMethod("PRINT_ROW", arguments);
  }

  static Future<void> printRawData(Uint8List data) async {
    Map<String, dynamic> arguments = <String, dynamic>{"data": data};
    await _channel.invokeMethod("RAW_DATA", arguments);
  }

  static Future<void> printQRCode(String data,
      {int size = 5,
      SunmiQrcodeLevel errorLevel = SunmiQrcodeLevel.LEVEL_H}) async {
    int _errorlevel = 3;
    switch (errorLevel) {
      case SunmiQrcodeLevel.LEVEL_L:
        _errorlevel = 0;
        break;
      case SunmiQrcodeLevel.LEVEL_M:
        _errorlevel = 1;

        break;
      case SunmiQrcodeLevel.LEVEL_Q:
        _errorlevel = 2;
        break;
      case SunmiQrcodeLevel.LEVEL_H:
        _errorlevel = 3;
        break;
    }
    Map<String, dynamic> arguments = <String, dynamic>{
      "data": data,
      'modulesize': size,
      'errorlevel': _errorlevel
    };
    await _channel.invokeMethod("PRINT_QRCODE", arguments);
  }

  static Future<void> printBarCode(String data,
      {SunmiBarcodeType barcodeType = SunmiBarcodeType.CODE128,
      int height = 162,
      int width = 2,
      SunmiBarcodeTextPos textPosition =
          SunmiBarcodeTextPos.TEXT_ABOVE}) async {
    int _codeType = 8;
    int _textPosition = 8;
    switch (barcodeType) {
      case SunmiBarcodeType.UPCA:
        _codeType = 0;
        break;
      case SunmiBarcodeType.UPCE:
        _codeType = 1;
        break;
      case SunmiBarcodeType.JAN13:
        _codeType = 2;
        break;
      case SunmiBarcodeType.JAN8:
        _codeType = 3;
        break;
      case SunmiBarcodeType.CODE39:
        _codeType = 4;
        break;
      case SunmiBarcodeType.ITF:
        _codeType = 5;
        break;
      case SunmiBarcodeType.CODABAR:
        _codeType = 6;
        break;
      case SunmiBarcodeType.CODE93:
        _codeType = 7;
        break;
      case SunmiBarcodeType.CODE128:
        _codeType = 8;
        break;
    }

    switch (textPosition) {
      case SunmiBarcodeTextPos.NO_TEXT:
        _textPosition = 0;
        break;
      case SunmiBarcodeTextPos.TEXT_ABOVE:
        _textPosition = 1;
        break;
      case SunmiBarcodeTextPos.TEXT_UNDER:
        _textPosition = 2;
        break;
      case SunmiBarcodeTextPos.BOTH:
        _textPosition = 3;
        break;
    }
    Map<String, dynamic> arguments = <String, dynamic>{
      "data": data,
      'barcodeType': _codeType,
      'textPosition': _textPosition,
      'width': width,
      'height': height
    };
    await _channel.invokeMethod("PRINT_BARCODE", arguments);
  }

  static Future<void> lineWrap(int lines) async {
    Map<String, dynamic> arguments = <String, dynamic>{"lines": lines};
    await _channel.invokeMethod("LINE_WRAP", arguments);
  }

  static Future<void> line({
    String ch = '-',
    int len = 31,
  }) async {
    resetFontSize();
    await printText(List.filled(len, ch[0]).join());
  }

  static Future<void> bold() async {
    final List<int> boldOn = [27, 69, 1];

    await printRawData(Uint8List.fromList(boldOn));
  }

  static Future<void> resetBold() async {
    final List<int> boldOff = [27, 69, 0];

    await printRawData(Uint8List.fromList(boldOff));
  }

  static Future<void> setAlignment(SunmiPrintAlign alignment) async {
    late int value;
    switch (alignment) {
      case SunmiPrintAlign.LEFT:
        value = 0;
        break;
      case SunmiPrintAlign.CENTER:
        value = 1;
        break;
      case SunmiPrintAlign.RIGHT:
        value = 2;
        break;
      default:
        value = 0;
    }
    Map<String, dynamic> arguments = <String, dynamic>{"alignment": value};
    await _channel.invokeMethod("SET_ALIGNMENT", arguments);
  }

  static Future<void> printImage(Uint8List img) async {
    Map<String, dynamic> arguments = <String, dynamic>{};
    arguments.putIfAbsent("bitmap", () => img);
    await _channel.invokeMethod("PRINT_IMAGE", arguments);
  }

  static Future<void> startTransactionPrint([bool clear = false]) async {
    Map<String, dynamic> arguments = <String, dynamic>{"clearEnter": clear};
    await _channel.invokeMethod("ENTER_PRINTER_BUFFER", arguments);
  }

  static Future<void> submitTransactionPrint() async {
    await _channel.invokeMethod("COMMIT_PRINTER_BUFFER");
  }

  static Future<void> exitTransactionPrint([bool clear = true]) async {
    Map<String, dynamic> arguments = <String, dynamic>{"clearExit": clear};
    await _channel.invokeMethod("EXIT_PRINTER_BUFFER", arguments);
  }

  static Future<void> setFontSize(SunmiFontSize _size) async {
    int _fontSize = 24;
    switch (_size) {
      case SunmiFontSize.XS:
        _fontSize = 14;
        break;
      case SunmiFontSize.SM:
        _fontSize = 18;
        break;
      case SunmiFontSize.MD:
        _fontSize = 24;
        break;
      case SunmiFontSize.LG:
        _fontSize = 36;
        break;
      case SunmiFontSize.XL:
        _fontSize = 42;
        break;
    }
    Map<String, dynamic> arguments = <String, dynamic>{"size": _fontSize};

    await _channel.invokeMethod("FONT_SIZE", arguments);
  }

  static Future<void> resetFontSize() async {
    Map<String, dynamic> arguments = <String, dynamic>{"size": 24};
    await _channel.invokeMethod("FONT_SIZE", arguments);
  }

  static Future<void> startLabelPrint() async {
    await _channel.invokeMethod("LABEL_LOCATE");
  }

  static Future<void> exitLabelPrint() async {
    await _channel.invokeMethod("LABEL_OUTPUT");
  }
}
