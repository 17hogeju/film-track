import 'package:filmtrack/src/common_widgets/rating_dialog.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/features/core/controllers/dashboard_controller.dart';
import 'package:filmtrack/src/features/core/controllers/recommendations_controller.dart';
import 'package:filmtrack/src/features/core/models/media_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecCard extends StatefulWidget {
  const RecCard({
    required this.index,
    super.key,
    required this.media,
  });

  final MediaModel media;
  final int index;

  @override
  State<RecCard> createState() => _RecCardState();
}

class _RecCardState extends State<RecCard> {
  final controller = Get.put(RecommendationsController());

  Future<void> _showSnackBarWatched(rating) async {
    await controller.addToWatchedListRec(widget.media, rating.toInt(), widget.index);
  }

  void _showSnackBarToWatch() async {
    await controller.addToWatchListRec(widget.media, widget.index);
  }



  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Card(
            color: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  ClipOval(
                      child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () async {
                              _showSnackBarToWatch();
                            },
                            child: const SizedBox(
                                width: tIconButtonSize,
                                height: tIconButtonSize,
                                child: Icon(
                                    Icons.push_pin_rounded,
                                    color: Colors.black38)),
                          )
                      )
                  ),
                  ClipOval(
                      child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () async {
                              double? rating = await showDialog(
                                  context: context,
                                  builder: (context) => RatingDialog(mediaType: widget.media.mediaType == "tv" ? "TV show": "movie",));
                              if (rating != null){
                                _showSnackBarWatched(rating);
                              }
                            },
                            child: const SizedBox(
                                width: tIconButtonSize,
                                height: tIconButtonSize,
                                child: Icon(
                                    Icons.star_rounded,
                                    color: Colors.black38)),
                          )
                      )
                  ),
                ],
                ),
                const Padding(
                    padding: EdgeInsets.only(bottom: 20.0)),
                CardText(
                  text: widget.media.title,
                  widthFactor: 1.6,
                  textAlign: TextAlign.center,
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                const Padding(
                    padding: EdgeInsets.only(bottom: 5.0)),
                const Divider(
                    indent: 100.0,
                    endIndent: 100.0,
                    height: 0.005,
                    thickness: 1.5,
                    color: Colors.black),
                const Padding(
                    padding: EdgeInsets.only(bottom: 5.0)),
                CardText(
                  text: widget.media.genres,
                  widthFactor: 1.6,
                  textAlign: TextAlign.center,
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
                const Padding(
                    padding: EdgeInsets.only(bottom: 10.0)),
                CardText(
                  text: widget.media.overview,
                  widthFactor: 1.8,
                  textAlign: TextAlign.left,
                  textStyle: const TextStyle(
                      color: Colors.black, fontSize: 17.0),
                ),
                const Padding(
                    padding: EdgeInsets.only(bottom: 15.0))
              ],
            )));
  }
}

class CardText extends StatelessWidget {
  const CardText(
      {super.key,
        required this.text,
        required this.widthFactor,
        required this.textAlign,
        required this.textStyle});

  final String text;
  final double widthFactor;
  final TextAlign textAlign;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Flexible(
            child: FractionallySizedBox(
              widthFactor: .52,
            )),
        Flexible(
            child: FractionallySizedBox(
                widthFactor: widthFactor,
                child: Text(text, textAlign: textAlign, style: textStyle)))
      ],
    );
  }
}