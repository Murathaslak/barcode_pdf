import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_pdf/model/invoice_model.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io' as file;

class PdfPreviewPage extends StatefulWidget {
  final Invoice invoice;
  PdfPreviewPage({Key? key, required this.invoice}) : super(key: key);

  @override
  State<PdfPreviewPage> createState() => _PdfPreviewPageState();
}

class _PdfPreviewPageState extends State<PdfPreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(widget.invoice),
      ),
    );
  }
}

Future<Uint8List> makePdf(Invoice invoice) async {
  String svgRaw = await rootBundle.loadString('assets/images/logo.svg');
  final svgImage = pw.SvgImage(svg: svgRaw);

  final pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Column(
        children: [
          svgImage,
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                children: [
                  pw.Text("Attention to: ${invoice.customer}"),
                  pw.Text(invoice.address),
                ],
                crossAxisAlignment: pw.CrossAxisAlignment.start,
              ),
            ],
          ),
          pw.Text('Hello World!'),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.black),
            children: [
              // The first row just contains a phrase 'INVOICE FOR PAYMENT'
              pw.TableRow(
                children: [
                  pw.Padding(
                    child: pw.Text(
                      'INVOICE FOR PAYMENT',
                    ),
                    padding: pw.EdgeInsets.all(20),
                  ),
                ],
              ),
              // The remaining rows contain each item from the invoice, and uses the
              // map operator (the ...) to include these items in the list
              ...invoice.items.map(
                // Each new line item for the invoice should be rendered on a new TableRow
                (e) => pw.TableRow(
                  children: [
                    // We can use an Expanded widget, and use the flex parameter to specify
                    // how wide this particular widget should be. With a flex parameter of
                    // 2, the description widget will be 66% of the available width.
                    pw.Expanded(
                      child: pw.Text(e.description),
                      flex: 2,
                    ),
                    // Again, with a flex parameter of 1, the cost widget will be 33% of the
                    // available width.
                    pw.Expanded(
                      child: pw.Text("\$${e.cost}"),
                      flex: 1,
                    )
                  ],
                ),
              ),
              // After the itemized breakdown of costs, show the tax amount for this invoice
              // In this case, it's just 10% of the invoice amount
              pw.TableRow(
                children: [
                  pw.Text(
                      '\$${(invoice.totalCost() * 0.1).toStringAsFixed(2)}'),
                ],
              ),
              // Show the total
              pw.TableRow(
                children: [
                  pw.Text("\$${invoice.totalCost()}"),
                ],
              )
            ],
          ),
          pw.Padding(
            child: pw.Text(
              "THANK YOU FOR YOUR BUSINESS!",
            ),
            padding: pw.EdgeInsets.all(20),
          ),
        ],
      ),
    ),
  );
  return pdf.save();
}

//  Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           children: [
//             Text("Attention to: ${invoice.customer}"),
//             Text(invoice.address),
//           ],
//           crossAxisAlignment: CrossAxisAlignment.start,
//         ),
//         SizedBox(
//           height: 150,
//           width: 150,
//           child: Image(image: imageLogo),
//         )
//       ],
//     ),
