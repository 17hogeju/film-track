import 'dart:async';

import 'package:filmtrack/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({
    required this.mediaType,
    super.key});
  final String mediaType;

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Rate this ${widget.mediaType}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('How many stars would you rate this ${widget.mediaType}?'),
          const SizedBox(height: 16),
          RatingBar.builder(
            initialRating: _rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star_rounded,
              color: tPrimaryColor,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('CANCEL'),
          onPressed: () {
            Get.back();
          },
        ),
        TextButton(
          child: Text('OK'),
          onPressed: () {
            // Here you can handle the user's rating
            Get.back(result: _rating);
          },
        ),
      ],
    );
  }
}
