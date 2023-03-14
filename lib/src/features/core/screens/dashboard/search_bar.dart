import 'package:filmtrack/src/constants/colors.dart';
import 'package:filmtrack/src/features/core/controllers/search_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBar extends StatelessWidget {
  SearchBar({Key? key, required this.hintText}) : super(key: key);

  final String hintText;
  final controller = Get.put(SearchBarController());

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      onSubmitted: (search) {
        var q = controller.getSearchResults("All in Good Faith").then((result) {
          print(result.title);
        });
      },
      decoration: InputDecoration(
        fillColor: tWhiteColor,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        hintText: hintText,
      ),
    );
  }
}
