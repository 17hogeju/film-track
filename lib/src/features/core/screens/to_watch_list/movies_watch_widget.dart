import 'package:filmtrack/src/features/core/screens/to_watch_list/to_watch_item.dart';
import 'package:flutter/material.dart';

class MoviesWatchWidget extends StatelessWidget {
  const MoviesWatchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ToWatchListItem(icon: Icons.movie_rounded, mediaTitle: "Harry Potter", genres: "Action, Adventure"),
        ToWatchListItem(icon: Icons.movie_rounded, mediaTitle: "Harry Potter and the Prisoner of Askaban", genres: "Action, Adventure,Action, Adventure, Action"),
      ],
    );
  }
}