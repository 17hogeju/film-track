import 'package:filmtrack/src/common_widgets/media_toggle.dart';
import 'package:filmtrack/src/features/core/controllers/recommendations_controller.dart';
import 'package:filmtrack/src/features/core/screens/recommendations/carousel_and_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecommendationScreen extends StatelessWidget {
  const RecommendationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecommendationsController());
    return FutureBuilder(
      future: controller.getMediaRecommendations(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return MediaToggleWidget(
                moviesWidget:
                    CarouselAndCard(mediaList: controller.movieRecommendations),
                showsWidget:
                    CarouselAndCard(mediaList: controller.showRecommendations));
          }
        }
      },
    );
  }
}
