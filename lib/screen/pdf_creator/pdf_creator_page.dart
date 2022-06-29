import 'package:flutter/material.dart';
import 'package:learn_flutter/constants.dart';
// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfCreatorPage extends StatefulWidget {
  PdfCreatorPage({Key? key}) : super(key: key);

  @override
  State<PdfCreatorPage> createState() => _PdfCreatorPageState();
}

class _PdfCreatorPageState extends State<PdfCreatorPage> {
  double heightA4 = 3508;
  double widthA4 = 2480;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Test PDF")),
        body: PdfPreview(
          allowSharing: false,
          allowPrinting: false,
          canChangeOrientation: false,
          canDebug: false,
          canChangePageFormat: false,
          maxPageWidth: widthA4,
          dynamicLayout: false,
          padding: EdgeInsets.zero,
          build: (format) => _generatePdf(format, "Semarang"),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    // final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        // pageFormat: format,
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Container(
            height: heightA4,
            width: widthA4,
            color: PdfColor.fromHex(warnaBackground),
            child: pw.Center(
              child: pw.Text("Ajianaz"),
            ),
          );
        },
      ),
    );

    return pdf.save();
  }
}
