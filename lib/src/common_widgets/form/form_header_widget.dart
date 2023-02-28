import 'package:filmtrack/src/constants/colors.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget(
      {Key? key,
      required this.image,
      required this.title,
      required this.hasSubtitle,
      this.subTitle})
      : super(key: key);

  final String image, title;
  final bool hasSubtitle;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Image(
          image: AssetImage(image),
          height: height * 0.2,
          color: tPrimaryColor,
        ),
        const SizedBox(height: tDefaultSizeDouble),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        if (hasSubtitle)
          Text(
            subTitle!,
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          )
      ],
    );
  }
}