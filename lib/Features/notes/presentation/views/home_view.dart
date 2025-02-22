import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:memo_mate/Features/notes/presentation/views/widgets/add_note.dart';
import 'package:memo_mate/Features/notes/presentation/views/widgets/home_view_body.dart';
import 'package:memo_mate/Features/notes/presentation/views/widgets/note_search_delegate.dart';

import '../cubits/note_cubit/note_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memo Mate'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: NoteSearchDelegate(
                      notes: BlocProvider.of<NoteCubit>(context).getNotes()));
            },
            icon: const Icon(Iconsax.search_favorite),
          ),
          PopupMenuButton(
              padding: const EdgeInsets.all(16),
              // menuPadding: const EdgeInsets.all(16),
              position: PopupMenuPosition.under,
              itemBuilder: (context) => [
                    const PopupMenuItem(child: Text('Setting')),
                  ]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => const AddNote());
        },
        child: const Icon(Iconsax.add4),
      ),
      body: const HomeViewBody(),
    );
  }
}
