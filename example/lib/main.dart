import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_barcode_style.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_qrcode_style.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_text_style.dart';
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
                          await printerController.lineWrap(times: 2);
                        },
                        child: const Text("lineWrap"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await printerController.cutPaper();
                        },
                        child: const Text("Move page exit or cut (if cutter)"),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Print text'),
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      OutlinedButton(
                        onPressed: () async {
                          await printerController.printText(
                            sunmiText: SunmiText(
                              text: 'I love flutter',
                              style: SunmiTextStyle(
                                align: SunmiPrintAlign.LEFT,
                              ),
                            ),
                          );
                        },
                        child: const Text("Aligned Left"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await printerController.printText(
                            sunmiText: SunmiText(
                              text: 'I love flutter',
                              style: SunmiTextStyle(
                                align: SunmiPrintAlign.RIGHT,
                              ),
                            ),
                          );
                        },
                        child: const Text("Aligned Right"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await printerController.printText(
                            sunmiText: SunmiText(
                              text: 'I love flutter',
                              style: SunmiTextStyle(bold: true),
                            ),
                          );
                        },
                        child: const Text("Bold"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await printerController.printText(
                            sunmiText: SunmiText(
                              text: 'I love flutter',
                              style: SunmiTextStyle(reverse: true),
                            ),
                          );
                        },
                        child: const Text("Reversed (Black/White)"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await printerController.printText(
                            sunmiText: SunmiText(
                              text: 'I love flutter',
                            ),
                          );
                        },
                        child: const Text("Print text (No style)"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await printerController.printText(
                            sunmiText: SunmiText(
                                text: 'I love flutter',
                                style: SunmiTextStyle(
                                  fontSize: 1,
                                )),
                          );
                        },
                        child: const Text("Smaller font possible"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await printerController.printText(
                            sunmiText: SunmiText(
                                text: 'Flutter',
                                style: SunmiTextStyle(
                                  fontSize: 96,
                                )),
                          );
                        },
                        child: const Text("Biggest font possible"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await printerController.printText(
                            sunmiText: SunmiText(
                                text: 'Flutter',
                                style: SunmiTextStyle(
                                  fontSize: 96,
                                )),
                          );
                        },
                        child: const Text("Biggest font possible"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await printerController.addText(sunmiTexts: [
                            SunmiText(
                              text: 'I ',
                            ),
                            SunmiText(text: 'love ', style: SunmiTextStyle(bold: true, align: SunmiPrintAlign.CENTER)),
                            SunmiText(text: 'React ', style: SunmiTextStyle(strikethrough: true)),
                            SunmiText(text: 'Flutter ', style: SunmiTextStyle(fontSize: 50, underline: true, bold: true)),
                          ]);
                        },
                        child: const Text("Multiple formats"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await printerController.printRow(cols: [
                            SunmiColumn(
                              text: 'Name',
                              width: 2,
                            ),
                            SunmiColumn(
                              text: 'Qty',
                              width: 1,
                            ),
                            SunmiColumn(
                              text: 'UN',
                              width: 1,
                            ),
                            SunmiColumn(
                                text: 'TOT',
                                width: 2,
                                style: SunmiTextStyle(
                                  bold: true,
                                )),
                          ]);
                        },
                        child: const Text("Column"),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Print Image'),
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      OutlinedButton(
                        onPressed: () async {
                          final assetImage = await SunmiHelper.i.getImageFromAsset('assets/images/dash.jpeg');
                          await printerController.printImage(image: assetImage);
                        },
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Image.asset(
                              'assets/images/dash.jpeg',
                              width: 50,
                            ),
                            const Text("Print from asset"),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          String url = 'https://avatars.githubusercontent.com/u/14101776?s=100';
                          // convert image to Uint8List format
                          Uint8List assetImage = (await NetworkAssetBundle(Uri.parse(url)).load(url)).buffer.asUint8List();
                          await printerController.printImage(
                            image: assetImage,
                            align: SunmiPrintAlign.CENTER,
                          );
                        },
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Image.network('https://avatars.githubusercontent.com/u/14101776?s=50'),
                            const Text("Print from web (center)"),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Command Printer'),
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      OutlinedButton(
                        onPressed: () async {
                          final escPos = await printerController.customEscPos();
                          await printerController.printEscPos(data: escPos);
                        },
                        child: const Text("Print Escpos"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          const tspl = "! 0 200 200 400 1\nTEXT 100 100 \"3\" \"Hello, TSPL!\"\nPRINT\n";
                          await printerController.printTSPL(data: tspl);
                        },
                        child: const Text("Print TSPL (Label printer only)"),
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
