import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:filmtrack/src/features/core/controllers/dashboard_controller.dart';
import 'package:filmtrack/src/features/core/models/media_model.dart';
import 'package:filmtrack/src/features/core/screens/dashboard/search_item.dart';
import 'package:filmtrack/src/features/core/screens/settings/settings_screen.dart';
import 'package:filmtrack/src/features/core/screens/to_watch_list/to_watch_list_screen.dart';
import 'package:filmtrack/src/features/core/screens/watched_list/watched_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}
 class _DashboardScreenState extends State<DashboardScreen> {
   String _searchText = '';
   bool _showResults = false;
   final controller = Get.put(DashboardController());
   final GlobalKey _key = GlobalKey();

   double _getYPosition() {
     final RenderBox renderBox = _key.currentContext?.findRenderObject() as RenderBox;
     return renderBox.size.height + tDefaultSizeDouble;
   }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
          Column(
            children: [
              TextField(
                key: _key,
                controller: controller.searchText,
                onSubmitted: (value) {
                  setState(() {
                    // controller.calculateRecommendations();
                    _searchText = value.trim();
                    _showResults = value.isNotEmpty;
                  });
                },
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: tSearchHint,
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _searchText = '';
                          controller.searchText.clear();
                          _showResults = false;
                        });
                      },
                      icon: const Icon(Icons.cancel_rounded),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(tDefaultSize),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(tDefaultSize)),
              ),

              const SizedBox(height: tDefaultSizeDouble * 4),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => Get.to(() => ToWatchListScreen()),
                    child: const Text(tToWatchList)),
              ),
              const SizedBox(height: tDefaultSize * 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => Get.to(() => WatchedListScreen()),
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
            ],
        ),
        if (_showResults) Positioned(
          top: _getYPosition(),
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(tDefaultSize)
            ),
            child: SingleChildScrollView(
              child: FutureBuilder(
                  future: controller.getSearchResults(_searchText),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Text("Loading...",style:
                      Theme.of(context).textTheme.bodySmall);
                    } else {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}', style:
                        Theme.of(context).textTheme.bodySmall);
                      } else {
                        if (snapshot.hasData && snapshot.data != null) {
                          List<Widget> searchResults = [];
                          for (MediaModel result in snapshot.data!) {
                            searchResults.add(
                              SearchItem(mediaModel: result),
                            );
                          }
                          return Align(alignment: Alignment.topCenter, child: Column(children: searchResults));
                        } else {
                          return Text('No results');
                        }
                      }
                    }
                  }),
            ),
          ),
        ),
      ],
    );
  }
}

