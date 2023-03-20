import 'package:filmtrack/src/constants/sizes.dart';
import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({
    required this.mediaIcon,
    required this.mediaTitle,
    required this.releaseDate,
    required this.mediaGenres,
    required this.mediaProviders,
    Key? key}) : super(key: key);

  final IconData mediaIcon;
  final String mediaTitle, releaseDate, mediaGenres, mediaProviders;

  @override
  Widget build(BuildContext context) {
    return Material(

        child: ListTile(
          isThreeLine: true,
          leading: Icon(mediaIcon),
          title: Text(mediaTitle),
          subtitle: Text("$releaseDate \u2022 $mediaGenres \u2022 $mediaProviders"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.star_rounded),
              Icon(Icons.push_pin_rounded)
            ],
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
