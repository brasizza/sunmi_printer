// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../enums/enums.dart';

class SunmiBarcodeStyle {
  final int size;
  final int height;
  final SunmiBarcodeTextPos textPos;
  final SunmiBarcodeType type;
  final SunmiPrintAlign align;

  SunmiBarcodeStyle._internal(
      {required this.size,
      required this.align,
      required this.height,
      required this.textPos,
      required this.type});

  factory SunmiBarcodeStyle(
      {int size = 4,
      int height = 162,
      SunmiBarcodeTextPos textPos = SunmiBarcodeTextPos.NO_TEXT,
      SunmiBarcodeType type = SunmiBarcodeType.CODE128,
      SunmiPrintAlign align = SunmiPrintAlign.CENTER}) {
    if (size < 1 || size > 16) {
      throw ArgumentError(
        'Invalid size: $size. Must be between 1 and 16.',
      );
    }
    if (height < 1 || height > 255) {
      throw ArgumentError(
        'Invalid height: $height. Must be between 1 and 255.',
      );
    }
    return SunmiBarcodeStyle._internal(
        align: align, height: height, size: size, textPos: textPos, type: type);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'size': size,
      'height': height,
      'textPos': textPos.name,
      'type': type.name,
      'align': align.name,
    };
  }
}
