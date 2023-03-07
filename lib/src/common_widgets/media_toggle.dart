import 'package:filmtrack/src/constants/colors.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:flutter/material.dart';

class MediaToggleWidget extends StatefulWidget {
  const MediaToggleWidget(
      {Key? key, required this.moviesWidget, required this.showsWidget})
      : super(key: key);
  // const MediaToggle({Key? key}) : super(key: key);
  final Widget moviesWidget, showsWidget;

  @override
  State<MediaToggleWidget> createState() => _MediaToggleWidgetState();
}

class _MediaToggleWidgetState extends State<MediaToggleWidget> {
  bool _isMovies = true;
  bool get isMovies => _isMovies;

  void _onToggleTapped(bool isMovie) {
    setState(() {
      if ((_isMovies && !isMovie) || (!_isMovies && isMovie)) {
        _isMovies = !_isMovies;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Toggle
      Row(
        children: [
          // Movies
          Expanded(
            child: Material(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(tDefaultSize),
                  bottomLeft: Radius.circular(tDefaultSize)),
              elevation: 2.0,
              color: _isMovies ? tPrimaryColor : Colors.white,
              child: Ink(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(tDefaultSize),
                      bottomLeft: Radius.circular(tDefaultSize)),
                ),
                child: InkWell(
                    onTap: () => _onToggleTapped(true),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(tDefaultSize),
                        bottomLeft: Radius.circular(tDefaultSize)),
                    child: Container(
                        padding: const EdgeInsets.all(tDefaultSize),
                        child: Center(
                            child: Text(
                          "Movies",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _isMovies ? Colors.white : Colors.grey),
                        )))),
              ),
            ),
          ),
          // Shows
          Expanded(
            child: Material(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(tDefaultSize),
                  bottomRight: Radius.circular(tDefaultSize)),
              elevation: 2.0,
              color: !_isMovies ? tPrimaryColor : Colors.white,
              child: Ink(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(tDefaultSize),
                      bottomRight: Radius.circular(tDefaultSize)),
                ),
                child: InkWell(
                    onTap: () => _onToggleTapped(false),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(tDefaultSize),
                        bottomRight: Radius.circular(tDefaultSize)),
                    child: Container(
                        padding: const EdgeInsets.all(tDefaultSize),
                        child: Center(
                            child: Text(
                          "Shows",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: !_isMovies ? Colors.white : Colors.grey),
                        )))),
              ),
            ),
          ),
        ],),
      const SizedBox(height: tDefaultSize,),
      _isMovies ? widget.moviesWidget : widget.showsWidget
    ]);
  }
}
