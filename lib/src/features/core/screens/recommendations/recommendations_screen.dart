import 'package:filmtrack/src/common_widgets/media_toggle.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/features/authentication/models/user_model.dart';
import 'package:filmtrack/src/features/core/controllers/recommendations_controller.dart';
import 'package:filmtrack/src/features/core/models/media_model.dart';
import 'package:filmtrack/src/features/core/screens/recommendations/carousel_and_card.dart';
import 'package:filmtrack/src/features/core/screens/to_watch_list/to_watch_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecommendationScreen extends StatelessWidget {
  const RecommendationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recommendationsController = Get.put(RecommendationsController());

    return SingleChildScrollView(
        child: Column(children: [
      const SizedBox(width: tDefaultSize * 5),
      FutureBuilder(
        future: recommendationsController.getMediaRecommendations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('loading...'));
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return MediaToggleWidget(
                  moviesWidget: CarouselAndCard(
                    mediaList: recommendationsController.movieRecommendations,
                  ),
                  showsWidget: CarouselAndCard(
                    mediaList: recommendationsController.showRecommendations,
                  ));
            }
          }
        },
      )
    ]));
  }
}
