import 'package:filmtrack/src/common_widgets/media_toggle.dart';
import 'package:filmtrack/src/features/core/controllers/recommendations_controller.dart';
import 'package:filmtrack/src/features/core/screens/recommendations/carousel_and_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({Key? key}) : super(key: key);

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  late Future<dynamic> _futureData;
  final controller = Get.put(RecommendationsController());

  @override
  void initState() {
    super.initState();
    _futureData = controller.getMediaRecommendations();
    controller.snackbarFunction = _showSnackBar;
    controller.refreshFunction = _refreshData;
  }

  _showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _refreshData() {
    setState(() {
      _futureData = controller.getMediaRecommendations();
    });
  }


  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _futureData,
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
