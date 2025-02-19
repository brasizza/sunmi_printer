import 'package:flutter/services.dart';

/// Sunmi Helper
/// class that with generic convertion to String to Uint8List
class SunmiHelper {
  /// Loads an image from the asset and returns its bytes as a [Uint8List].
  ///
  /// This method is used to fetch image data (binary format) from the app's assets.
  /// It converts the image into a [Uint8List] which is the format required for
  /// processing or printing on devices like the Sunmi printer.
  ///
  /// [iconPath] is the path to the asset file in your project (e.g., 'assets/images/icon.png').
  ///
  /// Returns a [Future] that resolves to the image data as [Uint8List].
  ///
  /// Throws an exception if the image cannot be loaded from the asset.
  static Future<Uint8List> getImageFromAsset(String iconPath) async {
    try {
      // Call the private method to read the bytes from the asset file.
      return await _readFileBytes(iconPath);
    } catch (e) {
      // If there's an error, throw an exception with a message including the asset path.
      // This helps identify what went wrong during the loading process.
      throw Exception('Failed to load image from asset: $iconPath. Error: $e');
    }
  }

  /// Reads the file bytes from the asset path and returns it as a [Uint8List].
  ///
  /// [path] is the path to the asset file.
  ///
  /// This method uses [rootBundle.load] to load the asset's binary data and
  /// converts the loaded data into a [Uint8List], which is commonly used for
  /// working with raw binary data like images or other file types.
  ///
  /// Returns a [Uint8List] containing the bytes of the asset file.
  ///
  /// Throws an error if the asset is not found or cannot be loaded.
  static Future<Uint8List> _readFileBytes(String path) async {
    // Load the file from the asset bundle asynchronously.
    ByteData fileData = await rootBundle.load(path);

    // Convert the loaded ByteData into a Uint8List for further processing.
    // The 'buffer' property gives access to the underlying byte data,
    // and 'asUint8List' converts it into a list of unsigned 8-bit integers.
    Uint8List fileUnit8List = fileData.buffer
        .asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);

    // Return the image data as a Uint8List.
    return fileUnit8List;
  }
}
