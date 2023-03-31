import 'package:filmtrack/src/common_widgets/media_toggle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/features/core/controllers/recommendations_controller.dart';
import 'package:filmtrack/src/features/core/screens/recommendations/carousel_and_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({Key? key}) : super(key: key);

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  late StreamSubscription<DocumentSnapshot<Object?>> _subscription;
  final controller = Get.put(RecommendationsController());

  Future<void> listenForRefresh() async {
    var userId = await controller.getUserID();
    _subscription = FirebaseFirestore.instance
        .collection('user_data')
        .doc(userId)
        .snapshots()
        .listen((DocumentSnapshot<Object?> userSnapshot) {
      int moviesCount =
          (userSnapshot.data() as Map<String, dynamic>)['moviesTilRefresh'];
      int showsCount =
          (userSnapshot.data() as Map<String, dynamic>)['showsTilRefresh'];
      if (moviesCount == 0) {
        controller.resetMediaCount("movies");
        //controller.calculateRecommendations("movie");
        setState(() {});

        // calculate recs
      }
      if (showsCount == 0) {
        controller.resetMediaCount("shows");
        //controller.calculateRecommendations("show");
        setState(() {});

        // calculate recs
      }
    });
  }

  @override
  void initState() {
    super.initState();
    listenForRefresh();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: FutureBuilder(
      future: controller.getMediaRecommendations(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(children: const [
            Padding(padding: EdgeInsets.only(top: 260)),
            Center(child: CircularProgressIndicator())
          ]);
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return MediaToggleWidget(
                moviesWidget: CarouselAndCard(
                    mediaList: controller.movieRecommendations,
                    mediaType: "movies"),
                showsWidget: CarouselAndCard(
                    mediaList: controller.showRecommendations,
                    mediaType: "shows"));
          }
        }
      },
    ));
  }
}
