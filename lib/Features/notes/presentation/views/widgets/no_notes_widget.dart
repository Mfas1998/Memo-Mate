import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NoNotesWidget extends StatelessWidget {
  const NoNotesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Iconsax.note_21, size: 64),
          SizedBox(height: 12),
          Text('No Notes', style: TextStyle(fontSize: 24))
        ],
      ),
    );
  }
}
