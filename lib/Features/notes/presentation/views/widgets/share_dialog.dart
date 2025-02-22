import 'package:flutter/material.dart';
import 'package:memo_mate/Features/notes/data/models/note_model.dart';
import 'package:memo_mate/core/utils/functions/share_note.dart';
import 'package:memo_mate/core/utils/pdf_service.dart';

class ShareDialog extends StatelessWidget {
  const ShareDialog({super.key, required this.note});
  final NoteModel note;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Share'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // TextButton(
          //   onPressed: () {},
          //   child: const Row(
          //     children: [
          //       Icon(Icons.image),
          //       SizedBox(width: 12),
          //       Text('as Image'),
          //     ],
          //   ),
          // ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ShareNote.shareNoteAsText(note);
            },
            child: const Row(
              children: [
                Icon(Icons.text_snippet),
                SizedBox(width: 12),
                Text('as Text'),
              ],
            ),
          ),
          TextButton(
            onPressed: () async {
              final pdfData =
                  await PdfService.generatePdf(note.title, note.description);
              ShareNote.shareNoteAsPdf(pdfData);
            },
            child: const Row(
              children: [
                Icon(Icons.picture_as_pdf),
                SizedBox(width: 12),
                Text('as Pdf'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Center(child: Text('Cancel')),
          )
        ],
      ),
    );
  }
}
