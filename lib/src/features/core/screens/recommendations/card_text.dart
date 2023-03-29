import 'package:flutter/material.dart';
import 'package:filmtrack/src/constants/sizes.dart';

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
          widthFactor: descripFlexWidthFactor,
        )),
        Flexible(
            child: FractionallySizedBox(
                widthFactor: widthFactor,
                child: Text(text, textAlign: textAlign, style: textStyle)))
      ],
    );
  }
}
