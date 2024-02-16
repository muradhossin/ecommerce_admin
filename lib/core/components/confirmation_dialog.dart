
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String? title;
  final String? body;
  final Function? onYes;
  final Function? onNo;
  const ConfirmationDialog({
    super.key,
    this.title,
    this.body,
    required this.onYes,
    this.onNo,
  });


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? 'Are you sure?'),
      content: Text(body ?? 'Do you want to proceed?'),
      actions: <Widget>[
        TextButton(
          onPressed: onNo as void Function()? ?? () {
            Navigator.of(context).pop(false);
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            onYes!();
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
