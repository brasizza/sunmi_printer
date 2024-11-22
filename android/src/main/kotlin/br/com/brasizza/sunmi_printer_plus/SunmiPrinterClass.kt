package br.com.brasizza.sunmi_printer_plus

import android.graphics.Bitmap
import android.util.Log
import com.sunmi.printerx.PrinterSdk.Printer
import com.sunmi.printerx.SdkException
import com.sunmi.printerx.enums.Align
import com.sunmi.printerx.enums.DividingLine
import com.sunmi.printerx.enums.ErrorLevel
import com.sunmi.printerx.enums.HumanReadable
import com.sunmi.printerx.enums.ImageAlgorithm
import com.sunmi.printerx.enums.Symbology
import com.sunmi.printerx.style.BarcodeStyle
import com.sunmi.printerx.style.BaseStyle
import com.sunmi.printerx.style.BitmapStyle
import com.sunmi.printerx.style.QrStyle
import com.sunmi.printerx.style.TextStyle


class SunmiPrinterClass(private  val printer: Printer?) {
    private var lineApi = printer?.lineApi();
    fun printText(printerArgument: Map<String, Any>?): String {
        if (printerArgument == null) return "No arguments provided"

        return try {
            val textStyle = TextStyle.getStyle().apply {
                setAlign(getAlignment(printerArgument["align"] as? String))
                setTextSize( printerArgument["fontSize"] as? Int ?: 24)
                enableBold(printerArgument["bold"] as? Boolean ?: false)
                enableUnderline(printerArgument["underline"] as? Boolean ?: false)
                enableStrikethrough(printerArgument["strikethrough"] as? Boolean ?: false)
                enableItalics(printerArgument["italic"] as? Boolean ?: false)
                enableAntiColor(printerArgument["reverse"] as? Boolean ?: false)
            }
            val text = printerArgument["text"] as? String
                ?: return "No text provided to print"
            lineApi?.initLine(BaseStyle.getStyle().setAlign(getAlignment(printerArgument["align"] as? String)))
            lineApi?.printText(text, textStyle)
            "ok"
        } catch (e: SdkException) {
            Log.e("sunmi_printer_plus", "Error while printing: ${e.message}", e)
            "error"
        }
    }

    private fun getAlignment(align: String?): Align {
        return when (align) {
            "CENTER" -> Align.CENTER
            "LEFT" -> Align.LEFT
            "RIGHT" -> Align.RIGHT
            else -> Align.DEFAULT
        }
    }


    fun printQrcode(qrcodeArgument: Map<String, Any>?): String {
        if (qrcodeArgument == null) return "No arguments provided"
        return try {
            val qrStyle = QrStyle.getStyle().apply {
                setDot(qrcodeArgument["qrcodeSize"] as? Int ?: 4)
                setErrorLevel(getErrorLevel(qrcodeArgument["errorLevel"] as? String))
                setAlign(getAlignment(qrcodeArgument["align"] as? String))
            }

            val qrText = qrcodeArgument["text"] as? String ?: return "No text provided for QR code"
            lineApi?.printQrCode(qrText, qrStyle)
            "ok"
        } catch (e: SdkException) {
            Log.e("sunmi_printer_plus", "Error while printing QR code: ${e.message}", e)
            "error"
        }
    }

    fun printBarcode(barcodeArgument: Map<String, Any>?): String {
        if (barcodeArgument == null) return "No arguments provided"
        return try {
            val barcodeStyle = BarcodeStyle.getStyle().apply {
                setDotWidth(barcodeArgument["size"] as? Int ?: 0)
                setBarHeight(barcodeArgument["height"] as? Int ?: 0)
                setReadable(getTextPosition(barcodeArgument["textPos"] as? String))
                setAlign(getAlignment(barcodeArgument["align"] as? String))
                setSymbology(getSymbology(barcodeArgument["type"] as? String))
            }

            val barcodeText = barcodeArgument["text"] as? String ?: return "No text provided for barcode"
            lineApi?.printBarCode(barcodeText, barcodeStyle)
            "ok"
        } catch (e: SdkException) {
            Log.e("sunmi_printer_plus", "Error while printing barcode: ${e.message}", e)
            "error"
        }
    }

    fun printLine(lineArgument: String?): String {
        val divider = when (lineArgument) {
            "SOLID" -> DividingLine.SOLID
            "DOTTED" -> DividingLine.DOTTED
            else -> DividingLine.EMPTY
        }
        lineApi?.printDividingLine(divider, 1)
        return "ok"
    }

    fun lineWrap(times: Int): String {
        lineApi?.printDividingLine(DividingLine.EMPTY, times)
        return "ok"
    }

    fun cutPaper(): String {
        lineApi?.autoOut()
        return "ok"
    }

    private fun getErrorLevel(level: String?): ErrorLevel {
        return when (level) {
            "LEVEL_H" -> ErrorLevel.H
            "LEVEL_M" -> ErrorLevel.M
            "LEVEL_Q" -> ErrorLevel.Q
            else -> ErrorLevel.L
        }
    }

    private fun getTextPosition(position: String?): HumanReadable {
        return when (position) {
            "NO_TEXT" -> HumanReadable.HIDE
            "TEXT_ABOVE" -> HumanReadable.POS_ONE
            "TEXT_UNDER" -> HumanReadable.POS_TWO
            "BOTH" -> HumanReadable.POS_THREE
            else -> HumanReadable.HIDE
        }
    }

    private fun getSymbology(type: String?): Symbology {
        return when (type) {
            "UPCA" -> Symbology.UPCA
            "UPCE" -> Symbology.UPCE
            "JAN13" -> Symbology.EAN13
            "JAN8" -> Symbology.EAN8
            "CODE39" -> Symbology.CODE39
            "ITF" -> Symbology.ITF
            "CODABAR" -> Symbology.CODABAR
            "CODE93" -> Symbology.CODE93
            "CODE128" -> Symbology.CODE128
            else -> Symbology.CODE128
        }
    }

    fun printImage(bitmap: Bitmap?, alignArgument: String?)  : String {

        lineApi?.initLine(BaseStyle.getStyle().setAlign(getAlignment(alignArgument )))
        lineApi?.printBitmap(bitmap, BitmapStyle.getStyle().setAlgorithm(ImageAlgorithm.DITHERING))
        return "ok"
    }

    fun addText(printerArgument: Map<String, Any>?): String? {
        if (printerArgument == null) return "No arguments provided"
        return try {
            val textStyle = buildTextStyle(printerArgument)
            val text = printerArgument["text"] as? String
                ?: return "No text provided to print"
            lineApi?.addText(text, textStyle)
            "ok"
        } catch (e: SdkException) {
            Log.e("sunmi_printer_plus", "Error while printing: ${e.message}", e)
            "error"
        }
    }

    private fun buildTextStyle(printerArgument: Map<String, Any>): TextStyle? {
        val textStyle = try {
            TextStyle.getStyle().apply {
                setAlign(getAlignment(printerArgument["align"] as? String))
                setTextSize(printerArgument["fontSize"] as? Int ?: 24)
                enableBold(printerArgument["bold"] as? Boolean ?: false)
                enableUnderline(printerArgument["underline"] as? Boolean ?: false)
                enableStrikethrough(printerArgument["strikethrough"] as? Boolean ?: false)
                enableItalics(printerArgument["italic"] as? Boolean ?: false)
                enableAntiColor(printerArgument["reverse"] as? Boolean ?: false)
            }
        } catch (e: Exception) {
           return TextStyle.getStyle();
        }
        return textStyle
    }

    fun printRow(rowArguments: Map<String, Any>): String? {
       try {
           val widths = (rowArguments["width"] as? List<*>)?.filterIsInstance<Int>() ?: emptyList()
           val styles = (rowArguments["style"] as? List<*>)?.map { it as? Map<String, Any?> } ?: emptyList()
           val texts = (rowArguments["text"] as? List<*>)?.filterIsInstance<String>() ?: emptyList()
           val textsArray = texts.toTypedArray()
            val widthsArray: IntArray = widths.toIntArray()
            val textStylesMutable: MutableList<TextStyle> = mutableListOf()
            for (style in styles){
                    if(style == null){
                        textStylesMutable.add(TextStyle.getStyle())
                    }else {
                        val map: Map<String, Any> = (style as? Map<String, Any?>)?.filterValues { it != null }?.mapValues { it.value!! }
                        ?: emptyMap()
                        textStylesMutable.add(buildTextStyle(map)!!)
                    }
            }
            val textStylesArray: Array<TextStyle> = textStylesMutable.toTypedArray()
           lineApi?.printTexts(textsArray,widthsArray,textStylesArray)
        } catch (e: SdkException) {
            Log.e("sunmi_printer_plus", "Error while printing: ${e.message}", e)
        }
        return "ok"
    }


}