import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo_mate/Features/notes/data/models/note_model.dart';
import 'package:memo_mate/Features/notes/presentation/cubits/note_cubit/note_cubit.dart';

import 'category_dropdown_button.dart';
import 'custom_text_form_field.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  String category = 'No Category';

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BlocConsumer<NoteCubit, NoteState>(
        listener: (context, state) {
          if (state is NoteSuccess) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: AbsorbPointer(
              absorbing: state is NoteLoading,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextFormField(
                    controller: title,
                    label: 'Title',
                    maxLines: 2,
                  ),
                  const SizedBox(height: 8),
                  StatefulBuilder(
                    builder: (BuildContext context, function) =>
                        CategoryDropdownButton(
                      selectedValue: category,
                      onChange: (value) {
                        function(() {
                          category = value.toString();
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: description,
                    label: 'Description',
                    maxLines: 10,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent),
                      onPressed: () {
                        NoteModel note = NoteModel(
                          title: title.text,
                          description: description.text,
                          date:
                              DateTime.now().millisecondsSinceEpoch.toString(),
                          category: category,
                        );
                        BlocProvider.of<NoteCubit>(context).addNote(note);
                      },
                      child: Center(
                          child: state is NoteLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator())
                              : const Text(
                                  'Add',
                                  style: TextStyle(color: Colors.white),
                                ))),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
