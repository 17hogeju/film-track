import 'package:filmtrack/src/common_widgets/my_icon_button.dart';
import 'package:filmtrack/src/constants/colors.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:flutter/material.dart';

class ToWatchListItem extends StatelessWidget {
  const ToWatchListItem(
      {Key? key,
      required this.icon,
      required this.mediaTitle,
      required this.genres})
      : super(key: key);

  final IconData icon;
  final String mediaTitle, genres;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: 50.0,
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
              Icon(icon, color: tDarkColorVariant),
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
                        mediaTitle,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        genres,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: const [
              MyIconButton(icon: Icons.star_rounded, color: tPrimaryColor,),
              // SizedBox(width: tItemPadding,),
              // MyIconButton(icon: Icons.delete_rounded, color: tDanger,),

            ],
          )
        ],
      ),
    );
  }
}

