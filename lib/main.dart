import 'package:flutter/material.dart';
import 'package:flutter_barcode_pdf/screen/barcode/qr_generate_screen.dart';
import 'package:flutter_barcode_pdf/screen/barcode/qr_scan_screen.dart';
import 'package:flutter_barcode_pdf/screen/screentopdf/invoices.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qr Code Kullanımı',
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QrGenerateScreen())),
              child: Text("Qr Code Üret"),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Colors.red[700]),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QrScanScreen()),
              ),
              child: Text("Qr Code Tarat"),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Colors.red[700]),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InvoicesScreen()),
              ),
              child: Text("Screen To Pdf"),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Colors.red[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
