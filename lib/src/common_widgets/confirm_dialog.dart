import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmDialog extends StatefulWidget {
  const ConfirmDialog({super.key});

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(tConfirmAddTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          Text(tConfirmAdd),
          SizedBox(height: 16),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(tCANCEL),
          onPressed: () {
            Get.back();
          },
        ),
        TextButton(
          child: const Text(tOK),
          onPressed: () {
            // Here you can handle the user's rating
            Get.back(result: "OK");
          },
        ),
      ],
    );
  }
}
