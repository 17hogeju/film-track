import 'dart:ui';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:filmtrack/src/features/core/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBarWithDropdownOverlay extends StatefulWidget {
  const SearchBarWithDropdownOverlay({super.key});

  @override
  State<SearchBarWithDropdownOverlay> createState() =>
      _SearchBarWithDropdownOverlayState();
}

class _SearchBarWithDropdownOverlayState
    extends State<SearchBarWithDropdownOverlay> {
  OverlayEntry? overlayEntry;
  GlobalKey globalKey = GlobalKey();
  final controller = Get.put(DashboardController());
  String prevQuery = "";

  @override
  void initState() {
    super.initState();
    prevQuery = "";
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      globalKey;
    });

  }

  _createOverlay() {
    RenderBox? renderBox =
    globalKey.currentContext!.findRenderObject() as RenderBox?;
    Offset position = renderBox!.localToGlobal(Offset.zero);
    var size = MediaQuery.of(context).size;

    OverlayState? overlayState = Overlay.of(context);


    overlayEntry =  OverlayEntry(
        builder: (context) => Positioned(
          width: size.width - tDefaultSizeDouble ,
          top: position.dy + renderBox.size.height + tDefaultSize,
          left: tDefaultSize,
          child: Container(
            height: size.height * 0.5,
            padding: EdgeInsets.all(tDefaultSize),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(tDefaultSize),
            ),
            // padding: EdgeInsets.all(tDefaultSize),
            child: FutureBuilder(
                future: DashboardController.instance
                    .getSearchResults(controller.searchText.text.trim()),
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
                      return ListView(
                        children: <Widget>[
                          for (var txt in controller.searchResults)
                            Text(txt,
                                style:
                                Theme.of(context).textTheme.bodySmall)
                        ],
                      );
                    }
                  }
                }),
          ),
        ));
    // controller.addListener(() {
    //   overlayState!.setState(() {});
    // });
    overlayState!.insert(overlayEntry!);
  }


  @override
  Widget build(BuildContext context) {
    return TextField(
      key: globalKey,
      controller: controller.searchText,
      onSubmitted: (query) {
        if (prevQuery != query && overlayEntry != null) {
          overlayEntry!.remove();
          prevQuery = query;
        }
        _createOverlay();
      },
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: tSearchHint,
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: IconButton(
            onPressed: () {
              controller.searchText.clear();
              overlayEntry!.remove();
            },
            icon: const Icon(Icons.cancel_rounded),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(tDefaultSize),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.all(tDefaultSize)),
    );
  }
}
