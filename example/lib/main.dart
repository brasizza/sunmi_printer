import 'package:flutter/material.dart';
import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_barcode_style.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_qrcode_style.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus_example/src/printer_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PrinterStatus statusPrinter = PrinterStatus.UNKNOWN;
  String version = "";
  String idPrinter = "";
  String paperPrinter = "";
  String typePrinter = "";
  final PrinterController printerController = PrinterController(printer: SunmiPrinterPlus());

  @override
  void initState() {
    super.initState();

    // Run all futures in parallel
    Future.wait([
      printerController.getVersion(),
      printerController.getPaper(),
      printerController.getId(),
      printerController.getType(),
      printerController.getStatus(),
    ]).then((results) {
      setState(() {
        // Unwrap the results into corresponding variables
        version = results[0].toString();
        paperPrinter = results[1].toString();
        idPrinter = results[2].toString();
        typePrinter = results[3].toString();
        statusPrinter = results[4] as PrinterStatus;
      });
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Sunmi printer example')),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Text("Version:  $version"),
                  Row(children: [
                    OutlinedButton(
                        onPressed: () async {
                          final status = await printerController.getStatus();
                          setState(() {
                            statusPrinter = status;
                          });
                        },
                        child: const Icon(Icons.refresh)),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("Printer Status : ${statusPrinter.name}"),
                  ]),
                  const Divider(),
                  Text("Printer ID : $idPrinter"),
                  Text("Printer Paper : $paperPrinter"),
                  Text("Printer Type : $typePrinter"),
                  const Divider(),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      OutlinedButton(
                        onPressed: () async {
                          await printerController.printQrcode(
                            text: "I love flutter",
                            style: SunmiQrcodeStyle(
                              align: SunmiPrintAlign.LEFT,
                              errorLevel: SunmiQrcodeLevel.LEVEL_H,
                              qrcodeSize: 3,
                            ),
                          );
                        },
                        child: const Text("Qrcode"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await printerController.printBarcode(
                            text: "1234567890",
                            style: SunmiBarcodeStyle(align: SunmiPrintAlign.RIGHT, height: 100, size: 2, type: SunmiBarcodeType.CODABAR, textPos: SunmiBarcodeTextPos.NO_TEXT),
                          );
                        },
                        child: const Text("Barcode"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await printerController.line(style: SunmiPrintLine.SOLID);
                        },
                        child: const Text("Print Line"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await printerController.printText(text: "I love flutter");
                        },
                        child: const Text("Print text (No style)"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
