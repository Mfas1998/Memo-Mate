import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.okFunction,
    required this.content,
    required this.okButtonText,
    required this.cancelButtonText,
    required this.cancelFunction,
  });

  final VoidCallback okFunction;
  final VoidCallback cancelFunction;
  final String content;
  final String okButtonText;
  final String cancelButtonText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.bottomCenter,
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(onPressed: cancelFunction, child: Text(cancelButtonText)),
        TextButton(
            onPressed: okFunction,
            child: Text(
              okButtonText,
              style: TextStyle(
                  color: okButtonText.toLowerCase() == 'delete'
                      ? Colors.redAccent
                      : null),
            ))
      ],
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content),
        ],
      ),
    );
  }
}
