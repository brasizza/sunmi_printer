// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:sunmi_printer_plus/core/enums/enums.dart';

class SunmiTextStyle {
  int fontSize = 24;
  SunmiPrintAlign? align;
  bool bold = false;
  bool underline = false;
  bool strikethrough = false;
  bool italic = false;
  bool reverse = false;

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

  String toJson() => json.encode(toMap());
}
