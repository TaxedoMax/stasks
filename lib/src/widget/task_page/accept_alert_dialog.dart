import 'package:flutter/material.dart';

class AcceptAlertDialog extends StatelessWidget{
  final String title;
  final String text;
  const AcceptAlertDialog({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('ОК'),
        ),
      ],
    );
  }
}