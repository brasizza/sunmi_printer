package br.com.brasizza.sunmi_printer_plus

import android.content.Context
import android.util.Log
import com.sunmi.printerx.PrinterSdk
import com.sunmi.printerx.PrinterSdk.PrinterListen
import com.sunmi.printerx.SdkException

class SunmiInitClass(private val context: Context) {
    var selectPrinter: PrinterSdk.Printer? = null

    fun initPrinter(callback: (PrinterSdk.Printer?) -> Unit) {
        Log.d("sunmi_printer_plus", "initPrinter")
        try {
            PrinterSdk.getInstance().getPrinter(context, object : PrinterListen {
                override fun onDefPrinter(printer: PrinterSdk.Printer) {
                    selectPrinter = printer
                    Log.d("sunmi_printer_plus", "Printer finded")
                    callback(printer) // Return the printer via the callback
                }

                override fun onPrinters(printers: List<PrinterSdk.Printer>) {
                    // You can also handle multiple printers if needed
                }
            })
        } catch (e: SdkException) {
            Log.d("sunmi_printer_plus", "Error =>" + e.message)
            e.printStackTrace()
            callback(null) // Return null in case of an error
        }
    }
}
