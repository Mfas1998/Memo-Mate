import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:memo_mate/Features/notes/data/models/note_model.dart';
import 'package:memo_mate/Features/notes/presentation/cubits/note_cubit/note_cubit.dart';

import 'widgets/confirm_dialog.dart';
import 'widgets/category_dropdown_button.dart';
import 'widgets/custom_text_form_field.dart';

class EditNoteView extends StatefulWidget {
  const EditNoteView({super.key, required this.note});

  final NoteModel note;

  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  TextEditingController? title;
  TextEditingController? description;
  String? category;

  @override
  void initState() {
    title = TextEditingController(text: widget.note.title);
    description = TextEditingController(text: widget.note.description);
    category = widget.note.category;
    super.initState();
  }

  @override
  void dispose() {
    title!.dispose();
    description!.dispose();
    super.dispose();
  }

  saveNote() {
    widget.note.title = title!.text;
    widget.note.description = description!.text;
    widget.note.category = category!;
    BlocProvider.of<NoteCubit>(context).editNote(widget.note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
        actions: [
          IconButton(
              onPressed: () {
                saveNote();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check))
        ],
        leading: IconButton(
            onPressed: () {
              if (title!.text == widget.note.title &&
                  description!.text == widget.note.description &&
                  category == widget.note.category) {
                Navigator.of(context).pop();
              } else {
                showDialog(
                    context: context,
                    builder: (context) => ConfirmDialog(
                          content: 'Save Changes?',
                          cancelButtonText: 'Discard',
                          okButtonText: 'Save',
                          cancelFunction: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          okFunction: () {
                            saveNote();
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ));
              }
            },
            icon: const Icon(Iconsax.arrow_left)),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 12,
          // bottom: MediaQuery.of(context).viewInsets.bottom)
        ),
        child: BlocBuilder<NoteCubit, NoteState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: AbsorbPointer(
                absorbing: state is NoteLoading,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextFormField(
                      controller: title!,
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
                      controller: description!,
                      label: 'Description',
                      maxLines: 10,
                    ),
                    const SizedBox(height: 12),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
