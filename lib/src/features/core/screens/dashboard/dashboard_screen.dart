import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:filmtrack/src/features/core/controllers/dashboard_controller.dart';
import 'package:filmtrack/src/features/core/models/title_model.dart';
import 'package:filmtrack/src/features/core/screens/settings/settings_screen.dart';
import 'package:filmtrack/src/features/core/screens/to_watch_list/to_watch_list_screen.dart';
import 'package:filmtrack/src/features/core/screens/watched_list/watched_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      // mainAxisAlignment: MainAxisAlignment.center,
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
        const SizedBox(height: tDefaultSize * 2),
        FutureBuilder(
          future: controller.getSearchResults("the legend of"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text('loading...'));
            } else {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                // print(controller.queryResults);
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.queryResults.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(
                        controller.queryResults[index],
                        style: TextStyle(fontSize: 11),
                      );
                    },
                  ),
                );
              }
            }
          },
        )
      ],
    );
  }
}

