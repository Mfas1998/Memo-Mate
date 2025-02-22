import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconsax/iconsax.dart';
import 'package:memo_mate/Features/notes/data/models/note_model.dart';
import 'package:memo_mate/Features/notes/presentation/cubits/category_cubit/category_cubit.dart';
import 'package:memo_mate/Features/notes/presentation/cubits/note_cubit/note_cubit.dart';
import 'package:memo_mate/Features/notes/presentation/views/note_details_view.dart';
import 'package:memo_mate/Features/notes/presentation/views/widgets/custom_slidable_action.dart';
import 'package:memo_mate/core/utils/functions/format_date.dart';

import 'confirm_dialog.dart';
import 'share_dialog.dart';

class NoteListViewItem extends StatelessWidget {
  const NoteListViewItem({
    super.key,
    required this.note,
  });

  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        final categories =
            BlocProvider.of<CategoryCubit>(context).getCategories();

        // Find the color where the category names match  note.category
        final color = categories
            .where((e) => e.categoryName == note.category)
            .firstOrNull
            ?.color;

        return Card(
          elevation: 0,
          color: color != null ? Color(color).withOpacity(0.2) : null,
          child: Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                MyCustomSlidableAction(
                  onPressed: (value) {
                    showDialog(
                        context: context,
                        builder: (context) => ShareDialog(note: note));
                  },
                  icon: Iconsax.share4,
                ),
                MyCustomSlidableAction(
                  onPressed: (value) {
                    BlocProvider.of<NoteCubit>(context).markFavorite(note);
                  },
                  icon:
                      note.favorite ? Iconsax.magic_star1 : Iconsax.magic_star,
                ),
                MyCustomSlidableAction(
                  onPressed: (value) {
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
                                BlocProvider.of<NoteCubit>(context)
                                    .deleteNote(note);
                                Navigator.pop(context);
                              },
                            ));
                  },
                  icon: Iconsax.trash4,
                ),
              ],
            ),
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NoteDetailsView(
                          note: note,
                        )));
              },
              title: Text(
                note.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Row(
                children: [
                  // width: MediaQuery.of(context).size.width * 0.5,
                  Expanded(
                    child: Text(
                      note.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              leading: note.favorite
                  ? const Icon(
                      Iconsax.magic_star1,
                      color: Color(0xffffd700),
                    )
                  : null,
              trailing: Text(FormatDateTime.formattedDateTime(note.date)),
            ),
          ),
        );
      },
    );
  }
}
