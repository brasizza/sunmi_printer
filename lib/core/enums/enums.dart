// ignore_for_file: constant_identifier_names
library enums;

///*PrinterStatus*
///
///This enum will give you the status of the printer.
///Sometimes the status can be ERROR, but don't worry about this status, always try co print anyway!
enum PrinterStatus {
  WARN_CARTRIDGE,
  WARN_SPECIAL_PAPER,
  WARN_STANDARD_PAPER,
  WARN_PICK_PAPER,
  WARN_THERMAL_PAPER,
  READY,
  OFFLINE,
  COMM,
  UNKNOWN,
  ERR_PAPER_OUT,
  ERR_PAPER_JAM,
  ERR_PAPER_MISMATCH,
  ERR_PRINTER_HOT,
  ERR_MOTOR_HOT,
  ERR_COVER,
  ERR_COVER_INCOMPLETE,
  ERR_CUTTER,
  ERR_CARTRIDGE_LOSS,
  ERR_CARTRIDGE_MISMATCH,
  ERR_CARTRIDGE_EMPTY,
  ERR_DUPLEX_LOSS,
  ERR_CARTON_LOSS,
  ERR_CARTON_MISMATCH,
  ERR_CARTON_EMPTY,
  ERR_DRUM_LOSS,
  ERR_DRUM_MISMATCH,
  ERR_DRUM_EMPTY,
  ERR_STEP,
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

enum SunmiPrintLine {
  SOLID,
  DOTTED,
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

///*SunmiLCDStatus*
///Enum to set lcd status
enum SunmiLCDStatus {
  INIT,
  WAKE,
  SLEEP,
  CLEAR,
}
