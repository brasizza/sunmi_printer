import '../enums/enums.dart';

/// Represents the style configuration for text printing on a Sunmi printer.
///
/// The `SunmiTextStyle` class provides a structured way to define the appearance
/// of text when printed. It includes options for font size, alignment, boldness,
/// underline, strikethrough, italicization, and reverse printing.
///
/// This class ensures that the configurations are valid and allows for flexible
/// customization of text appearance to meet various printing requirements.
///
/// ### Example Usage
/// ```dart
/// SunmiTextStyle style = SunmiTextStyle(
///   fontSize: 36,
///   align: SunmiPrintAlign.CENTER,
///   bold: true,
///   underline: true,
///   italic: false,
///   reverse: false,
/// );
/// ```
class SunmiTextStyle {
  /// The font size of the printed text.
  ///
  /// [fontSize] defines the size of the text in points. It must be a value between
  /// 1 and 96, where 1 represents the smallest size and 96 the largest.
  ///
  /// Default value is 24.
  final int? fontSize;

  /// The alignment of the text on the page or print area.
  ///
  /// [align] determines how the text is positioned relative to the page
  /// or print area. Possible values are defined in the [SunmiPrintAlign] enum:
  /// - **LEFT**: Align text to the left.
  /// - **CENTER**: Align text to the center.
  /// - **RIGHT**: Align text to the right.
  ///
  /// Default value is [SunmiPrintAlign.LEFT].
  final SunmiPrintAlign? align;

  /// Indicates whether the text should be bold.
  ///
  /// [bold] is a boolean flag. If set to `true`, the text will be printed in bold style.
  /// This can be useful for emphasizing important information.
  ///
  /// Default value is `false`.
  final bool? bold;

  /// Indicates whether the text should have an underline.
  ///
  /// [underline] is a boolean flag. If set to `true`, an underline will be printed
  /// beneath the text, commonly used for emphasis or links.
  ///
  /// Default value is `false`.
  final bool? underline;

  /// Indicates whether the text should have a strikethrough.
  ///
  /// [strikethrough] is a boolean flag. If set to `true`, a line will be drawn
  /// through the middle of the text, often used to indicate deletion or revision.
  ///
  /// Default value is `false`.
  final bool? strikethrough;

  /// Indicates whether the text should be italicized.
  ///
  /// [italic] is a boolean flag. If set to `true`, the text will be printed
  /// in an italic style, often used for emphasis or quotes.
  ///
  /// Default value is `false`.
  final bool? italic;

  /// Indicates whether the text should be printed in reverse.
  ///
  /// [reverse] is a boolean flag. If set to `true`, the text will be printed
  /// in reverse mode (white text on a black background). This is useful for
  /// creating highlighted sections or drawing attention to specific text.
  ///
  /// Default value is `false`.
  final bool? reverse;

  // Private constructor to enforce the use of the factory method for object creation.
  SunmiTextStyle._internal({
    required this.fontSize,
    required this.align,
    required this.bold,
    required this.underline,
    required this.strikethrough,
    required this.italic,
    required this.reverse,
  });

  /// Factory constructor to create a [SunmiTextStyle] object with optional customizations.
  ///
  /// Validates the [fontSize] to ensure it falls within the acceptable range of 1 to 96.
  /// Throws an [ArgumentError] if the size is invalid.
  ///
  /// Default values:
  /// - [fontSize]: 24
  /// - [align]: [SunmiPrintAlign.LEFT]
  /// - [bold]: false
  /// - [underline]: false
  /// - [strikethrough]: false
  /// - [italic]: false
  /// - [reverse]: false
  factory SunmiTextStyle({
    int fontSize = 24,
    SunmiPrintAlign align = SunmiPrintAlign.LEFT,
    bool bold = false,
    bool underline = false,
    bool strikethrough = false,
    bool italic = false,
    bool reverse = false,
  }) {
    // Validate fontSize to ensure it's within the range of 1 to 96.
    if (fontSize < 1 || fontSize > 96) {
      throw ArgumentError(
        'Invalid fontSize: $fontSize. Must be between 1 and 96.',
      );
    }

    // Return a new instance of SunmiTextStyle with provided or default values.
    return SunmiTextStyle._internal(
      align: align,
      bold: bold,
      fontSize: fontSize,
      italic: italic,
      reverse: reverse,
      strikethrough: strikethrough,
      underline: underline,
    );
  }

  /// Converts the [SunmiTextStyle] object to a map for serialization or transfer.
  ///
  /// The resulting map contains:
  /// - 'fontSize': The size of the text.
  /// - 'align': The alignment of the text (string representation).
  /// - 'bold': Whether the text is bold.
  /// - 'underline': Whether the text has an underline.
  /// - 'strikethrough': Whether the text has a strikethrough.
  /// - 'italic': Whether the text is italicized.
  /// - 'reverse': Whether the text is printed in reverse mode.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fontSize': fontSize, // The size of the text.
      'align': align?.name, // The alignment of the text.
      'bold': bold, // Whether the text is bold.
      'underline': underline, // Whether the text has an underline.
      'strikethrough': strikethrough, // Whether the text has a strikethrough.
      'italic': italic, // Whether the text is italicized.
      'reverse': reverse, // Whether the text is in reverse mode.
    };
  }
}
