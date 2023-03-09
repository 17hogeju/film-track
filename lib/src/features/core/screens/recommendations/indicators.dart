import 'package:flutter/material.dart';

class Indicators extends StatelessWidget {
  const Indicators({Key? key,
  required this.totalNum,
  required this.currIndex}) : super(key: key);

  final int totalNum, currIndex;

  @override
  Widget build(BuildContext context) {
    var list = List.generate(totalNum, (i) => Container(
      width: 10,
      height: 10,
        margin: const EdgeInsets.all(3),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: i == currIndex ? Colors.black : Colors.grey,
        shape: BoxShape.circle
      ),
    ));
    return Row(children: list);
  }
}
