import 'package:filmtrack/src/common_widgets/media_toggle.dart';
import 'package:filmtrack/src/common_widgets/safe_wrapper.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:filmtrack/src/features/authentication/models/user_model.dart';
import 'package:filmtrack/src/features/core/controllers/watched_list_controller.dart';
import 'package:filmtrack/src/features/core/models/media_model.dart';
import 'package:filmtrack/src/features/core/screens/watched_list/watched_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WatchedListScreen extends StatelessWidget {
  WatchedListScreen({Key? key}) : super(key: key);
  final controller = Get.put(WatchedListController());

  @override
  Widget build(BuildContext context) {
    return SafeWrapper(
        title: tWatchedList,
        child: FutureBuilder(
            future: controller.getToWatchList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text('loading...'));
              } else {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Widget> movies = [];
                  List<Widget> shows = [];
                  for (RatingMediaModel result in controller.watchedMovies) {
                    movies.add(
                      WatchedListItem(mediaItem: result.media, rating: result.rating),
                    );
                  }
                  for (RatingMediaModel result in controller.watchedShows) {
                    shows.add(
                      WatchedListItem(mediaItem: result.media, rating: result.rating),
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
