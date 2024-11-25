// ignore_for_file: constant_identifier_names
library enums;

/// Describes the status of the printer.
///
/// Each status represents a different state of the printer.
/// - `WARN_*`: Warnings for various paper or cartridge states.
/// - `READY`: The printer is ready to print.
/// - `OFFLINE`: The printer is offline.
/// - `COMM`: Communication issues.
/// - `ERR_*`: Errors related to paper, cartridges, or other printer components.
///
/// Note: Even if the status is `ERROR`, attempt to print as some errors may not block printing.
enum PrinterStatus {
  /// Warning: Low or missing cartridge.
  WARN_CARTRIDGE,

  /// Warning: Special paper is required.
  WARN_SPECIAL_PAPER,

  /// Warning: Standard paper is required.
  WARN_STANDARD_PAPER,

  /// Warning: Pick paper issue detected.
  WARN_PICK_PAPER,

  /// Warning: Thermal paper is required.
  WARN_THERMAL_PAPER,

  /// The printer is ready to print.
  READY,

  /// The printer is offline.
  OFFLINE,

  /// Communication issues with the printer.
  COMM,

  /// Printer status is unknown.
  UNKNOWN,

  /// Error: Paper is out.
  ERR_PAPER_OUT,

  /// Error: Paper jam detected.
  ERR_PAPER_JAM,

  /// Error: Paper type mismatch.
  ERR_PAPER_MISMATCH,

  /// Error: Printer is too hot.
  ERR_PRINTER_HOT,

  /// Error: Printer motor is too hot.
  ERR_MOTOR_HOT,

  /// Error: Printer cover is open.
  ERR_COVER,

  /// Error: Printer cover is not completely closed.
  ERR_COVER_INCOMPLETE,

  /// Error: Cutter issue detected.
  ERR_CUTTER,

  /// Error: Cartridge is missing.
  ERR_CARTRIDGE_LOSS,

  /// Error: Cartridge type mismatch.
  ERR_CARTRIDGE_MISMATCH,

  /// Error: Cartridge is empty.
  ERR_CARTRIDGE_EMPTY,

  /// Error: Duplex unit is missing.
  ERR_DUPLEX_LOSS,

  /// Error: Carton is missing.
  ERR_CARTON_LOSS,

  /// Error: Carton type mismatch.
  ERR_CARTON_MISMATCH,

  /// Error: Carton is empty.
  ERR_CARTON_EMPTY,

  /// Error: Drum unit is missing.
  ERR_DRUM_LOSS,

  /// Error: Drum type mismatch.
  ERR_DRUM_MISMATCH,

  /// Error: Drum is empty.
  ERR_DRUM_EMPTY,

  /// Error: Stepper motor issue detected.
  ERR_STEP,
}

/// Enum to define the printer mode.
enum PrinterMode {
  /// Printer mode is unknown.
  UNKNOWN,

  /// Normal printing mode.
  NORMAL_MODE,

  /// Black label printing mode.
  BLACK_LABEL_MODE,

  /// Label printing mode.
  LABEL_MODE,
}

/// Enum to define printer alignment options.
enum SunmiPrintAlign {
  /// Align text or content to the left.
  LEFT,

  /// Align text or content to the center.
  CENTER,

  /// Align text or content to the right.
  RIGHT,
}

/// Enum to define line styles for Sunmi printers.
enum SunmiPrintLine {
  /// Solid line style.
  SOLID,

  /// Dotted line style.
  DOTTED,
}

/// Enum to set QR code error correction levels.
enum SunmiQrcodeLevel {
  /// Low error correction.
  LEVEL_L,

  /// Medium error correction.
  LEVEL_M,

  /// Quartile error correction.
  LEVEL_Q,

  /// High error correction.
  LEVEL_H,
}

/// Enum to define barcode types for Sunmi printers.
enum SunmiBarcodeType {
  /// UPC-A barcode type.
  UPCA,

  /// UPC-E barcode type.
  UPCE,

  /// JAN-13 (EAN-13) barcode type.
  JAN13,

  /// JAN-8 (EAN-8) barcode type.
  JAN8,

  /// Code 39 barcode type.
  CODE39,

  /// Interleaved 2 of 5 barcode type.
  ITF,

  /// Codabar barcode type.
  CODABAR,

  /// Code 93 barcode type.
  CODE93,

  /// Code 128 barcode type.
  CODE128,
}

/// Enum to define text position options in a barcode.
enum SunmiBarcodeTextPos {
  /// Do not display text with the barcode.
  NO_TEXT,

  /// Display text above the barcode.
  TEXT_ABOVE,

  /// Display text below the barcode.
  TEXT_UNDER,

  /// Display text both above and below the barcode.
  BOTH,
}

/// Enum to define LCD screen statuses for Sunmi printers.
enum SunmiLCDStatus {
  /// Initialize the LCD.
  INIT,

  /// Wake up the LCD from sleep.
  WAKE,

  /// Put the LCD to sleep.
  SLEEP,

  /// Clear the LCD screen.
  CLEAR,
}
