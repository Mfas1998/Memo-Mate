import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:memo_mate/Features/notes/data/models/note_model.dart';
import 'package:share_plus/share_plus.dart';

class ShareNote {
  static Future shareNoteAsText(NoteModel note) async {
    await Share.share('${note.title}\n\n ${note.description} ');
  }

  static Future shareNoteAsPdf(Uint8List pdfData) async {
    try {
      // Create an XFile from the Uint8List
      final XFile pdfFile = XFile.fromData(
        pdfData,
        mimeType: 'application/pdf',
      );

      // Share the PDF file
      await Share.shareXFiles([pdfFile]);
    } catch (e) {
      debugPrint('Error sharing PDF: $e');
    }
  }
}
