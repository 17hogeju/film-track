import 'package:filmtrack/src/common_widgets/media_toggle.dart';
import 'package:filmtrack/src/common_widgets/safe_wrapper.dart';
import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:filmtrack/src/features/core/screens/to_watch_list/movies_watch_widget.dart';
import 'package:filmtrack/src/features/core/screens/to_watch_list/shows_watch_widget.dart';
import 'package:flutter/material.dart';

class ToWatchListScreen extends StatelessWidget {
  const ToWatchListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeWrapper(
        title: tToWatchList,
        child: MediaToggleWidget(
            moviesWidget: MoviesWatchWidget(),
            showsWidget: ShowsWatchWidget()));
  }
}
