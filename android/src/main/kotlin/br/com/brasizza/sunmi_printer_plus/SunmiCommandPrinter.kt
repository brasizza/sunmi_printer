package br.com.brasizza.sunmi_printer_plus

import com.sunmi.printerx.PrinterSdk.Printer

class SunmiCommandPrinter(private  val printer: Printer?) {
    private var commandApi = printer?.commandApi();

    fun printEscPos(escArgument: ByteArray?): String {
        commandApi?.sendEscCommand(escArgument);
        return "ok"
    }

    fun printTSPL(tsplArgument: ByteArray): String {
        commandApi?.sendTsplCommand(tsplArgument);
        return "ok"
    }


}