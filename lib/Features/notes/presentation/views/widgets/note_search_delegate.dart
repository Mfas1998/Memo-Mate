import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:memo_mate/Features/notes/data/models/note_model.dart';
import 'package:memo_mate/Features/notes/presentation/views/widgets/notes_list_view.dart';

class NoteSearchDelegate extends SearchDelegate {
  final List<NoteModel> notes;

  NoteSearchDelegate(
      {super.searchFieldLabel,
      super.searchFieldStyle,
      super.searchFieldDecorationTheme,
      super.keyboardType,
      super.textInputAction,
      required this.notes});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Iconsax.close_circle)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Iconsax.arrow_left_1));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var filteredNotes = notes
        .where((element) =>
            element.title.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: NotesListView(notes: query == '' ? notes : filteredNotes),
    );
  }
}
