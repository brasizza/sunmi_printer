import 'package:sunmi_printer_plus/core/enums/enums.dart';

class SunmiQrcodeStyle {
  int qrcodeSize;
  SunmiQrcodeLevel errorLevel;
  SunmiPrintAlign align;
  int width;
  int height;
  SunmiQrcodeStyle({
    this.qrcodeSize = 4,
    this.errorLevel = SunmiQrcodeLevel.LEVEL_L,
    this.align = SunmiPrintAlign.CENTER,
    this.width = -1,
    this.height = -1,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'qrcodeSize': qrcodeSize,
      'errorLevel': errorLevel.name,
      'align': align.name,
      'width': width,
      'height': height,
    };
  }
}
