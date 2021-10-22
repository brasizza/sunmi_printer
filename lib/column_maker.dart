import 'package:sunmi_printer_plus/enums.dart';

class ColumnMaker {
  String text;
  int width;
  PrintAlign align;
  ColumnMaker({
    this.text = '',
    this.width = 2,
    this.align = PrintAlign.LEFT,
  }) {
    if (width < 1 || width > 12) {
      throw Exception('Column width must be between 1..12');
    }
  }

  Map<String, String> toJson() {
    int value = 0;
    switch (align) {
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
    return {
      "text": text,
      "width": width.toString(),
      "align": value.toString(),
    };
  }
}
