import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:sunmi_printer/sunmi_printer.dart';

void main() {
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
  late PrinterStatus _printerStatus;
  late PrinterMode _printerMode;

  @override
  void initState() {
    super.initState();

    _bindingPrinter().then((bool? isBind) async => {
          if (isBind!)
            {
              _getPrinterStatus(),
              _printerMode = await _getPrinterMode(),
            }
        });
  }

  /// must binding ur printer at first init in app
  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }

  /// you can get printer status
  Future<void> _getPrinterStatus() async {
    final PrinterStatus result = await SunmiPrinter.getPrinterStatus();
    setState(() {
      _printerStatus = result;
    });
  }

  Future<PrinterMode> _getPrinterMode() async {
    final PrinterMode mode = await SunmiPrinter.getPrinterMode();
    return mode;
  }

  Future<void> _printLabel(Uint8List img) async {
    // must start with this function if you are print with label
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.printText("ASDASDASDASDASD");
    await SunmiPrinter.setAlignment(PrintAlign.LEFT);
    await SunmiPrinter.printText("ASDASDASDASDASD");

    await SunmiPrinter.printText("ASDASDASDASDASD");
    await SunmiPrinter.setAlignment(PrintAlign.RIGHT);
    await SunmiPrinter.printText("ASDASDASDASDASD");
    await SunmiPrinter.lineWrap(6);
    await SunmiPrinter.setAlignment(PrintAlign.CENTER);
    await SunmiPrinter.printImage(img);
    await SunmiPrinter.lineWrap(6);

    await SunmiPrinter.submitTransactionPrint();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pingspace Demo Printer'),
        ),
        body: Column(
          children: [
            GestureDetector(
                onTap: () async {
                  String url = 'https://upload.wikimedia.org/wikipedia/pt/thumb/b/b4/Corinthians_simbolo.png/120px-Corinthians_simbolo.png';
                  // convert image to Uint8List format
                  Uint8List byte = (await NetworkAssetBundle(Uri.parse(url)).load(url)).buffer.asUint8List();

                  await _printLabel(byte);
                },
                child: Container(color: Colors.red, width: 200, height: 100, child: const Text('Print Label'))),
            GestureDetector(child: const Text('Example only')),
          ],
        ));
  }
}
