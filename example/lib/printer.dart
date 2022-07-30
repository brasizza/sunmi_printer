import 'dart:typed_data';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sunmi_printer_plus/column_maker.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'dart:async';

import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeRight]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sunmi Printer',
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        debugShowCheckedModeBanner: false,
        home: const Home());
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool printBinded = false;
  int paperSize = 0;
  String serialNumber = "";
  String printerVersion = "";
  @override
  void initState() {
    super.initState();

    _bindingPrinter().then((bool? isBind) async {
      SunmiPrinter.paperSize().then((int size) {
        setState(() {
          paperSize = size;
        });
      });

      SunmiPrinter.printerVersion().then((String version) {
        setState(() {
          printerVersion = version;
        });
      });

      SunmiPrinter.serialNumber().then((String serial) {
        setState(() {
          serialNumber = serial;
        });
      });

      setState(() {
        printBinded = isBind!;
      });
    });
  }

  /// must binding ur printer at first init in app
  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sunmi printer Example'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: Text("Print binded: " + printBinded.toString()),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text("Paper size: " + paperSize.toString()),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text("Serial number: " + serialNumber),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text("Printer version: " + printerVersion),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();
                          await SunmiPrinter.startTransactionPrint(true);
                          await SunmiPrinter.printQRCode(
                              'https://github.com/brasizza/sunmi_printer');
                          await SunmiPrinter.lineWrap(2);
                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Print qrCode')),
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();
                          await SunmiPrinter.startTransactionPrint(true);
                          await SunmiPrinter.printBarCode('1234567890',
                              barcodeType: SunmiBarcodeType.CODE128,
                              textPosition: SunmiBarcodeTextPos.TEXT_UNDER,
                              height: 20);
                          await SunmiPrinter.lineWrap(2);
                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Print barCode')),
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();
                          await SunmiPrinter.startTransactionPrint(true);
                          await SunmiPrinter.line();
                          await SunmiPrinter.lineWrap(2);
                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Print line')),
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.lineWrap(2);
                        },
                        child: const Text('Wrap line')),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();
                          await SunmiPrinter.startTransactionPrint(true);
                          await SunmiPrinter.printText('Hello I\'m bold',
                              style: SunmiStyle(bold: true));
                          await SunmiPrinter.lineWrap(2);
                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Bold Text')),
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();
                          await SunmiPrinter.startTransactionPrint(true);
                          await SunmiPrinter.printText('Very small!',
                              style: SunmiStyle(fontSize: SunmiFontSize.XS));
                          await SunmiPrinter.lineWrap(2);

                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Very small font')),
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();
                          await SunmiPrinter.startTransactionPrint(true);
                          await SunmiPrinter.printText('Very small!',
                              style: SunmiStyle(fontSize: SunmiFontSize.SM));
                          await SunmiPrinter.lineWrap(2);
                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Small font')),
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();
                          await SunmiPrinter.startTransactionPrint(true);
                          await SunmiPrinter.printText('Normal font',
                              style: SunmiStyle(fontSize: SunmiFontSize.MD));

                          await SunmiPrinter.lineWrap(2);
                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Normal font')),
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();
                          await SunmiPrinter.printText('Large font',
                              style: SunmiStyle(fontSize: SunmiFontSize.LG));

                          await SunmiPrinter.lineWrap(2);
                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Large font')),
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();
                          await SunmiPrinter.startTransactionPrint(true);
                          await SunmiPrinter.setFontSize(SunmiFontSize.XL);
                          await SunmiPrinter.printText('Very Large font!');
                          await SunmiPrinter.resetFontSize();
                          await SunmiPrinter.lineWrap(2);
                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Very large font')),
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();
                          await SunmiPrinter.startTransactionPrint(true);
                          await SunmiPrinter.setCustomFontSize(13);
                          await SunmiPrinter.printText('Very Large font!');
                          await SunmiPrinter.resetFontSize();
                          await SunmiPrinter.lineWrap(2);
                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Custom size font')),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();
                          await SunmiPrinter.startTransactionPrint(true);
                          await SunmiPrinter.printText('Align right',
                              style: SunmiStyle(align: SunmiPrintAlign.RIGHT));
                          await SunmiPrinter.lineWrap(2);
                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Align right')),
                    ElevatedButton(
                        onPressed: () async {
                          await SunmiPrinter.initPrinter();

                          await SunmiPrinter.startTransactionPrint(true);
                          await SunmiPrinter.printText('Align left',
                              style: SunmiStyle(align: SunmiPrintAlign.LEFT));

                          await SunmiPrinter.lineWrap(2);
                          await SunmiPrinter.exitTransactionPrint(true);
                        },
                        child: const Text('Align left')),
                    ElevatedButton(
                      onPressed: () async {
                        await SunmiPrinter.initPrinter();

                        await SunmiPrinter.startTransactionPrint(true);
                        await SunmiPrinter.printText(
                          'Align center/ LARGE TEXT AND BOLD',
                          style: SunmiStyle(
                              align: SunmiPrintAlign.CENTER,
                              bold: true,
                              fontSize: SunmiFontSize.LG),
                        );

                        await SunmiPrinter.lineWrap(2);
                        await SunmiPrinter.exitTransactionPrint(true);
                      },
                      child: const Text('Align center'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await SunmiPrinter.initPrinter();

                        Uint8List byte =
                            await _getImageFromAsset('assets/images/dash.jpeg');
                        await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);

                        await SunmiPrinter.startTransactionPrint(true);
                        await SunmiPrinter.printImage(byte);
                        await SunmiPrinter.lineWrap(2);
                        await SunmiPrinter.exitTransactionPrint(true);
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/dash.jpeg',
                            width: 100,
                          ),
                          const Text('Print this image from asset!')
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await SunmiPrinter.initPrinter();

                        String url =
                            'https://avatars.githubusercontent.com/u/14101776?s=100';
                        // convert image to Uint8List format
                        Uint8List byte =
                            (await NetworkAssetBundle(Uri.parse(url)).load(url))
                                .buffer
                                .asUint8List();
                        await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
                        await SunmiPrinter.startTransactionPrint(true);
                        await SunmiPrinter.printImage(byte);
                        await SunmiPrinter.lineWrap(2);
                        await SunmiPrinter.exitTransactionPrint(true);
                      },
                      child: Column(
                        children: [
                          Image.network(
                              'https://avatars.githubusercontent.com/u/14101776?s=100'),
                          const Text('Print this image from WEB!')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            await SunmiPrinter.cut();
                          },
                          child: const Text('CUT PAPER')),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            await SunmiPrinter.initPrinter();

                            await SunmiPrinter.startTransactionPrint(true);
                            await SunmiPrinter.setAlignment(
                                SunmiPrintAlign.CENTER);
                            await SunmiPrinter.line();
                            await SunmiPrinter.printText('Payment receipt');
                            await SunmiPrinter.printText(
                                'Using the old way to bold!');
                            await SunmiPrinter.line();

                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(
                                  text: 'Name',
                                  width: 12,
                                  align: SunmiPrintAlign.LEFT),
                              ColumnMaker(
                                  text: 'Qty',
                                  width: 6,
                                  align: SunmiPrintAlign.CENTER),
                              ColumnMaker(
                                  text: 'UN',
                                  width: 6,
                                  align: SunmiPrintAlign.RIGHT),
                              ColumnMaker(
                                  text: 'TOT',
                                  width: 6,
                                  align: SunmiPrintAlign.RIGHT),
                            ]);

                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(
                                  text: 'Fries',
                                  width: 12,
                                  align: SunmiPrintAlign.LEFT),
                              ColumnMaker(
                                  text: '4x',
                                  width: 6,
                                  align: SunmiPrintAlign.CENTER),
                              ColumnMaker(
                                  text: '3.00',
                                  width: 6,
                                  align: SunmiPrintAlign.RIGHT),
                              ColumnMaker(
                                  text: '12.00',
                                  width: 6,
                                  align: SunmiPrintAlign.RIGHT),
                            ]);

                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(
                                  text: 'Strawberry',
                                  width: 12,
                                  align: SunmiPrintAlign.LEFT),
                              ColumnMaker(
                                  text: '1x',
                                  width: 6,
                                  align: SunmiPrintAlign.CENTER),
                              ColumnMaker(
                                  text: '24.44',
                                  width: 6,
                                  align: SunmiPrintAlign.RIGHT),
                              ColumnMaker(
                                  text: '24.44',
                                  width: 6,
                                  align: SunmiPrintAlign.RIGHT),
                            ]);

                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(
                                  text: 'Soda',
                                  width: 12,
                                  align: SunmiPrintAlign.LEFT),
                              ColumnMaker(
                                  text: '1x',
                                  width: 6,
                                  align: SunmiPrintAlign.CENTER),
                              ColumnMaker(
                                  text: '1.99',
                                  width: 6,
                                  align: SunmiPrintAlign.RIGHT),
                              ColumnMaker(
                                  text: '1.99',
                                  width: 6,
                                  align: SunmiPrintAlign.RIGHT),
                            ]);

                            await SunmiPrinter.line();
                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(
                                  text: 'TOTAL',
                                  width: 25,
                                  align: SunmiPrintAlign.LEFT),
                              ColumnMaker(
                                  text: '38.43',
                                  width: 5,
                                  align: SunmiPrintAlign.RIGHT),
                            ]);

                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(
                                  text: 'ARABIC TEXT',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                              ColumnMaker(
                                  text: 'اسم المشترك',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                            ]);

                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(
                                  text: 'اسم المشترك',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                              ColumnMaker(
                                  text: 'اسم المشترك',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                            ]);

                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(
                                  text: 'RUSSIAN TEXT',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                              ColumnMaker(
                                  text: 'Санкт-Петербу́рг',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                            ]);
                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(
                                  text: 'Санкт-Петербу́рг',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                              ColumnMaker(
                                  text: 'Санкт-Петербу́рг',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                            ]);

                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(
                                  text: 'CHINESE TEXT',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                              ColumnMaker(
                                  text: '風俗通義',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                            ]);
                            await SunmiPrinter.printRow(cols: [
                              ColumnMaker(
                                  text: '風俗通義',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                              ColumnMaker(
                                  text: '風俗通義',
                                  width: 15,
                                  align: SunmiPrintAlign.LEFT),
                            ]);

                            await SunmiPrinter.setAlignment(
                                SunmiPrintAlign.CENTER);
                            await SunmiPrinter.line();
                            await SunmiPrinter.bold();
                            await SunmiPrinter.printText(
                                'Transaction\'s Qrcode');
                            await SunmiPrinter.resetBold();
                            await SunmiPrinter.printQRCode(
                                'https://github.com/brasizza/sunmi_printer');
                            await SunmiPrinter.lineWrap(2);
                            await SunmiPrinter.exitTransactionPrint(true);
                          },
                          child: const Text('TICKET EXAMPLE')),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            final List<int> _escPos = await _customEscPos();
                            await SunmiPrinter.initPrinter();
                            await SunmiPrinter.startTransactionPrint(true);
                            await SunmiPrinter.printRawData(
                                Uint8List.fromList(_escPos));
                            await SunmiPrinter.exitTransactionPrint(true);
                          },
                          child: const Text('Custom ESC/POS to print')),
                    ]),
              ),
            ],
          ),
        ));
  }
}

Future<Uint8List> readFileBytes(String path) async {
  ByteData fileData = await rootBundle.load(path);
  Uint8List fileUnit8List = fileData.buffer
      .asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
  return fileUnit8List;
}

Future<Uint8List> _getImageFromAsset(String iconPath) async {
  return await readFileBytes(iconPath);
}

Future<List<int>> _customEscPos() async {
  final profile = await CapabilityProfile.load();
  final generator = Generator(PaperSize.mm58, profile);
  List<int> bytes = [];

  bytes += generator.text(
      'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
  bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
      styles: const PosStyles(codeTable: 'CP1252'));
  bytes += generator.text('Special 2: blåbærgrød',
      styles: const PosStyles(codeTable: 'CP1252'));

  bytes += generator.text('Bold text', styles: const PosStyles(bold: true));
  bytes +=
      generator.text('Reverse text', styles: const PosStyles(reverse: true));
  bytes += generator.text('Underlined text',
      styles: const PosStyles(underline: true), linesAfter: 1);
  bytes += generator.text('Align left',
      styles: const PosStyles(align: PosAlign.left));
  bytes += generator.text('Align center',
      styles: const PosStyles(align: PosAlign.center));
  bytes += generator.text('Align right',
      styles: const PosStyles(align: PosAlign.right), linesAfter: 1);
  bytes += generator.qrcode('Barcode by escpos',
      size: QRSize.Size4, cor: QRCorrection.H);
  bytes += generator.feed(2);

  bytes += generator.row([
    PosColumn(
      text: 'col3',
      width: 3,
      styles: const PosStyles(align: PosAlign.center, underline: true),
    ),
    PosColumn(
      text: 'col6',
      width: 6,
      styles: const PosStyles(align: PosAlign.center, underline: true),
    ),
    PosColumn(
      text: 'col3',
      width: 3,
      styles: const PosStyles(align: PosAlign.center, underline: true),
    ),
  ]);

  bytes += generator.text('Text size 200%',
      styles: const PosStyles(
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ));

  bytes += generator.reset();
  bytes += generator.cut();

  return bytes;
}
