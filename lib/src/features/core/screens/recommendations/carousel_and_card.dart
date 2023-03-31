import 'package:filmtrack/src/features/core/models/media_model.dart';
import 'package:filmtrack/src/features/core/screens/recommendations/indicators.dart';
import 'package:filmtrack/src/features/core/screens/recommendations/rec_card.dart';
import 'package:filmtrack/src/features/core/screens/recommendations/no_recommendations.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/features/core/screens/recommendations/media_items.dart';
import 'package:flutter/material.dart';

class CarouselAndCard extends StatefulWidget {
  const CarouselAndCard({
    Key? key,
    required this.mediaList,
    required this.mediaType,
  }) : super(key: key);

  final List mediaList;
  final String mediaType;

  @override
  State<CarouselAndCard> createState() => _CarouselAndCardState();
}

class _CarouselAndCardState extends State<CarouselAndCard> {
  final PageController pageController =
      PageController(viewportFraction: carouselViewportFrac, initialPage: 0);
  int activePage = 0;
  late List<Image> images = [];
  late List mediaItems;
  final String url = "https://image.tmdb.org/t/p/w500";
  late String currMediaType;

  @override
  void initState() {
    super.initState();
    currMediaType = widget.mediaType;
    activePage = 0;
    mediaItems = widget.mediaList;
    for (MediaModel item in mediaItems) {
      images.add(Image.network(url + item.posterPath));
    }
  }

  @override
  void didUpdateWidget(CarouselAndCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mediaList != widget.mediaList) {
      setState(() {
        mediaItems = widget.mediaList;
        activePage = 0;
        images.clear();
        for (MediaModel item in mediaItems) {
          images.add(Image.network(url + item.posterPath));
        }
      });
    }
  }

  void addToListUpdate(MediaModel media) {
    setState(() {
      images.clear();
      for (MediaModel item in mediaItems) {
        if (item.id != media.id) {
          images.add(Image.network(url + item.posterPath));
        }
      }
      mediaItems.removeAt(activePage);

      if (activePage > mediaItems.length) {
        activePage -= 1;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    images.clear();
  }

  @override
  Widget build(BuildContext context) {
    print(currMediaType);
    var width = MediaQuery.of(context).size.width;
    return mediaItems.isEmpty
        ? NoRecommendations(mediaType: widget.mediaType)
        : MediaItemsManager(
            data: MediaItems(null, addToListUpdate),
            child: Column(children: [
              SizedBox(
                  width: width,
                  height: carouselHeight,
                  child: PageView.builder(
                      itemCount: mediaItems.length,
                      pageSnapping: true,
                      controller: pageController,
                      onPageChanged: (page) {
                        setState(() {
                          activePage = page;
                        });
                      },
                      itemBuilder: (context, pagePosition) {
                        return Container(
                            margin: const EdgeInsets.all(imageMargin),
                            alignment: Alignment.topCenter,
                            child: images[pagePosition]);
                      })),
              Indicators(totalNum: mediaItems.length, currIndex: activePage),
              Container(
                  padding: const EdgeInsets.only(
                      left: cardPaddingLeft, right: cardPaddingRight),
                  child: RecCard(
                    media: mediaItems[activePage],
                  ))
            ]));
  }
}
