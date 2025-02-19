// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class SunmiText {
  final String text;
  final SunmiTextStyle? style;

  SunmiText({
    required this.text,
    this.style,
  });

  SunmiText copyWith({
    String? text,
    SunmiTextStyle? style,
  }) {
    return SunmiText(
      text: text ?? this.text,
      style: style ?? this.style,
    );
  }
}
