import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/features/authentication/models/user_model.dart';
import 'package:filmtrack/src/features/core/controllers/recommendations_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecommendationScreen extends StatelessWidget {
  const RecommendationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecommendationsController());
    return Column(
      children: [
        const SizedBox(width: tDefaultSize * 5),
        FutureBuilder(
          future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;
                  var recommendations = userData.currRecs;
                  var textList = recommendations.map<Text>((s) => Text(s)).toList();
                  return Column(children: textList);
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: Text("Something went wrong"));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
        )
    ]
    );
  }
}



