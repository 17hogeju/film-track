import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:filmtrack/src/features/core/screens/settings/settings_screen.dart';
import 'package:filmtrack/src/features/core/screens/to_watch_list/to_watch_list_screen.dart';
import 'package:filmtrack/src/features/core/screens/watched_list/watched_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardButtonsWidget extends StatelessWidget {
  const DashboardButtonsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => Get.to(() => const ToWatchListScreen()),
              child: const Text(tToWatchList)),
        ),
        const SizedBox(height: tDefaultSize * 2),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => Get.to(() => const WatchedListScreen()),
              child: const Text(tWatchedList)),
        ),
        const SizedBox(height: tDefaultSize * 2),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => Get.to(() => const SettingsScreen()),
              child: const Text(tSettings)),
        ),
      ],
    );
  }
}
