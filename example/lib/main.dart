import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sunmi_printer_plus/core/enums/enums.dart';
import 'package:sunmi_printer_plus/core/helpers/sunmi_helper.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_barcode_style.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_qrcode_style.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_text_style.dart';
import 'package:sunmi_printer_plus/core/types/sunmi_column.dart';
import 'package:sunmi_printer_plus/core/types/sunmi_text.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus_example/src/cash_drawer.dart';
import 'package:sunmi_printer_plus_example/src/lcd_controller.dart';
import 'package:sunmi_printer_plus_example/src/printer_controller.dart';
import 'package:sunmi_printer_plus_example/src/status_controller.dart';

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
  String cashDrawerStatus = "Close";
  late final PrinterController printerController;
  late final StatusController statusController;
  late final LcdController lcdController;
  late final CashDrawer cashDrawer;

  @override
  void initState() {
    final SunmiPrinterPlus sunmiPrinterPlus = SunmiPrinterPlus();

    printerController = PrinterController(printer: sunmiPrinterPlus);
    statusController = StatusController(printer: sunmiPrinterPlus);
    lcdController = LcdController(printer: sunmiPrinterPlus);
    cashDrawer = CashDrawer(printer: sunmiPrinterPlus);
    super.initState();
    Future.delayed(const Duration(milliseconds: 0)).then((_) {
      Future.wait([
        statusController.getVersion(),
        statusController.getPaper(),
        statusController.getId(),
        statusController.getType(),
        statusController.getStatus(),
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
    });
    // Run all futures in parallel
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
                          final status = await statusController.getStatus();
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
                          await printerController.printQRCode(
                            "I love flutter",
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
                            style: SunmiBarcodeStyle(
                                align: SunmiPrintAlign.RIGHT,
                                height: 100,
                                size: 2,
                                type: SunmiBarcodeType.CODABAR,
                                textPos: SunmiBarcodeTextPos.NO_TEXT),
                          );
                        },
                        child: const Text("Barcode"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await printerController.line(
                              style: SunmiPrintLine.SOLID);
                        },
                        child: const Text("Print Line"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await printerController.lineWrap(2);
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
                          await printerController.printCustomText(
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
                          await printerController.printCustomText(
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
                          await printerController.printCustomText(
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
                          await printerController.printCustomText(
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
                          await printerController.printCustomText(
                            sunmiText: SunmiText(
                              text: 'I love flutter',
                            ),
                          );
                        },
                        child: const Text("Print text (No style)"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await printerController.printCustomText(
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
                          await printerController.printCustomText(
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
                          await printerController.printCustomText(
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
                            SunmiText(
                                text: 'love ',
                                style: SunmiTextStyle(
                                    bold: true, align: SunmiPrintAlign.CENTER)),
                            SunmiText(
                                text: 'React ',
                                style: SunmiTextStyle(strikethrough: true)),
                            SunmiText(
                                text: 'Flutter ',
                                style: SunmiTextStyle(
                                    fontSize: 50, underline: true, bold: true)),
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
                      OutlinedButton(
                        onPressed: () async {
                          await printerController.printText('Payment receipt',
                              style: SunmiTextStyle(
                                bold: true,
                                align: SunmiPrintAlign.CENTER,
                              ));
                          await printerController.line();
                          await printerController.lineWrap(2);

                          await printerController.printRow(cols: [
                            SunmiColumn(
                              text: 'Name',
                              width: 12,
                            ),
                            SunmiColumn(
                              text: 'Qty',
                              width: 6,
                            ),
                            SunmiColumn(
                              text: 'UN',
                              width: 6,
                            ),
                            SunmiColumn(
                              text: 'TOT',
                              width: 6,
                            ),
                          ]);

                          await printerController.printRow(cols: [
                            SunmiColumn(
                              text: 'Fries',
                              width: 12,
                            ),
                            SunmiColumn(
                              text: '4x',
                              width: 6,
                            ),
                            SunmiColumn(
                              text: '3.00',
                              width: 6,
                            ),
                            SunmiColumn(
                              text: '12.00',
                              width: 6,
                            ),
                          ]);

                          await printerController.printRow(cols: [
                            SunmiColumn(
                              text: 'Strawberry',
                              width: 12,
                            ),
                            SunmiColumn(
                              text: '1x',
                              width: 6,
                            ),
                            SunmiColumn(
                              text: '24.44',
                              width: 6,
                            ),
                            SunmiColumn(
                              text: '24.44',
                              width: 6,
                            ),
                          ]);

                          await printerController.printRow(cols: [
                            SunmiColumn(
                              text: 'Soda',
                              width: 12,
                            ),
                            SunmiColumn(
                              text: '1x',
                              width: 6,
                            ),
                            SunmiColumn(
                              text: '1.99',
                              width: 6,
                            ),
                            SunmiColumn(
                              text: '1.99',
                              width: 6,
                            ),
                          ]);

                          await printerController.line();
                          await printerController.printRow(cols: [
                            SunmiColumn(
                              text: 'TOTAL',
                              width: 25,
                            ),
                            SunmiColumn(
                              text: '38.43',
                              width: 5,
                            ),
                          ]);

                          await printerController.printRow(cols: [
                            SunmiColumn(
                              text: 'ARABIC TEXT',
                              width: 15,
                            ),
                            SunmiColumn(
                              text: 'اسم المشترك',
                              width: 15,
                            ),
                          ]);

                          await printerController.printRow(cols: [
                            SunmiColumn(
                              text: 'اسم المشترك',
                              width: 15,
                            ),
                            SunmiColumn(
                              text: 'اسم المشترك',
                              width: 15,
                            ),
                          ]);

                          await printerController.printRow(cols: [
                            SunmiColumn(
                              text: 'RUSSIAN TEXT',
                              width: 15,
                            ),
                            SunmiColumn(
                              text: 'Санкт-Петербу́рг',
                              width: 15,
                            ),
                          ]);
                          await printerController.printRow(cols: [
                            SunmiColumn(
                              text: 'Санкт-Петербу́рг',
                              width: 15,
                            ),
                            SunmiColumn(
                              text: 'Санкт-Петербу́рг',
                              width: 15,
                            ),
                          ]);

                          await printerController.printRow(cols: [
                            SunmiColumn(
                              text: 'CHINESE TEXT',
                              width: 15,
                            ),
                            SunmiColumn(
                              text: '風俗通義',
                              width: 15,
                            ),
                          ]);
                          await printerController.printRow(cols: [
                            SunmiColumn(
                              text: '風俗通義',
                              width: 15,
                            ),
                            SunmiColumn(
                              text: '風俗通義',
                              width: 15,
                            ),
                          ]);

                          await printerController.printText(
                              'Transaction\'s Qrcode',
                              style: SunmiTextStyle(
                                align: SunmiPrintAlign.CENTER,
                                bold: true,
                                fontSize: 30,
                              ));
                          await printerController.printQRCode(
                              'https://github.com/brasizza/sunmi_printer');
                          await printerController.lineWrap(2);
                        },
                        child: const Text("Receipt builder (No ESC-POS)"),
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
                          final assetImage =
                              await SunmiHelper.getImageFromAsset(
                                  'assets/images/dash.jpeg');
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
                          String url =
                              'https://avatars.githubusercontent.com/u/14101776?s=100';
                          // convert image to Uint8List format
                          Uint8List assetImage =
                              (await NetworkAssetBundle(Uri.parse(url))
                                      .load(url))
                                  .buffer
                                  .asUint8List();
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
                            Image.network(
                                'https://avatars.githubusercontent.com/u/14101776?s=50'),
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
                          const tspl =
                              "! 0 200 200 400 1\nTEXT 100 100 \"3\" \"Hello, TSPL!\"\nPRINT\n";
                          await printerController.printTSPL(data: tspl);
                        },
                        child: const Text("Print TSPL (Label printer only)"),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child:
                        Text('LCD COMMAND (If apliacable  T1 MINI, T2 MINI)'),
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      OutlinedButton(
                        onPressed: () async {
                          await lcdController.config(
                              status: SunmiLCDStatus.INIT);
                        },
                        child: const Text("Init LCD"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await lcdController.config(
                              status: SunmiLCDStatus.SLEEP);
                        },
                        child: const Text("Sleep LCD"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await lcdController.config(
                              status: SunmiLCDStatus.WAKE);
                        },
                        child: const Text("Sleep WAKE UP"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await lcdController.config(
                              status: SunmiLCDStatus.CLEAR);
                        },
                        child: const Text("Clear LCD"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await lcdController.sendTextLCD('I love flutter',
                              size: 10, fill: false);
                        },
                        child: const Text("Insert text"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          await lcdController.showDigital('122.90');
                        },
                        child: const Text(
                            "LCD Price (7 digits from 0 to 9 and “.”)"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          final assetImage =
                              await SunmiHelper.getImageFromAsset(
                                  'assets/images/dash.jpeg');

                          await lcdController.lcdImage(image: assetImage);
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
                            const Text("Send to LCD"),
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
                    child: Text('Cash Drawers (if avaliable)'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Cash Drawers is  $cashDrawerStatus'),
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      OutlinedButton(
                        onPressed: () async {
                          await cashDrawer.openDrawer();
                        },
                        child: const Text("Open drawer"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          final statusDrawer = await cashDrawer.isDrawerOpen();
                          if (statusDrawer) {
                            setState(() {
                              cashDrawerStatus = "Open";
                            });
                          } else {
                            setState(() {
                              cashDrawerStatus = "Close";
                            });
                          }
                        },
                        child: const Text("Check if open"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
