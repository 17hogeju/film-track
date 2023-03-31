import 'package:filmtrack/src/common_widgets/media_toggle.dart';
import 'package:filmtrack/src/common_widgets/safe_wrapper.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:filmtrack/src/features/core/controllers/to_watch_list_controller.dart';
import 'package:filmtrack/src/features/core/models/media_model.dart';
import 'package:filmtrack/src/features/core/screens/to_watch_list/to_watch_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToWatchListScreen extends StatelessWidget {
  ToWatchListScreen({Key? key}) : super(key: key);
  final controller = Get.put(ToWatchListController());

  @override
  Widget build(BuildContext context) {
    return SafeWrapper(
        title: tToWatchList,
        child: FutureBuilder(
          future: controller.getToWatchList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<Widget> movies = [];
                List<Widget> shows = [];
                for (MediaModel result in controller.toWatchMovies) {
                  movies.add(
                    ToWatchListItem(mediaItem: result),
                  );
                }
                for (MediaModel result in controller.toWatchShows) {
                  shows.add(
                    ToWatchListItem(mediaItem: result),
                  );
                }
                return MediaToggleWidget(
                  showsWidget: MediaWrapper(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: shows
                    )
                  ),
                  moviesWidget: MediaWrapper(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: movies
                  )
                  ),
                );
              }
            }
          }
        )
    );
  }
}

class MediaWrapper extends StatelessWidget {
  const MediaWrapper({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(0.0, tDefaultSize, 0.0, 0.0),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(tDefaultSize),
                topRight: Radius.circular(tDefaultSize)),
            color: Colors.white
        ),
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - tMinHeight,
        ),
        child: child,
    );
  }
}
