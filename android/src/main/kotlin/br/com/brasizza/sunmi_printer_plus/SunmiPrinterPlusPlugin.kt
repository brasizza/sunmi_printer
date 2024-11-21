package br.com.brasizza.sunmi_printer_plus

import android.content.Context
import android.graphics.BitmapFactory
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
    private lateinit var sunmiInit: SunmiInitClass
    private lateinit var configPrinter: SunmiConfigClass
    private lateinit var printerCommand: SunmiCommandPrinter
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
                printerCommand = SunmiCommandPrinter(selectPrinter);

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

            "lineWrap" -> {
                val wrapArgument: Int = call.argument("times")?: 1
                result.success(printer.lineWrap(wrapArgument))
            }


            "cutPaper" -> {

                result.success(printer.cutPaper())
            }

            "printImage" -> {
                val bytes: ByteArray? = call.argument("image")
                val alignArgument: String? = call.argument("align")
                if(bytes != null){
                val bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.size)
                printer.printImage(bitmap,alignArgument)
                }
            }


            "addText" -> {
                val printerArgument: Map<String, Any>? = call.argument("data")
                result.success(printer.addText(printerArgument))
            }

            "printEscPos" -> {
                val escArgument: ByteArray = call.argument<List<Int>>("data")!!
                    .map { it.toByte() }
                    .toByteArray()

                result.success(printerCommand.printEscPos(escArgument))
            }

            "printTSPL" -> {
                val tsplArgument: ByteArray = call.argument<String>("data")!!.toByteArray(Charsets.US_ASCII)
                result.success(printerCommand.printTSPL(tsplArgument))
            }


            "printRow" -> {
                val rowArguments: Map<String, Any> = call.argument("data")!!
                result.success(printer.printRow(rowArguments))
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
