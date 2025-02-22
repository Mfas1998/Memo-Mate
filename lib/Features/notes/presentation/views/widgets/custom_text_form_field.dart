import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    required this.controller,
    this.maxLines,
    this.autoFocus = false,
    this.validator,
  });

  final String label;
  final int? maxLines;
  final TextEditingController controller;
  final bool autoFocus;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autoFocus,
      maxLines: null,
      minLines: 1,
      validator: validator,
      //  maxLines != null && maxLines! > 2 ? maxLines : 1,
      decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(fontSize: 20),
          // label: Text(label, style: const TextStyle(fontSize: 20)),
          border: const UnderlineInputBorder()),
      style: const TextStyle(fontSize: 20),
      //  const OutlineInputBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(12)))),
    );
  }
}
