import 'package:filmtrack/src/common_widgets/my_icon_button.dart';
import 'package:filmtrack/src/constants/colors.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/features/core/controllers/dashboard_controller.dart';
import 'package:filmtrack/src/features/core/models/media_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchItem extends StatefulWidget {
  const SearchItem({required this.mediaModel,
    Key? key})
      : super(key: key);

  final MediaModel mediaModel;

  @override
  State<SearchItem> createState() =>
      _SearchItemState();
}
class _SearchItemState extends State<SearchItem> {
  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black12))),
        child: ListTile(
          tileColor: Colors.white,
          // isThreeLine: true,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.mediaModel.mediaType == "tv" ? Icons.tv_rounded : Icons.movie_creation_rounded,
                color: tDarkColorVariant,
              ),
            ],
          ),
          title: Text(widget.mediaModel.title),
          subtitle: Text(
            widget.mediaModel.releaseDate,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: Material(
                color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          controller.addToWatchList(widget.mediaModel);
                        });
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
              MyIconButton(
                color: tPrimaryColor,
                icon: Icons.star_rounded,
                onTap: (){},),
            ],
          ),
        ),
      ),
    );
  }
}

// Container(
// padding: EdgeInsets.all(tDefaultSize),
// color: Colors.lightGreen,
// height: 64.0,
// child: Row(
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Icon(mediaIcon),
// Column(
// children: [
// Text(mediaTitle, style: Theme.of(context).textTheme.labelMedium,),
// Text("$releaseDate - $mediaGenres", style: Theme.of(context).textTheme.labelSmall)
// ],
// ),
// Align(
// alignment: Alignment.centerRight,
// child: Row(
// children: [
// const Icon(Icons.star_rounded),
// const Icon(Icons.push_pin_rounded)
// ],
// ),
// )
// ],
// ),
// );
