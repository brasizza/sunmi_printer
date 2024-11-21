// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sunmi_printer_plus/core/styles/sunmi_text_style.dart';

class SunmiColumn {
  final String text;
  final int width;
  final SunmiTextStyle? style;
  SunmiColumn({
    required this.text,
    required this.width,
    this.style,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'width': width,
      'style': style?.toMap(),
    };
  }
}
