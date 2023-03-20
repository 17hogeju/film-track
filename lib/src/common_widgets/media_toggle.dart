import 'package:filmtrack/src/constants/colors.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:flutter/material.dart';

class MediaToggleWidget extends StatefulWidget {
  const MediaToggleWidget(
      {Key? key, required this.moviesWidget, required this.showsWidget})
      : super(key: key);

  final Widget moviesWidget, showsWidget;

  @override
  State<MediaToggleWidget> createState() => _MediaToggleWidgetState();
}

class _MediaToggleWidgetState extends State<MediaToggleWidget> {
  bool _isMovies = true;

  void _onToggleTapped(bool isMovie) {
    setState(() {
      if ((_isMovies && !isMovie) || (!_isMovies && isMovie)) {
        _isMovies = !_isMovies;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          Text(
            "${ _isMovies ? tMovies : tShows} $tUntilRefresh ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: tDarkColorVariant
            ),
          ),
          const SizedBox(height: tDefaultSize,),
          // Toggle
          Row(
            children: [
              buildToggleHalf(true, tMovies, const BorderRadius.only(
                  topLeft: Radius.circular(tDefaultSize),
                  bottomLeft: Radius.circular(tDefaultSize)),),
              buildToggleHalf(false, tShows, const BorderRadius.only(
                  topRight: Radius.circular(tDefaultSize),
                  bottomRight: Radius.circular(tDefaultSize)),)
            ],),
          const SizedBox(height: tDefaultSize,),
          _isMovies ? widget.moviesWidget : widget.showsWidget
        ]),
    );
  }

  Expanded buildToggleHalf(isMovies, toggleText, borderRadius) {
    return Expanded(
          child: Material(
            borderRadius: borderRadius,
            elevation: 2.0,
            color:  isMovies ? (_isMovies ? tPrimaryColor : Colors.white) : (!_isMovies ? tPrimaryColor : Colors.white),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
              ),
              child: InkWell(
                  onTap: () => _onToggleTapped(isMovies),
                  borderRadius: borderRadius,
                  child: Container(
                      padding: const EdgeInsets.all(tDefaultSize),
                      child: Center(
                          child: Text(
                        toggleText,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isMovies ? (_isMovies ? Colors.white : Colors.grey) : (!_isMovies ? Colors.white : Colors.grey)),
                      )))),
            ),
          ),
        );
  }
}
