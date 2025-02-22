import 'package:flutter/material.dart';
import 'package:memo_mate/Features/notes/data/models/note_model.dart';
import 'package:memo_mate/Features/notes/presentation/views/widgets/note_list_view_item.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({super.key, required this.notes});

  final List<NoteModel> notes;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return NoteListViewItem(
          note: notes[index],
        );
      },
    );
  }
}
