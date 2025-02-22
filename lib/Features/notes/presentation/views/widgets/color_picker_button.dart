import 'package:flutter/material.dart';

class ColorPickerButton extends StatelessWidget {
  const ColorPickerButton(
      {super.key, required this.selected, required this.color});

  final bool selected;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 12,
        backgroundColor: color,
        child: selected
            ? const CircleAvatar(
                radius: 6,
                backgroundColor: Colors.black,
              )
            : const SizedBox());
  }
}
