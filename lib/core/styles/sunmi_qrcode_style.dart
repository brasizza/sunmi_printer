import '../enums/enums.dart';

/// A class that represents the style for printing QR codes on Sunmi printers.
///
/// This class encapsulates the size, error correction level, and alignment of a QR code.
class SunmiQrcodeStyle {
  /// The size of the QR code.
  ///
  /// [qrcodeSize] determines how large the QR code will be when printed.
  /// The size can range from 1 to 16, where 1 is the smallest and 16 is the largest.
  ///
  /// Default value is 4.
  final int qrcodeSize;

  /// The error correction level for the QR code.
  ///
  /// [errorLevel] controls how much of the QR code can be damaged or obscured
  /// while still being readable. Higher levels of error correction make the QR code
  /// more resilient but increase the amount of data required.
  /// The available levels are defined in the [SunmiQrcodeLevel] enum:
  /// - LEVEL_L: Low error correction (approx. 7% of the code can be restored).
  /// - LEVEL_M: Medium error correction (approx. 15% of the code can be restored).
  /// - LEVEL_Q: Quartile error correction (approx. 25% of the code can be restored).
  /// - LEVEL_H: High error correction (approx. 30% of the code can be restored).
  ///
  /// Default value is SunmiQrcodeLevel.LEVEL_L.
  final SunmiQrcodeLevel errorLevel;

  /// The alignment of the QR code on the page or print area.
  ///
  /// [align] determines how the QR code will be positioned relative to the page
  /// or printing area. The alignment options are defined in the [SunmiPrintAlign] enum.
  /// - LEFT: Align the QR code to the left.
  /// - CENTER: Align the QR code to the center.
  /// - RIGHT: Align the QR code to the right.
  ///
  /// Default value is SunmiPrintAlign.CENTER.
  final SunmiPrintAlign align;

  // Private constructor to enforce the use of the factory method for creation.
  SunmiQrcodeStyle._internal({
    required this.qrcodeSize,
    required this.errorLevel,
    required this.align,
  });

  /// Factory constructor to create a [SunmiQrcodeStyle] object with default values
  /// and optional customizations.
  ///
  /// This method validates the QR code size to ensure it is within a valid range
  /// (between 1 and 16). It also allows the user to specify custom error correction
  /// levels and alignment options.
  ///
  /// [qrcodeSize] defaults to 4, but can be adjusted between 1 and 16.
  /// [errorLevel] defaults to SunmiQrcodeLevel.LEVEL_L.
  /// [align] defaults to SunmiPrintAlign.CENTER.
  factory SunmiQrcodeStyle({
    int qrcodeSize = 4,
    SunmiQrcodeLevel errorLevel = SunmiQrcodeLevel.LEVEL_L,
    SunmiPrintAlign align = SunmiPrintAlign.CENTER,
  }) {
    // Validate that the qrcodeSize is between 1 and 16.
    if (qrcodeSize < 1 || qrcodeSize > 16) {
      throw ArgumentError(
        'Invalid qrcodeSize: $qrcodeSize. Must be between 1 and 16.',
      );
    }

    // Return a new instance of SunmiQrcodeStyle with the provided or default values.
    return SunmiQrcodeStyle._internal(
      qrcodeSize: qrcodeSize,
      errorLevel: errorLevel,
      align: align,
    );
  }

  /// Converts the [SunmiQrcodeStyle] object to a map for easy transfer or serialization.
  ///
  /// The returned map contains the properties of the QR code style, which can be
  /// used to send the configuration to the printer or another system.
  ///
  /// Returns a map with:
  /// - 'qrcodeSize': The size of the QR code.
  /// - 'errorLevel': The error correction level for the QR code.
  /// - 'align': The alignment of the QR code.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'qrcodeSize': qrcodeSize, // The size of the QR code.
      'errorLevel': errorLevel
          .name, // The error correction level (string representation).
      'align': align.name, // The alignment (string representation).
    };
  }
}
