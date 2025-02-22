import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo_mate/Features/notes/data/models/note_model.dart';
import 'package:memo_mate/Features/notes/presentation/cubits/note_cubit/note_cubit.dart';
import 'package:memo_mate/Features/notes/presentation/views/widgets/category_dropdown_button.dart';
import 'package:memo_mate/Features/notes/presentation/views/widgets/no_notes_widget.dart';
import 'package:memo_mate/Features/notes/presentation/views/widgets/notes_list_view.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  List<NoteModel> notes = [];
  dynamic selectedCategory = 'all notes';
  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryDropdownButton(
              selectedValue: selectedCategory,
              allNotes: true,
              onChange: (value) {
                setState(() {
                  selectedCategory = value;
                });
              }),
          Expanded(child: BlocBuilder<NoteCubit, NoteState>(
            builder: (context, state) {
              notes = BlocProvider.of<NoteCubit>(context)
                  .getNotes(category: selectedCategory);

              return notes.isNotEmpty
                  ? NotesListView(
                      notes: notes,
                    )
                  : const NoNotesWidget();
            },
          )),
        ],
      ),
    );
  }
}
