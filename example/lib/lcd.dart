import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'dart:async';

import 'main.dart';

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
        title: 'Sunmi LCD',
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

  @override
  void initState() {
    super.initState();

    _bindingPrinter().then((bool? isBind) async {
      setState(() {
        printBinded = isBind ?? false;
      });
    });
  }

  /// must binding printer for LCD at first init in app
  Future<bool?> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sunmi LCD Example'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Text("LCD binded: " + printBinded.toString()),
          ),
          const Divider(),
          Expanded(
            child: GridView.extent(
              maxCrossAxisExtent: 160,
              padding: const EdgeInsets.all(24),
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              children: [
                _buildButton(
                  context,
                  labels: ['Initialize LCD'],
                  onPressed: () async {
                    await SunmiPrinter.lcdInitialize();
                  },
                ),
                _buildButton(
                  context,
                  labels: ['Wakeup LCD'],
                  onPressed: () async {
                    await SunmiPrinter.lcdWakeup();
                  },
                ),
                _buildButton(
                  context,
                  labels: ['Sleep LCD'],
                  onPressed: () async {
                    await SunmiPrinter.lcdSleep();
                  },
                ),
                _buildButton(
                  context,
                  labels: ['Clear LCD'],
                  onPressed: () async {
                    await SunmiPrinter.lcdClear();
                  },
                ),
                _buildButton(
                  context,
                  labels: ['LCD Single Line'],
                  onPressed: () async {
                    await SunmiPrinter.lcdString('Hello');
                  },
                ),
                _buildButton(
                  context,
                  labels: ['LCD Double Lines'],
                  onPressed: () async {
                    await SunmiPrinter.lcdDoubleString('Hello', 'World');
                  },
                ),
                _buildButton(
                  context,
                  labels: ['LCD Bitmap', '128x40'],
                  onPressed: () async {
                    Uint8List byte =
                        await readFileBytes('assets/images/128x40.png');
                    await SunmiPrinter.lcdImage(byte);
                  },
                ),
                _buildButton(
                  context,
                  labels: ['LCD Bitmap', '16x16'],
                  onPressed: () async {
                    Uint8List byte =
                        await readFileBytes('assets/images/16x16.png');
                    await SunmiPrinter.lcdImage(byte);
                  },
                ),
                _buildButton(
                  context,
                  labels: ['LCD Bitmap', 'dash.jpeg', 'But no fit.'],
                  onPressed: () async {
                    Uint8List byte =
                        await readFileBytes('assets/images/dash.jpeg');
                    await SunmiPrinter.lcdImage(byte);
                  },
                ),
                _buildButton(
                  context,
                  labels: ['Fill String', '32px, fill=false'],
                  onPressed: () async {
                    await SunmiPrinter.lcdFillString('Size32',
                        size: 32, fill: false);
                  },
                ),
                _buildButton(
                  context,
                  labels: ['Fill String', '16px, fill=true'],
                  onPressed: () async {
                    await SunmiPrinter.lcdFillString('abcDEFgj0123\$&=+',
                        size: 16, fill: true);
                  },
                ),
                _buildButton(
                  context,
                  labels: ['Fill String', '64px, fill=true'],
                  onPressed: () async {
                    await SunmiPrinter.lcdFillString('64px',
                        size: 64, fill: true);
                  },
                ),
                _buildButton(
                  context,
                  labels: ['Multi String', '2 flex lines.'],
                  onPressed: () async {
                    await SunmiPrinter.lcdMultiString([
                      'Welcome to flutter.',
                      'Align 2.',
                    ], [
                      1,
                      2,
                    ]);
                  },
                ),
                _buildButton(
                  context,
                  labels: ['Multi String', '3 flex lines.'],
                  onPressed: () async {
                    await SunmiPrinter.lcdMultiString([
                      'This line has align 1.',
                      'Align 2.',
                      'This line has align 1.',
                    ], [
                      1,
                      2,
                      1
                    ]);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {required List<String> labels, required VoidCallback onPressed}) {
    return ElevatedButton(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: labels.map((l) => Text(l)).toList(),
      ),
      onPressed: onPressed,
    );
  }
}
