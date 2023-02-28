import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:flutter/material.dart';

class WatchedListScreen extends StatelessWidget {
  const WatchedListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(tWatchedList),
      ),
      body: Container(),
    );
  }
}