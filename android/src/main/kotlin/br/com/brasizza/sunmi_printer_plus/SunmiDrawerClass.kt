package br.com.brasizza.sunmi_printer_plus

import com.sunmi.printerx.PrinterSdk.Printer

class SunmiDrawerClass(private  val printer: Printer?) {


    private var cashDrawerApi = printer!!.cashDrawerApi();

    fun openDrawer(): String? {
        cashDrawerApi.open(null);
        return  "OK";
    }

    fun isDrawerOpen(): Boolean {
        return cashDrawerApi.isOpen
    }


}