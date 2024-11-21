// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sunmi_printer_plus/core/enums/enums.dart';

class SunmiTextStyle {
  final int? fontSize;
  final SunmiPrintAlign? align;
  final bool? bold;
  final bool? underline;
  final bool? strikethrough;
  final bool? italic;
  final bool? reverse;

  SunmiTextStyle._internal({
    required this.fontSize,
    required this.align,
    required this.bold,
    required this.underline,
    required this.strikethrough,
    required this.italic,
    required this.reverse,
  });

  factory SunmiTextStyle({
    int fontSize = 24,
    SunmiPrintAlign align = SunmiPrintAlign.LEFT,
    bool bold = false,
    bool underline = false,
    bool strikethrough = false,
    bool italic = false,
    bool reverse = false,
  }) {
    if (fontSize < 1 || fontSize > 96) {
      throw ArgumentError(
        'Invalid fontSize: $fontSize. Must be between 1 and 96.',
      );
    }
    return SunmiTextStyle._internal(
      align: align,
      bold: bold,
      fontSize: fontSize,
      italic: italic,
      reverse: reverse,
      strikethrough: strikethrough,
      underline: underline,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fontSize': fontSize,
      'align': align?.name,
      'bold': bold,
      'underline': underline,
      'strikethrough': strikethrough,
      'italic': italic,
      'reverse': reverse,
    };
  }
}
