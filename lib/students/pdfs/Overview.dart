import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pdf/widgets.dart' as pw;

import '../constants.dart';

class Overview extends StatefulWidget {
  Overview({Key? key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  late PdfViewerController _pdfViewerController;

  List<String> pdfFiles = [
    'assets/1.pdf',
    'assets/2.pdf',
    'assets/3.pdf',
    'assets/4.pdf',
    'assets/5.pdf',

    // Add more file paths as needed
  ];
  List<String> buttonNames = [
    'مقدمة ',
    'الاحكام',
    'الاقسام والدرجات العلمية',
    'التكويد',
    'الدراسة والشئون والامتحانات',

    // Add more button names as needed
  ];
  int selectedIndex = 0;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  Future<List<int>> generatePdf(String filePath) async {
    final pdf = pw.Document();
    final bytes = await rootBundle.load(filePath);
    final Uint8List data = bytes.buffer.asUint8List();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Image(
            PdfImage.file(pdf.document, bytes: data) as pw.ImageProvider,
          );
        },
      ),
    );
    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text("Study plan"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _pdfViewerController.zoomLevel = 1.25;
            },
            icon: const Icon(
              Icons.zoom_in,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              _pdfViewerController.zoomLevel = 1.0;
            },
            icon: const Icon(
              Icons.zoom_out,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: SfPdfViewer.asset(
                pdfFiles[selectedIndex],
                controller: _pdfViewerController,
              ),
            ),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: List.generate(
              pdfFiles.length,
              (index) => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.black, // Set the background color to black
                ),
                onPressed: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Text(index < buttonNames.length
                    ? buttonNames[index]
                    : 'Unnamed'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
