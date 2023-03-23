import 'package:filmtrack/src/common_widgets/my_icon_button.dart';
import 'package:filmtrack/src/constants/colors.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/features/core/models/media_model.dart';
import 'package:flutter/material.dart';

class WatchedListItem extends StatelessWidget {
  const WatchedListItem(
      {Key? key,
        required this.mediaItem,
        required this.rating
      })
      : super(key: key);

  final MediaModel mediaItem;
  final int rating;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: tListItemHeight,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1.0, color: tBorderColor))),
      padding: const EdgeInsets.fromLTRB(
          tDefaultSize, tItemPadding, tDefaultSize, tItemPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                  mediaItem.mediaType == "tv" ? Icons.tv_rounded : Icons.movie_creation_rounded,
                  color: tDarkColorVariant),
              const SizedBox(
                width: tDefaultSize,
              ),
              SizedBox(
                width: width * 0.5,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        mediaItem.title,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        mediaItem.releaseDate,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        mediaItem.genres,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "$rating / 5",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Icon(Icons.star_rounded, color: tDarkColorVariant)
              // MyIconButton(icon: Icons.star_rounded, color: tPrimaryColor, onTap: (){},),
              // MyIconButton(icon: Icons.delete_rounded, color: tPrimaryColor, onTap: (){})
              // SizedBox(width: tItemPadding,),
              // MyIconButton(icon: Icons.delete_rounded, color: tDanger,),
            ],
          )
        ],
      ),
    );
  }
}

