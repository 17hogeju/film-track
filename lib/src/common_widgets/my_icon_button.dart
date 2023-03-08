import 'package:filmtrack/src/constants/colors.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton({
    super.key,
    required this.icon,
    required this.color
  });

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
        child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {},
              child: SizedBox(width: tIconButtonSize, height: tIconButtonSize, child: Icon(icon, color: color)),
            )
        )
    );
  }
}