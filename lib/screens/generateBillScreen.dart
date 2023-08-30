import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'cartScreen.dart';
import 'homeScreen.dart';
import 'package:freshman.cafe/const/colors.dart';

class GenerateBillScreen extends StatelessWidget {
  final double totalAmount;
  final double discountAmount;
  final double deliveryCost;
  final double updatedTotal;
  final List<CartItem> cartItems;

  GenerateBillScreen({
    @required this.totalAmount,
    @required this.discountAmount,
    @required this.deliveryCost,
    @required this.updatedTotal,
    @required this.cartItems,
  });

  Future<void> generateAndDownloadPDFBill() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                color: PdfColors.purple,
                padding: pw.EdgeInsets.all(10),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "FreshMan Cafe",
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white, // Set the text color to white
                      ),
                    ),
                    pw.Text(
                      "PKR ${updatedTotal.toStringAsFixed(2)}",
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white, // Set the text color to white
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                height: 2,
                color: PdfColors.purple,
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                "Bill Details",
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                " ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}",
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Column(
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Container(
                        width: 100,
                        child: pw.Text('Product',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Container(
                        width: 100,
                        child: pw.Text('Unit Price',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Container(
                        width: 100,
                        child: pw.Text('Quantity',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                    ],
                  ),
                  pw.Container(
                    height: 1,
                    color: PdfColors.black,
                  ),
                  for (CartItem item in cartItems)
                    pw.Column(
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Container(
                              width: 100,
                              child: pw.Text(item.productName),
                            ),
                            pw.Container(
                              width: 100,
                              child: pw.Text(
                                  'PKR ${item.unitPrice.toStringAsFixed(2)}'),
                            ),
                            pw.Container(
                              width: 100,
                              child: pw.Text(item.quantity.toString()),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 10),
                      ],
                    ),
                ],
              ),
              pw.Container(
                height: 1,
                color: PdfColors.black,
              ),
              pw.SizedBox(height: 20),
              pw.Text("Sub Total: PKR ${totalAmount.toStringAsFixed(2)}"),
              pw.Text("Discount 5%: PKR ${discountAmount.toStringAsFixed(2)}"),
              pw.Text("Delivery Cost: PKR ${deliveryCost.toStringAsFixed(2)}"),
              pw.Divider(),
              pw.Text(
                "Total Amount: PKR ${updatedTotal.toStringAsFixed(2)}",
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 30),
              pw.Text(
                "Note: Prices are inclusive of all taxes. Thank you for your order!",
                style: pw.TextStyle(
                  fontSize: 12,
                  fontStyle: pw.FontStyle.italic,
                  color: PdfColors.grey,
                ),
              ),
              pw.SizedBox(height: 250),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Container(),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text("Minhaj University Lahore"),
                      pw.Text("freshmancafe@mul.edu.pk"),
                      pw.Text("(042)987389890"),
                    ],
                  ),
                ],
              ),
              pw.Container(
                height: 2,
                color: PdfColors.purple,
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/FMCbill.pdf");
    await file.writeAsBytes(await pdf.save());

    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.purple,
        title: Text("Invoice"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bill Details",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Date and Time: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Product',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Container(
                        width: 100,
                        child: Text('Unit Price',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        width: 100,
                        child: Text('Quantity',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  for (CartItem item in cartItems)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,
                              child: Text(item.productName),
                            ),
                            Container(
                              width: 100,
                              child: Text(
                                  'PKR ${item.unitPrice.toStringAsFixed(2)}'),
                            ),
                            Container(
                              width: 100,
                              child: Text(item.quantity.toString()),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: 10), // Increase the space between products
                      ],
                    ),
                ],
              ),
              SizedBox(height: 20),
              Text("Sub Total: PKR ${totalAmount.toStringAsFixed(2)}"),
              Text("Discount 5%: PKR ${discountAmount.toStringAsFixed(2)}"),
              Text("Delivery Cost: PKR ${deliveryCost.toStringAsFixed(2)}"),
              Divider(),
              Text(
                "Total Amount: PKR ${updatedTotal.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.picture_as_pdf,
                          size: 40,
                          color: Colors.purple,
                        ),
                        onPressed: generateAndDownloadPDFBill,
                      ),
                      Text("Download PDF"),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.home,
                          size: 40,
                          color: Colors.purple,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(HomeScreen.routeName);
                        },
                      ),
                      Text("Back to Home"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
