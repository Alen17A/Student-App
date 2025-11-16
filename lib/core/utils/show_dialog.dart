import 'package:flutter/material.dart';

Future<bool> showConfirmationDialog(
  BuildContext context,
  String message,
) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Are you sure?"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text("Yes"),
          ),
        ],
      );
    },
  );
}
