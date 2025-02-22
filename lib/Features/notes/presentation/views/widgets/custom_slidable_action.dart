import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyCustomSlidableAction extends StatelessWidget {
  const MyCustomSlidableAction({
    super.key,
    this.onPressed,
    required this.icon,
    this.label,
  });

  final Function(BuildContext)? onPressed;
  final IconData icon;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      onPressed: onPressed,
      label: label,
      icon: icon,
      // backgroundColor: backgroundColor,
    );
  }
}
