import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class PdfService {
  /// Generate a simple PDF
  static Future generatePdf<Uint8List>(String title, String content) async {
    final pdf = Document();

    pdf.addPage(
      MultiPage(
          build: (Context context) => [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontSize: 22),
                        ),
                        SizedBox(height: 12),
                        ...content.split('\n').map((paragraph) => Text(
                            paragraph,
                            style: const TextStyle(fontSize: 20))),
                      ]),
                )
              ]),
    );

    return pdf.save();
  }

  static Future<File> savePdf({required String name, required pdf}) async {
    // final bytes = await pdf.save();
    final dir = await getDownloadsDirectory();
    final path = '${dir!.path}/$name.pdf';
    final file = File(path);
    await file.writeAsBytes(pdf);
    return file;
  }

  // static Future openPdf(File file)async {
  //   final url = file.path;
  //   await OpenFil

  // }
}
