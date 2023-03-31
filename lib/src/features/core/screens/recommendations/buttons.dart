import 'package:filmtrack/src/common_widgets/confirm_dialog.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/constants/image_strings.dart';
import 'package:filmtrack/src/common_widgets/rating_dialog.dart';
import 'package:filmtrack/src/features/core/controllers/recommendations_controller.dart';
import 'package:filmtrack/src/features/core/models/media_model.dart';
import 'package:filmtrack/src/features/core/screens/recommendations/media_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Buttons extends StatelessWidget {
  Buttons({super.key, required this.mediaModel});

  final MediaModel mediaModel;
  final recommendationsController = Get.put(RecommendationsController());

  @override
  Widget build(BuildContext context) {
    final manager = MediaItemsManager.of(context)!.data;
    return Row(children: [
      const Padding(padding: EdgeInsets.only(right: buttonPaddingRight)),
      IconButton(
          onPressed: () async {
            double? rating = await showDialog(
                context: context,
                builder: (context) => RatingDialog(
                      mediaType:
                          mediaModel.mediaType == "tv" ? "TV show" : "movie",
                    ));
            if (rating != null) {
              recommendationsController.addToWatchedList(
                  mediaModel, rating.toInt());
              manager.updateMediaItems(mediaModel);
            }
          },
          icon: Image.asset(
            recStar,
            fit: BoxFit.cover,
          )),
      IconButton(
          onPressed: () async {
            var confirm = await showDialog(
                context: context, builder: (context) => const ConfirmDialog());
            if (confirm != null) {
              recommendationsController.addToWatchList(mediaModel);
              manager.updateMediaItems(mediaModel);
            }
          },
          icon: Image.asset(
            recPin,
            fit: BoxFit.cover,
          )),
    ]);
  }
}
