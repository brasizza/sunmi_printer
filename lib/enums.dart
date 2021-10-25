// ignore_for_file: constant_identifier_names
library enums;

///*PrinterStatus*
///
///This enum will give you the status of the printer.
///Sometimes the status can be ERROR, but don't worry about this status, always try co print anyway!
enum PrinterStatus {
  UNKNOWN,
  ERROR,
  NORMAL,
  ABNORMAL_COMMUNICATION,
  OUT_OF_PAPER,
  PREPARING,
  OVERHEATED,
  OPEN_THE_LID,
  PAPER_CUTTER_ABNORMAL,
  PAPER_CUTTER_RECOVERED,
  NO_BLACK_MARK,
  NO_PRINTER_DETECTED,
  FAILED_TO_UPGRADE_FIRMWARE,
  EXCEPTION,
}

///*PrinterMode*
///
///Enum to set printer mode
enum PrinterMode {
  UNKNOWN,
  NORMAL_MODE,
  BLACK_LABEL_MODE,
  LABEL_MODE,
}

///*SunmiPrintAlign*
///
///Enum to set printer aligntment
enum SunmiPrintAlign {
  LEFT,
  CENTER,
  RIGHT,
}

///*SunmiQrcodeLevel*
///
//Enum to set a QRcode Level (Low to High)
enum SunmiQrcodeLevel {
  LEVEL_L,
  LEVEL_M,
  LEVEL_Q,
  LEVEL_H,
}

///*SunmiBarcodeType*
///
///Enum to set Barcode Type
enum SunmiBarcodeType {
  UPCA,
  UPCE,
  JAN13,
  JAN8,
  CODE39,
  ITF,
  CODABAR,
  CODE93,
  CODE128,
}

///*SunmiBarcodeTextPos*
///
///Enum to set how the thex will be printed in barcode
enum SunmiBarcodeTextPos {
  NO_TEXT,
  TEXT_ABOVE,
  TEXT_UNDER,
  BOTH,
}

///*SunmiFontSize*
///Enum to set font in the printer
enum SunmiFontSize {
  XS,
  SM,
  MD,
  LG,
  XL,
}
