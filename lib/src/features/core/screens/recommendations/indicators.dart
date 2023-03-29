import 'package:flutter/material.dart';
import 'package:filmtrack/src/constants/sizes.dart';

class Indicators extends StatelessWidget {
  const Indicators({Key? key, required this.totalNum, required this.currIndex})
      : super(key: key);

  final int totalNum, currIndex;

  @override
  Widget build(BuildContext context) {
    var list = List.generate(
        totalNum,
        (i) => Container(
              width: indicatorWidth,
              height: indicatorHeight,
              margin: const EdgeInsets.all(indicatorMargin),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                  color: i == currIndex ? Colors.black : Colors.grey,
                  shape: BoxShape.circle),
            ));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: list);
  }
}
