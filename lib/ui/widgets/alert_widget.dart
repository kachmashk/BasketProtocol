import 'package:flutter/material.dart';

Future buildAlertWidget(BuildContext context, String title, String content) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: Text('ok'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
    },
  );
}
