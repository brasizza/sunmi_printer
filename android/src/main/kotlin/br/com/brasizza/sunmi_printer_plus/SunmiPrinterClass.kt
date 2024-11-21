package br.com.brasizza.sunmi_printer_plus

import android.util.Log
import android.content.Context
import com.sunmi.printerx.PrinterSdk
import com.sunmi.printerx.PrinterSdk.Printer
import com.sunmi.printerx.PrinterSdk.PrinterListen
import com.sunmi.printerx.SdkException
import com.sunmi.printerx.api.LineApi
import com.sunmi.printerx.api.QueryApi
import com.sunmi.printerx.enums.Align
import com.sunmi.printerx.enums.DividingLine
import com.sunmi.printerx.enums.ErrorLevel
import com.sunmi.printerx.enums.HumanReadable
import com.sunmi.printerx.enums.PrinterInfo
import com.sunmi.printerx.enums.Symbology
import com.sunmi.printerx.style.AreaStyle
import com.sunmi.printerx.style.BarcodeStyle
import com.sunmi.printerx.style.BaseStyle
import com.sunmi.printerx.style.QrStyle
import com.sunmi.printerx.style.TextStyle
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


class SunmiPrinterClass(private  val printer: Printer?) {
    private var lineApi = printer?.lineApi();
    fun printText(printerArgument: Map<String, Any>?): String? {
        try {
            val textStyle = TextStyle.getStyle()
            lineApi?.printText(printerArgument!!["text"] as String?, textStyle);
        } catch (e: SdkException) {
            Log.d("sunmi_printer_plus", "Error =>" + e.message)
            e.printStackTrace()
        }

        return "ok";


    }

    fun printQrcode(qrcodeArgument: Map<String, Any>?): String? {
        try {
            val qrStyle = QrStyle.getStyle()
            qrcodeArgument?.let {
                val qrSize = it["qrcodeSize"] as? Int ?: 0
                qrStyle.setDot(qrSize)
                val qrLevel = when (it["errorLevel"] as? String) {
                    "LEVEL_H" -> ErrorLevel.H
                    "LEVEL_M" -> ErrorLevel.M
                    "LEVEL_Q" -> ErrorLevel.Q
                    else -> ErrorLevel.L
                }
                qrStyle.setErrorLevel(qrLevel)
                val qrAlign = when (it["align"] as? String) {
                    "CENTER" -> Align.CENTER
                    "LEFT" -> Align.LEFT
                    "RIGHT" -> Align.RIGHT
                    else -> Align.DEFAULT
                }
                qrStyle.setAlign(qrAlign)
                val qrText = it["text"] as? String
                lineApi?.printQrCode(qrText, qrStyle)
            }
        } catch (e: SdkException) {
            Log.d("sunmi_printer_plus", "Error => ${e.message}")
            e.printStackTrace()
        }
        return "ok"
    }

    fun printBarcode(qrcodeArgument: Map<String, Any>?): String? {
        try {
            val qrStyle = BarcodeStyle.getStyle()
            qrcodeArgument?.let {
                val barcodeSize = it["size"] as? Int ?: 0
                qrStyle.setDotWidth(barcodeSize)

                val barcodeHeight = it["height"] as? Int ?: 0
                qrStyle.setBarHeight(barcodeHeight)

                val textPos = when (it["textPos"] as? String) {
                    "NO_TEXT" -> HumanReadable.HIDE
                    "TEXT_ABOVE" -> HumanReadable.POS_ONE
                    "TEXT_UNDER" -> HumanReadable.POS_TWO
                    "BOTH" -> HumanReadable.POS_THREE
                    else -> HumanReadable.HIDE
                }
                qrStyle.setReadable(textPos)
                val qrAlign = when (it["align"] as? String) {
                    "CENTER" -> Align.CENTER
                    "LEFT" -> Align.LEFT
                    "RIGHT" -> Align.RIGHT
                    else -> Align.DEFAULT
                }
                qrStyle.setAlign(qrAlign)

                val qrType = when (it["type"] as? String) {
                    "UPCA" ->(Symbology.UPCA)
                    "UPCE" ->(Symbology.UPCE)
                    "JAN13" ->(Symbology.EAN13)
                    "JAN8" ->(Symbology.EAN8)
                    "CODE39" ->(Symbology.CODE39)
                    "ITF" ->(Symbology.ITF)
                    "CODABAR" ->(Symbology.CODABAR)
                    "CODE93" ->(Symbology.CODE93)
                    "CODE128" ->(Symbology.CODE128)
                    else ->Symbology.CODE128
                }
                qrStyle.setSymbology(qrType)

                val qrText = it["text"] as? String
                lineApi?.printBarCode(qrText, qrStyle)
            }
        } catch (e: SdkException) {
            Log.d("sunmi_printer_plus", "Error => ${e.message}")
            e.printStackTrace()
        }
        return "ok"
    }

    fun printLine(lineArgument: String?): String? {
        var divider = when (lineArgument) {
            "SOLID" -> {
                DividingLine.SOLID;
            }
            "DOTTED" -> {
                DividingLine.DOTTED
            }
            else -> {
                DividingLine.EMPTY
            }
        }
       lineApi?.printDividingLine(divider,1);
        return "ok"

    }


}