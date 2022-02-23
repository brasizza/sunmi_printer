import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';

import 'column_maker.dart';
import 'enums.dart';
import 'sunmi_style.dart';

///*SunmiPrinter*
///
///This class is a core of our printer system.
///With this class you can print everything you like. If you want to print a text, qrcode, barcode, bold text, bigger text or the smallest text possible.
///Your imagination is the limit!
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

  ///A list to make human read the paper size
  static final List<int> _paperize = [80, 58];

  ///*sunmi_printer_plus
  ///
  //A callable method to start the comunitation with the native code!
  static const MethodChannel _channel = MethodChannel('sunmi_printer_plus');

  ///*bindingPrinter*
  ///
  ///This method will intializate the printer to start the whole print.
  ///This method *Must* be executed before any other print and LCD command.
  static Future<bool?> bindingPrinter() async {
    final bool? status = await _channel.invokeMethod('BIND_PRINTER_SERVICE');
    return status;
  }

  ///*unbindingPrinter*
  ///
  ///This method is the opposite of [bindingPrinter].
  ///This will unbind or 'close' the connection with the printer, and must be the last execution.

  static Future<bool?> unbindingPrinter() async {
    final bool? status = await _channel.invokeMethod('UNBIND_PRINTER_SERVICE');
    return status;
  }

  ///*initPrinter*
  ///
  ///This method will reset the printer styles, font and everything that can change your text, but the method will *NOT* erase the buffer inside.
  static Future<bool?> initPrinter() async {
    final bool? status = await _channel.invokeMethod('INIT_PRINTER');
    return status;
  }

  ///*getPrinterStatus*
  ///
  ///This method will give you the status of the printer.
  ///Sometimes the printer can give you an error, so, try to print anyway.
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

  ///*getPrinterStatusWithVerbose*
  ///
  ///Almos the same of  [getPrinterStatus] , but will return a text explaned
  ///@see the _printerStatus map!
  static Future<String?> getPrinterStatusWithVerbose() async {
    final String? status = await _channel.invokeMethod('GET_UPDATE_PRINTER');
    final statusMsg = _printerStatus[status];
    return statusMsg;
  }

  ///*getPrinterMode*
  ///
  ///This method will return what mode your printer to print in one way or other, like label mode or normal mode
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

  ///*printText*
  ///
  ///This method will print a simple text in your printer
  /// With the [SunmiStyle] you can put in one line, the size, alignment and bold
  static Future<void> printText(String text, {SunmiStyle? style}) async {
    if (style != null) {
      if (style.align != null) {
        await setAlignment(style.align!);
      }

      if (style.fontSize != null) {
        await setFontSize(style.fontSize!);
      }

      if (style.bold != null) {
        if (style.bold == true) {
          await bold();
        }
      }
    }
    Map<String, dynamic> arguments = <String, dynamic>{"text": '$text\n'};
    await _channel.invokeMethod("PRINT_TEXT", arguments);
    await initPrinter();
  }

  ///*printRow*
  ///
  ///This method will print a row based in a list of [ColumnMaker].
  static Future<void> printRow({required List<ColumnMaker> cols}) async {
    final _jsonCols = List<Map<String, String>>.from(
        cols.map<Map<String, String>>((ColumnMaker col) => col.toJson()));
    Map<String, dynamic> arguments = <String, dynamic>{
      "cols": json.encode(_jsonCols)
    };
    await _channel.invokeMethod("PRINT_ROW", arguments);
  }

  ///*printRawData*
  ///
  ///With this method you can print a raw data, or a data that was made with some esc/pos package to simplify your calls
  ///*This is good if you have another print method that give you a [List<int>] that you can convert to esc/pos here
  static Future<void> printRawData(Uint8List data) async {
    Map<String, dynamic> arguments = <String, dynamic>{"data": data};
    await _channel.invokeMethod("RAW_DATA", arguments);
  }

  ///*printQRCode*
  ///
  ///With this method you can print a qrcode with some errorLevel and size.
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

  ///*printBarCode*
  ///
  ///With this method you can print a barcode with any type discribed below or in the enum section
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

  ///*lineWrap*
  ///
  ///With this method you can jump N lines in your pinter to make some spaces between sections
  static Future<void> lineWrap(int lines) async {
    Map<String, dynamic> arguments = <String, dynamic>{"lines": lines};
    await _channel.invokeMethod("LINE_WRAP", arguments);
  }

  ///*line*
  ///
  ///With this method you can draw a line to divide sections.
  static Future<void> line({
    String ch = '-',
    int len = 31,
  }) async {
    resetFontSize();
    await printText(List.filled(len, ch[0]).join());
  }

  ///*bold*
  ///
  ///With this method you can bold a string very easy, just put this method before a [printText] and everyting after this mehod will be bold

  static Future<void> bold() async {
    final List<int> boldOn = [27, 69, 1];

    await printRawData(Uint8List.fromList(boldOn));
  }

  ///*resetBold*
  ///
  ///This method will just reset the bold to a normal font weight
  static Future<void> resetBold() async {
    final List<int> boldOff = [27, 69, 0];

    await printRawData(Uint8List.fromList(boldOff));
  }

  ///*setAlignment*
  ///
  ///With this method you can align your text in three ways, like LEFT, RIGHT and CENTER.

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

  ///*printImage*
  ///
  ///With this method you can print an image in your printer.
  ///Just follow the examples that you can print even an image from web or an asset inside your project
  static Future<void> printImage(Uint8List img) async {
    Map<String, dynamic> arguments = <String, dynamic>{};
    arguments.putIfAbsent("bitmap", () => img);
    await _channel.invokeMethod("PRINT_IMAGE", arguments);
  }

  ///*startTransactionPrint*
  ///
  ///If you want to print in one transaction, you can start the transaction, build your print commands without send to the buffer
  static Future<void> startTransactionPrint([bool clear = false]) async {
    Map<String, dynamic> arguments = <String, dynamic>{"clearEnter": clear};
    await _channel.invokeMethod("ENTER_PRINTER_BUFFER", arguments);
  }

  ///*submitTransactionPrint*
  ///
  ///This method will submit your transaction to the bufffer
  static Future<void> submitTransactionPrint() async {
    await _channel.invokeMethod("COMMIT_PRINTER_BUFFER");
  }

  ///*cut*
  ///
  ///This method will  cut the paper
  static Future<void> cut() async {
    await _channel.invokeMethod("CUT_PAPER");
  }

  ///*exitTransactionPrint*
  ///
  ///This method will close the transaction

  static Future<void> exitTransactionPrint([bool clear = true]) async {
    Map<String, dynamic> arguments = <String, dynamic>{"clearExit": clear};
    await _channel.invokeMethod("EXIT_PRINTER_BUFFER", arguments);
  }

  ///*setFontSize*
  ///
  ///This method will change the fontsize , between extra small and extra large.
  ///You can see the sizes below or in the enum file.

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

  ///*setCustomFontSize*
  ///
  ///This method will allow you to put any font size integer and try the best fit for you
  static Future<void> setCustomFontSize(int _size) async {
    Map<String, dynamic> arguments = <String, dynamic>{"size": _size};
    await _channel.invokeMethod("FONT_SIZE", arguments);
  }

  ///*resetFontSize*
  ///
  ///This method will reset the font size to the medium (default) size
  static Future<void> resetFontSize() async {
    Map<String, dynamic> arguments = <String, dynamic>{"size": 24};
    await _channel.invokeMethod("FONT_SIZE", arguments);
  }

  ///*paperSize*
  ///
  /// Get the paper size , because they can change the printers between 56 and 80mm
  static Future<int> paperSize() async {
    int? _size = await _channel.invokeMethod("PAPER_SIZE");
    return _paperize[_size ?? 0];
  }

  ///*serialNumber*
  ///
  /// Get the serial number
  static Future<String> serialNumber() async {
    return await _channel.invokeMethod("PRINTER_SERIAL_NUMBER");
  }

  ///*printerVersion*
  ///
  /// Get the printer's version
  static Future<String> printerVersion() async {
    return await _channel.invokeMethod("PRINTER_VERSION");
  }

  /// LCD Methods

  /// Initialize LCD
  static Future<void> lcdInitialize() async {
    return await _channel.invokeMethod("LCD_COMMAND", {"flag": 1});
  }

  /// Wakeup LCD
  static Future<void> lcdWakeup() async {
    return await _channel.invokeMethod("LCD_COMMAND", {"flag": 2});
  }

  /// Sleep LCD
  static Future<void> lcdSleep() async {
    return await _channel.invokeMethod("LCD_COMMAND", {"flag": 3});
  }

  /// clear LCD
  static Future<void> lcdClear() async {
    return await _channel.invokeMethod("LCD_COMMAND", {"flag": 4});
  }

  /// Display string on LCD
  static Future<void> lcdString(String text) async {
    return await _channel.invokeMethod("LCD_STRING", {"string": text});
  }

  /// Display Bitmap on LCD
  /// Image size is 128 x 40 pixels.
  static Future<void> lcdImage(Uint8List img) async {
    return await _channel.invokeMethod("LCD_BITMAP", {"bitmap": img});
  }

  /// Display 2 lines string on LCD
  static Future<void> lcdDoubleString(String topText, String bottomText) async {
    return await _channel.invokeMethod(
        "LCD_DOUBLE_STRING", {"topText": topText, "bottomText": bottomText});
  }

  /// Send a single-line text in a customized size.
  /// If fill = true, The size parameter be used to set the width of characters.
  /// e.g. size:16, fill:false ... Half size char ( Like lcdDoubleString() )
  ///      size:32, fill:false ... Full size char ( Like lcdString() )
  ///      size:64, fill:true ... Width 64 pixel huge character.
  static Future<void> lcdFillString(String text,
      {int size = 32, bool fill = false}) async {
    return await _channel.invokeMethod(
        "LCD_FILL_STRING", {"string": text, "size": size, "fill": fill});
  }

  /// Display variable height multiline string.
  /// aligns: The weight of the solid content of each line. Like flex.
  static Future<void> lcdMultiString(
      List<String> texts, List<int> aligns) async {
    return await _channel
        .invokeMethod("LCD_MULTI_STRING", {"text": texts, "align": aligns});
  }
}
