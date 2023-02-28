import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/features/core/screens/dashboard/dashboard_buttons_widget.dart';
import 'package:flutter/material.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(tDefaultSizeDouble),
      child: const DashboardButtonsWidget(),
    );
  }
}

