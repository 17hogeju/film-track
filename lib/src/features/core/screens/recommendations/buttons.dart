import 'package:filmtrack/src/common_widgets/confirm_dialog.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/constants/image_strings.dart';
import 'package:filmtrack/src/common_widgets/rating_dialog.dart';
import 'package:filmtrack/src/features/core/controllers/recommendations_controller.dart';
import 'package:filmtrack/src/features/core/models/media_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Buttons extends StatefulWidget {
  const Buttons({super.key, required this.mediaModel});

  final MediaModel mediaModel;

  @override
  State<Buttons> createState() => _Buttons();
}

class _Buttons extends State<Buttons> {
  final recommendationsController = Get.put(RecommendationsController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Padding(padding: EdgeInsets.only(right: buttonPaddingRight)),
      IconButton(
          onPressed: () async {
            double? rating = await showDialog(
                context: context,
                builder: (context) => RatingDialog(
                      mediaType: widget.mediaModel.mediaType == "tv"
                          ? "TV show"
                          : "movie",
                    ));
            if (rating != null) {
              recommendationsController.addToWatchedList(
                  widget.mediaModel, rating.toInt());
              setState(() {
                //refresh the page?
              });
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
              setState(() {
                recommendationsController.addToWatchList(widget.mediaModel);
              });
            }
          },
          icon: Image.asset(
            recPin,
            fit: BoxFit.cover,
          )),
    ]);
  }
}
