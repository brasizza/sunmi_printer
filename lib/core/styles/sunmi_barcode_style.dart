import '../enums/enums.dart';

/// Represents the configuration for printing barcodes using a Sunmi printer.
///
/// The `SunmiBarcodeStyle` class provides a flexible and structured way to define the
/// appearance and properties of a barcode. This includes settings for size, height,
/// text position, barcode type, and alignment.
///
/// It ensures that all properties conform to valid ranges, avoiding invalid configurations
/// and providing meaningful error messages if an invalid value is supplied.
///
/// ### Example Usage
/// ```dart
/// SunmiBarcodeStyle style = SunmiBarcodeStyle(
///   size: 4,
///   height: 100,
///   textPos: SunmiBarcodeTextPos.TEXT_BELOW,
///   type: SunmiBarcodeType.CODE39,
///   align: SunmiPrintAlign.LEFT,
/// );
/// ```
/// This configuration can then be passed to a printer function to print a barcode.
class SunmiBarcodeStyle {
  /// The size of the barcode.
  ///
  /// [size] determines the thickness of the bars in the barcode.
  /// The value ranges from 1 to 16, where 1 is the thinnest and 16 is the thickest.
  ///
  /// Default value is 4.
  final int size;

  /// The height of the barcode.
  ///
  /// [height] sets how tall the barcode will be when printed.
  /// The value ranges from 1 to 255, with 1 being the shortest and 255 the tallest.
  ///
  /// Default value is 162.
  final int height;

  /// The position of the text relative to the barcode.
  ///
  /// [textPos] determines where, if at all, the human-readable text associated with the barcode will appear.
  /// It uses the [SunmiBarcodeTextPos] enum:
  /// - **NO_TEXT**: No text will be displayed.
  /// - **TEXT_ABOVE**: Text will appear above the barcode.
  /// - **TEXT_BELOW**: Text will appear below the barcode.
  ///
  /// Default value is [SunmiBarcodeTextPos.NO_TEXT].
  final SunmiBarcodeTextPos textPos;

  /// The type of the barcode.
  ///
  /// [type] specifies the barcode format to be printed. This uses the [SunmiBarcodeType] enum, which includes:
  /// - **CODE128**: A highly efficient barcode encoding alphanumeric characters (default).
  /// - Other formats, such as CODE39, EAN13, etc., depending on your printer's support.
  ///
  /// Default value is [SunmiBarcodeType.CODE128].
  final SunmiBarcodeType type;

  /// The alignment of the barcode on the page or print area.
  ///
  /// [align] determines how the barcode will be positioned relative to the page
  /// or printing area. The alignment options are defined in the [SunmiPrintAlign] enum:
  /// - **LEFT**: Align the barcode to the left.
  /// - **CENTER**: Align the barcode to the center.
  /// - **RIGHT**: Align the barcode to the right.
  ///
  /// Default value is [SunmiPrintAlign.CENTER].
  final SunmiPrintAlign align;

  // Private constructor to enforce the use of the factory method for creation.
  SunmiBarcodeStyle._internal({
    required this.size,
    required this.align,
    required this.height,
    required this.textPos,
    required this.type,
  });

  /// Factory constructor to create a [SunmiBarcodeStyle] object with default values
  /// and optional customizations.
  ///
  /// This method validates the size and height to ensure they fall within valid ranges.
  ///
  /// [size] determines the thickness of barcode bars (1 to 16, default: 4).
  /// [height] determines the height of the barcode (1 to 255, default: 162).
  /// [textPos] specifies text position relative to the barcode (default: NO_TEXT).
  /// [type] specifies the barcode type (default: CODE128).
  /// [align] specifies the alignment of the barcode (default: CENTER).
  factory SunmiBarcodeStyle({
    int size = 4,
    int height = 162,
    SunmiBarcodeTextPos textPos = SunmiBarcodeTextPos.NO_TEXT,
    SunmiBarcodeType type = SunmiBarcodeType.CODE128,
    SunmiPrintAlign align = SunmiPrintAlign.CENTER,
  }) {
    // Validate the size to ensure it falls within the valid range of 1 to 16.
    if (size < 1 || size > 16) {
      throw ArgumentError(
        'Invalid size: $size. Must be between 1 and 16.',
      );
    }

    // Validate the height to ensure it falls within the valid range of 1 to 255.
    if (height < 1 || height > 255) {
      throw ArgumentError(
        'Invalid height: $height. Must be between 1 and 255.',
      );
    }

    // Return a new instance of SunmiBarcodeStyle with the provided or default values.
    return SunmiBarcodeStyle._internal(
      align: align,
      height: height,
      size: size,
      textPos: textPos,
      type: type,
    );
  }

  /// Converts the [SunmiBarcodeStyle] object to a map for easy transfer or serialization.
  ///
  /// The returned map contains the properties of the barcode style, which can be
  /// used to send the configuration to the printer or another system.
  ///
  /// Returns a map with:
  /// - 'size': The thickness of the barcode bars.
  /// - 'height': The height of the barcode.
  /// - 'textPos': The position of the text (string representation).
  /// - 'type': The type of the barcode (string representation).
  /// - 'align': The alignment of the barcode (string representation).
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'size': size, // The thickness of the barcode bars.
      'height': height, // The height of the barcode.
      'textPos': textPos.name, // The position of the text.
      'type': type.name, // The type of the barcode.
      'align': align.name, // The alignment of the barcode.
    };
  }
}
