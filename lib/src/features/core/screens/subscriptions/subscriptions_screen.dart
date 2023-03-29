import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/features/core/controllers/subscription_controller.dart';
import 'package:filmtrack/src/features/core/screens/subscriptions/sub_carousel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubscriptionController());
    return Column(children: [
      // const SizedBox(width: tDefaultSize * 5),
      FutureBuilder(
        future: controller.getSubscriptionRecommendations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('loading...'));
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Center(child: Column(
                children: [
                  const Text('Based on Your Watched List'),
                  const SizedBox(height: tDefaultSize),
                  SubCarousel(recommendations: controller.watchedRecommendations),
                  const SizedBox(height: tDefaultSizeDouble,),
                  const Text('Based on Your To Watch List'),
                  const SizedBox(height: tDefaultSize),
                  SubCarousel(recommendations: controller.toWatchRecommendations),
                ]
              ));
            }
          }
        },
      )
    ]);
  }
}
