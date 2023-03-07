import 'package:filmtrack/src/constants/colors.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:flutter/material.dart';

class SafeWrapper extends StatelessWidget {
  const SafeWrapper(
      {Key? key,
        required this.title,
        required this.child,})
      : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title:  Text(title)
        ),
        body: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          decoration: const BoxDecoration(color: tCardBgColor),
          child: child
        )
      ),
    );
  }
}
