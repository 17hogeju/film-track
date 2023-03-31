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

    return FutureBuilder(
      future: controller.getSubscriptionRecommendations(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(
                child: Column(
                    children: [
                      Text(
                        'Based on Your Watched List',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: tDefaultSize),
                      SubCarousel(recommendations: controller.watchedRecommendations),
                      const SizedBox(
                        height: tDefaultSizeDouble,
                      ),
                      Text(
                        'Based on Your To Watch List',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: tDefaultSize),
                      SubCarousel(recommendations: controller.toWatchRecommendations),
                  ]
                )
            );
          }
        }
      },
    );
  }
}
