import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:flutter/material.dart';

class ToWatchListScreen extends StatelessWidget {
  const ToWatchListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(tToWatchList),
      ),
      body: Container(),
    );
  }
}