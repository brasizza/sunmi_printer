import 'package:flutter/services.dart';

class SunmiHelper {
  static SunmiHelper? _instance;
  // Avoid self instance
  SunmiHelper._();
  static SunmiHelper get i => _instance ??= SunmiHelper._();

  Future<Uint8List> getImageFromAsset(String iconPath) async {
    return await _readFileBytes(iconPath);
  }

  Future<Uint8List> _readFileBytes(String path) async {
    ByteData fileData = await rootBundle.load(path);
    Uint8List fileUnit8List = fileData.buffer.asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
    return fileUnit8List;
  }
}
