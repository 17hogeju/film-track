import 'package:filmtrack/src/constants/sizes.dart';
import 'package:flutter/material.dart';

class NoRecommendations extends StatelessWidget {
  const NoRecommendations({super.key, required this.mediaType});

  final String mediaType;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Padding(padding: EdgeInsets.only(top: noRecommendationsPaddingTop)),
      Text(
          "Add more $mediaType to your To Watch List and Watched List to see more recommendations!",
          textAlign: TextAlign.center)
    ]);
  }
}
