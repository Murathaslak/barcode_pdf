import 'package:flutter/material.dart';
import 'package:flutter_barcode_pdf/model/invoice_model.dart';
import 'package:flutter_barcode_pdf/screen/screentopdf/invoices_detail.dart';

class InvoicesScreen extends StatefulWidget {
  InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  final invoices = [
    Invoice(
        'David Thomas',
        '123 Fake St\r\nBermuda Triangle',
        [
          LineItem(
            'Technical Engagement',
            120,
          ),
          LineItem('Deployment Assistance', 200),
          LineItem('Develop Software Solution', 3020.45),
          LineItem('Produce Documentation', 840.50),
        ],
        'Create and deploy software package'),
    Invoice(
      'Michael Ambiguous',
      '82 Unsure St\r\nBaggle Palace',
      [
        LineItem('Professional Advice', 100),
        LineItem('Lunch Bill', 43.55),
        LineItem('Remote Assistance', 50),
      ],
      'Provide remote support after lunch',
    ),
    Invoice(
      'Marty McDanceFace',
      '55 Dancing Parade\r\nDance Place',
      [
        LineItem('Program the robots', 400.50),
        LineItem('Find tasteful dance moves for the robots', 80.55),
        LineItem('General quality assurance', 80),
      ],
      'Create software to teach robots how to dance',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoices'),
      ),
      body: ListView(
        children: [
          ...invoices.map(
            (e) => ListTile(
              title: Text(e.name),
              subtitle: Text(e.customer),
              trailing: Text('\$${e.totalCost().toStringAsFixed(2)}'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (builder) => DetailPage(invoice: e),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
