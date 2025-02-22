import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:memo_mate/Features/notes/data/models/note_model.dart';
import 'package:memo_mate/Features/notes/presentation/cubits/note_cubit/note_cubit.dart';
import 'package:memo_mate/Features/notes/presentation/views/widgets/confirm_dialog.dart';
import 'package:memo_mate/core/utils/functions/format_date.dart';
import '../../../../core/widgets/custom_text_button.dart';
import 'edit_note_view.dart';
import 'widgets/share_dialog.dart';

class NoteDetailsView extends StatelessWidget {
  const NoteDetailsView({super.key, required this.note});
  final NoteModel note;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteCubit, NoteState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          persistentFooterAlignment: AlignmentDirectional.center,
          persistentFooterButtons: [
            CustomTextButton(
                onPressed: () async {
                  // final pdf = await PdfService.generatePdf(
                  //     note.title, note.description);

                  // await PdfService.savePdf(name: 'moham2', pdf: pdf);

                  showDialog(
                      context: context,
                      builder: (context) => ShareDialog(note: note));
                },
                label: 'Share',
                icon: const Icon(Iconsax.share4)),
            CustomTextButton(
              onPressed: () {
                BlocProvider.of<NoteCubit>(context).markFavorite(note);
              },
              label: 'Favorite',
              icon: Icon(
                color: Theme.of(context).colorScheme.primary,
                note.favorite ? Iconsax.magic_star1 : Iconsax.magic_star,
              ),
            ),
            CustomTextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => ConfirmDialog(
                        content: 'Delete this note?',
                        cancelButtonText: 'Cancel',
                        okButtonText: 'Delete',
                        cancelFunction: () {
                          Navigator.pop(context);
                        },
                        okFunction: () {
                          BlocProvider.of<NoteCubit>(context).deleteNote(note);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }));
              },
              label: 'Delete',
              icon: const Icon(Iconsax.trash4),
            ),
            CustomTextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditNoteView(
                          note: note,
                        )));
              },
              label: 'Edit',
              icon: const Icon(
                Iconsax.edit4,
              ),
            ),
          ],
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      note.title,
                      style: const TextStyle(fontSize: 22),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(FormatDateTime.formattedDateTime(note.date)),
                        const SizedBox(width: 16),
                        Text(note.category),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SelectableText(
                      note.description,
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
