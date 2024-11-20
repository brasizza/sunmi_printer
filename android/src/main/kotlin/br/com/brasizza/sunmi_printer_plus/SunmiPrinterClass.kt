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
import com.sunmi.printerx.enums.PrinterInfo
import com.sunmi.printerx.style.AreaStyle
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
            lineApi?.printText(printerArgument!!["text"] as String?, TextStyle.getStyle());
        } catch (e: SdkException) {
            Log.d("sunmi_printer_plus", "Error =>" + e.message)
            e.printStackTrace()
        }

        return "ok";


    }

    fun printQrcode(qrcodeArgument: Map<String, Any>?): String? {
        try {
            lineApi?.printQrCode(qrcodeArgument!!["text"] as String?, QrStyle.getStyle());
        } catch (e: SdkException) {
            Log.d("sunmi_printer_plus", "Error =>" + e.message)
            e.printStackTrace()
        }

        return "ok";
    }


}