import '../enums/enums.dart';

class SunmiQrcodeStyle {
  final int qrcodeSize;
  final SunmiQrcodeLevel errorLevel;
  final SunmiPrintAlign align;

  SunmiQrcodeStyle._internal({
    required this.qrcodeSize,
    required this.errorLevel,
    required this.align,
  });

  factory SunmiQrcodeStyle({
    int qrcodeSize = 4,
    SunmiQrcodeLevel errorLevel = SunmiQrcodeLevel.LEVEL_L,
    SunmiPrintAlign align = SunmiPrintAlign.CENTER,
  }) {
    if (qrcodeSize < 1 || qrcodeSize > 16) {
      throw ArgumentError(
        'Invalid qrcodeSize: $qrcodeSize. Must be between 1 and 16.',
      );
    }
    return SunmiQrcodeStyle._internal(
      qrcodeSize: qrcodeSize,
      errorLevel: errorLevel,
      align: align,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'qrcodeSize': qrcodeSize,
      'errorLevel': errorLevel.name,
      'align': align.name,
    };
  }
}
