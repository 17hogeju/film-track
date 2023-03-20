import 'package:filmtrack/src/constants/colors.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap
  });

  final IconData icon;
  final Color color;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
        child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                onTap;
              },
              child: SizedBox(width: tIconButtonSize, height: tIconButtonSize, child: Icon(icon, color: color)),
            )
        )
    );
  }
}