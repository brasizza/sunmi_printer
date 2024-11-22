package br.com.brasizza.sunmi_printer_plus

import android.graphics.Bitmap
import android.util.Log
import com.sunmi.printerx.PrinterSdk.Printer
import com.sunmi.printerx.SdkException
import com.sunmi.printerx.enums.Command

class SunmiLCDClass(private  val printer: Printer?) {

    private var lcdApi = printer!!.lcdApi();
    fun configLCD(lcdStatus: String?): String? {
        try {
            val command = when (lcdStatus) {
                "INIT" -> Command.INIT
                "WAKE" -> Command.WAKE
                "CLEAR" -> Command.CLEAR
                "SLEEP" -> Command.SLEEP
                else ->Command.CLEAR
            }
            lcdApi?.config(command)
        } catch (e: SdkException) {
            Log.d("sunmi_printer_plus", "Error =>" + e.message)
            e.printStackTrace()
        }

        return "ok"

    }

    fun sendTextLCD(textData: String, textSize: Int, textFill: Boolean): String? {
        try {
            lcdApi?.showText(textData,textSize,textFill);
        }catch (e: SdkException){
            Log.d("sunmi_printer_plus", "Error =>" + e.message)
            e.printStackTrace()
        }
    return  "ok"
    }

    fun showDigital(digitalData: String): String? {
        try {
            lcdApi?.showDigital(digitalData)
        }catch (e: SdkException){
            Log.d("sunmi_printer_plus", "Error =>" + e.message)
            e.printStackTrace()
        }
        return  "ok"
    }

    fun sendImageLCD(bitmap: Bitmap): String? {
        try {
            lcdApi?.showBitmap(bitmap)
        }catch (e: SdkException){
            Log.d("sunmi_printer_plus", "Error =>" + e.message)
            e.printStackTrace()
        }
        return  "ok"
    }

}