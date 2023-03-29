import 'package:filmtrack/src/features/core/models/media_model.dart';
import 'package:filmtrack/src/features/core/screens/recommendations/card_text.dart';
import 'package:filmtrack/src/features/core/screens/recommendations/buttons.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:flutter/material.dart';

class RecCard extends StatelessWidget {
  const RecCard({
    super.key,
    required this.media,
  });

  final MediaModel media;

  String organizeGenres() {
    if (media.genres.isEmpty) {
      return "";
    }
    String genreString = "";

    int j = 0;
    int k = 0;
    for (; k < media.genres.length; k++) {
      if (media.genres[k] == ",") {
        var genre = media.genres.substring(j, k);
        genreString += ' $genre •';
        j = k + 2;
      }
    }

    var genre = media.genres.substring(j, k);
    genreString += ' $genre •';

    return genreString.substring(1, genreString.length - 2);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Card(
            color: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(cardBorderRadius),
                    topRight: Radius.circular(cardBorderRadius))),
            child: Column(
              children: [
                Buttons(
                  mediaModel: media,
                ),
                const Padding(
                    padding: EdgeInsets.only(bottom: buttonTitlePadding)),
                CardText(
                  text: media.title,
                  widthFactor: titleWidthFactor,
                  textAlign: TextAlign.center,
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: titleFontSize),
                ),
                const Padding(
                    padding: EdgeInsets.only(bottom: titleDividerPadding)),
                const Divider(
                    indent: dividerIndent,
                    endIndent: dividerEndIndent,
                    height: dividerHeight,
                    thickness: dividerThickness,
                    color: Colors.black),
                const Padding(
                    padding: EdgeInsets.only(bottom: dividerGenrePading)),
                CardText(
                  text: organizeGenres(),
                  widthFactor: genreWidthFactor,
                  textAlign: TextAlign.center,
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: genreFontSize),
                ),
                const Padding(
                    padding: EdgeInsets.only(bottom: genreDescriptionPadding)),
                CardText(
                  text: media.overview,
                  widthFactor: descripWidthFactor,
                  textAlign: TextAlign.left,
                  textStyle: const TextStyle(
                      color: Colors.black, fontSize: descripFontSize),
                ),
                const Padding(
                    padding: EdgeInsets.only(bottom: cardPaddingBottom))
              ],
            )));
  }
}
