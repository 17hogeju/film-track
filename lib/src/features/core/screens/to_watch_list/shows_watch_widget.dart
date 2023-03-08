import 'package:filmtrack/src/features/core/screens/to_watch_list/to_watch_item.dart';
import 'package:flutter/material.dart';

class ShowsWatchWidget extends StatelessWidget {
  const ShowsWatchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ToWatchListItem(icon: Icons.tv_rounded, mediaTitle: "Breaking Bad", genres: "Action, Adventure"),
        ToWatchListItem(icon: Icons.tv_rounded, mediaTitle: "Dexter", genres: "Action, Adventure"),
      ],
    );
  }
}