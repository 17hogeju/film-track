import 'package:filmtrack/src/common_widgets/media_toggle.dart';
import 'package:filmtrack/src/common_widgets/safe_wrapper.dart';
import 'package:filmtrack/src/constants/sizes.dart';
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
            moviesWidget: MediaWrapper(child: MoviesWatchWidget()),
            showsWidget: MediaWrapper(child: ShowsWatchWidget(),)
        )
    );
  }
}

class MediaWrapper extends StatelessWidget {
  const MediaWrapper({
    super.key,
    required this.child
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(0.0, tDefaultSize, 0.0, 0.0),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(tDefaultSize),
                topRight: Radius.circular(tDefaultSize)),
            color: Colors.white
        ),
        width: double.infinity,
        child: child,
      ),
    );
  }
}
