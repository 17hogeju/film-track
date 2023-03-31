import 'package:filmtrack/src/features/core/models/media_model.dart';
import 'package:flutter/material.dart';

class MediaItems {
  MediaModel? mediaItems;
  Function(MediaModel) updateMediaItems;

  MediaItems(this.mediaItems, this.updateMediaItems);
}

class MediaItemsManager extends InheritedWidget {
  final MediaItems data;

  const MediaItemsManager(
      {super.key, required this.data, required Widget child})
      : super(child: child);

  static MediaItemsManager? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MediaItemsManager>();
  }

  @override
  bool updateShouldNotify(MediaItemsManager oldWidget) {
    return data != oldWidget.data;
  }
}
