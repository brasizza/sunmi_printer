import Flutter
import UIKit

public class SwiftSunmiPrinterPlusPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "sunmi_printer_plus", binaryMessenger: registrar.messenger())
    let instance = SwiftSunmiPrinterPlusPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
