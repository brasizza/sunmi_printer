package br.com.brasizza.sunmi_printer_plus

import android.content.Context
import android.graphics.BitmapFactory
import android.os.Build
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
    private lateinit var sunmiPrinter: SunmiPrinterClass
    private lateinit var sunmiInit: SunmiInitClass
    private lateinit var configPrinter: SunmiConfigClass
    private lateinit var printerCommand: SunmiCommandPrinter
    private lateinit var sunmiLCD: SunmiLCDClass
    private lateinit var sunmiDrawer: SunmiDrawerClass
    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val context: Context = flutterPluginBinding.getApplicationContext()
        sunmiInit = SunmiInitClass(context);
        sunmiInit.initPrinter { selectPrinter ->
            if (selectPrinter != null) {
                configPrinter = SunmiConfigClass(selectPrinter)
                sunmiPrinter = SunmiPrinterClass(selectPrinter)
                printerCommand = SunmiCommandPrinter(selectPrinter)
                sunmiLCD = SunmiLCDClass(selectPrinter)
                sunmiDrawer = SunmiDrawerClass(selectPrinter)
            }
        }
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "sunmi_printer_plus")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${Build.VERSION.RELEASE}")
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
                result.success(sunmiPrinter.printText(printerArgument))
            }

            "printQrcode" -> {
                val qrcodeArgument: Map<String, Any>? = call.argument("data")
                result.success(sunmiPrinter.printQrcode(qrcodeArgument))
            }

            "printBarcode" -> {
                val qrcodeArgument: Map<String, Any>? = call.argument("data")
                result.success(sunmiPrinter.printBarcode(qrcodeArgument))
            }

            "printLine" -> {
                val lineArgument: String? = call.argument("data")
                result.success(sunmiPrinter.printLine(lineArgument))
            }

            "lineWrap" -> {
                val wrapArgument: Int = call.argument("times")?: 1
                result.success(sunmiPrinter.lineWrap(wrapArgument))
            }


            "cutPaper" -> {
                result.success(sunmiPrinter.cutPaper())
            }

            "printImage" -> {
                val bytes: ByteArray? = call.argument("image")
                val alignArgument: String? = call.argument("align")
                if(bytes != null){
                val bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.size)
                    result.success(sunmiPrinter.printImage(bitmap,alignArgument))
                }else{
                    result.success("invalid")
                }
            }


            "addText" -> {
                val printerArgument: Map<String, Any>? = call.argument("data")
                result.success(sunmiPrinter.addText(printerArgument))
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
                result.success(sunmiPrinter.printRow(rowArguments))
            }



            "configLCD" -> {
                val lcdStatus: String? = call.argument("status")
                result.success(sunmiLCD.configLCD(lcdStatus))
            }


            "sendTextLCD" -> {
                val textData: String = call.argument("text")?: ""
                val textSize: Int = call.argument("size")?: 32
                val textFill: Boolean = call.argument("fill")?: false
                result.success(sunmiLCD.sendTextLCD(textData,textSize,textFill))
            }

            "showDigital" -> {
                val digitalData: String = call.argument("digital")?: ""

                result.success(sunmiLCD.showDigital(digitalData))
            }

            "sendImageLCD" -> {
                val bytes: ByteArray? = call.argument("image")
                if(bytes != null) {
                    val bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.size)
                    result.success( sunmiLCD.sendImageLCD(bitmap))
                }
            }

            "openDrawer" -> {
                result.success(sunmiDrawer.openDrawer())
            }

            "isDrawerOpen" -> {
                result.success(sunmiDrawer.isDrawerOpen())
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
