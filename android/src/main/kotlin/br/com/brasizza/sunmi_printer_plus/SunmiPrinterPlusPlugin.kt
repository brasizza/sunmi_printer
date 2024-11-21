package br.com.brasizza.sunmi_printer_plus

import android.content.Context
import android.util.Log
import com.sunmi.printerx.PrinterSdk
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

/** SunmiPrinterPlusPlugin */
class SunmiPrinterPlusPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var printer: SunmiPrinterClass
    private lateinit var sunmiInit: SunmiInitClass;
    private lateinit var configPrinter: SunmiConfigClass
    private lateinit var selectPrinter: PrinterSdk.Printer
    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val context: Context = flutterPluginBinding.getApplicationContext()

        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "sunmi_printer_plus")
        channel.setMethodCallHandler(this)
        sunmiInit = SunmiInitClass(context);
        sunmiInit.initPrinter { selectPrinter ->
            if (selectPrinter != null) {
                printer = SunmiPrinterClass(selectPrinter)
                configPrinter = SunmiConfigClass(selectPrinter)

            } else {

            }
        }


    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }

            "getStatus" -> {
                result.success(configPrinter.getStatus())
            }

            "getVersion" -> {
                result.success(configPrinter.getVersion())
            }

            "getPaper" -> {
                result.success(configPrinter.getPaper())
            }

            "getId" -> {
                result.success(configPrinter.getId())
            }

            "getType" -> result.success(configPrinter.getType())

            "printText" -> {
                val printerArgument: Map<String, Any>? = call.argument("data")
                result.success(printer.printText(printerArgument))
            }

            "printQrcode" -> {
                val qrcodeArgument: Map<String, Any>? = call.argument("data")
                result.success(printer.printQrcode(qrcodeArgument))
            }

            "printBarcode" -> {
                val qrcodeArgument: Map<String, Any>? = call.argument("data")
                result.success(printer.printBarcode(qrcodeArgument))
            }

            "printLine" -> {
                val lineArgument: String? = call.argument("data")
                result.success(printer.printLine(lineArgument))
            }

            else -> {
                result.notImplemented()
            }
        }

    }


    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
