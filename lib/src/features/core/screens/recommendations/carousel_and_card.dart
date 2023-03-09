import 'package:filmtrack/src/features/core/models/media_model.dart';
import 'package:filmtrack/src/features/core/screens/recommendations/indicators.dart';
import 'package:flutter/material.dart';

class CarouselAndCard extends StatefulWidget {
  const CarouselAndCard({Key? key, required this.mediaList}) : super(key: key);

  final List mediaList;


  @override
  State<CarouselAndCard> createState() => _CarouselAndCardState();
}

class _CarouselAndCardState extends State<CarouselAndCard> {
  late PageController pageController;
  int activePage = 0;
  late List<Image> images = [];
  final String url = "https://image.tmdb.org/t/p/w500";



  @override
  void initState() {
    super.initState();
    activePage = 0;
    pageController = PageController(viewportFraction: 0.7);
    for (MediaModel item in widget.mediaList) {
      images.add(Image.network(url + item.posterPath));
    }
  }

  @override
  void didUpdateWidget(CarouselAndCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mediaList != widget.mediaList) {
      setState(() {
        images.clear();
        for (MediaModel item in widget.mediaList) {
          images.add(Image.network(url + item.posterPath));
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    images.clear();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
            children: [
              SizedBox(
                  width: width,
                  height: 400,
                  child: PageView.builder(
                      itemCount: widget.mediaList.length,
                      pageSnapping: true,
                      controller: pageController,
                      onPageChanged: (page) {
                        setState(() {
                          activePage = page;
                        });
                      },
                      itemBuilder: (context, pagePosition) {
                        return Container(
                            margin: const EdgeInsets.all(30),
                            alignment: Alignment.topCenter,
                            child: images[pagePosition]);
                      })),
              Indicators(totalNum: widget.mediaList.length, currIndex: activePage),
            ],
          // )),
          // Container(
          //   height: 400,
          //   padding: const EdgeInsets.only(left: 10, right: 10),
          //   child: RecommendationsContainer(
          //       title: widget.mediaList[activePage]["title"],
          //       genres: widget.mediaList[activePage]["genres"],
          //       description: widget.mediaList[activePage]["overview"]),
          // )
    );
  }
}


