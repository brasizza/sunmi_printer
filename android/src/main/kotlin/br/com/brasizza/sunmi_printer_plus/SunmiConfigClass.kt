package br.com.brasizza.sunmi_printer_plus

import android.content.Context
import android.util.Log
import com.sunmi.printerx.PrinterSdk
import com.sunmi.printerx.PrinterSdk.Printer
import com.sunmi.printerx.api.QueryApi
import com.sunmi.printerx.enums.PrinterInfo

class SunmiConfigClass( private  val printer: Printer?)  {
    private var queryApi = printer!!.queryApi();

    fun getStatus(): String {
        return  queryApi!!.status.toString()

    }

    fun getVersion(): String {
        return queryApi!!.getInfo(PrinterInfo.VERSION).toString()
    }

    fun getPaper(): String {
        return queryApi!!.getInfo(PrinterInfo.PAPER).toString()

    }

    fun getId(): String {
        return queryApi!!.getInfo(PrinterInfo.ID).toString()

    }

    fun getType(): String {
        return queryApi?.getInfo(PrinterInfo.TYPE).toString()

    }
}

