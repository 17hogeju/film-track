import 'package:filmtrack/src/common_widgets/my_icon_button.dart';
import 'package:filmtrack/src/common_widgets/rating_dialog.dart';
import 'package:filmtrack/src/constants/colors.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/features/core/controllers/to_watch_list_controller.dart';
import 'package:filmtrack/src/features/core/controllers/watched_list_controller.dart';
import 'package:filmtrack/src/features/core/models/media_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToWatchListItem extends StatefulWidget {
  const ToWatchListItem(
      {Key? key,
      required this.mediaItem})
      : super(key: key);

  final MediaModel mediaItem;

  @override
  State<ToWatchListItem> createState() => _ToWatchListItemState();
}

class _ToWatchListItemState extends State<ToWatchListItem> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final controller = Get.put(ToWatchListController());

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
                  widget.mediaItem.mediaType == "tv" ? Icons.tv_rounded : Icons.movie_creation_rounded,
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
                          widget.mediaItem.title,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          widget.mediaItem.releaseDate,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          widget.mediaItem.genres,
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
              ClipOval(
                  child: Material(
                      color: Colors.white,
                      child: InkWell(
                        onTap: () async {
                          double? rating = await showDialog(
                              context: context,
                              builder: (context) => RatingDialog(mediaType: widget.mediaItem.mediaType == "tv" ? "TV show": "movie",));
                          if (rating != null){
                            setState(() {
                              controller.addToWatchedList(widget.mediaItem, rating.toInt());
                            });
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
              // SizedBox(width: tItemPadding,),
              // MyIconButton(icon: Icons.delete_rounded, color: tDanger,),
            ],
          )
        ],
      ),
    );
  }
}

