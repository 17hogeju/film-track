import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/features/core/models/provider_model.dart';
import 'package:filmtrack/src/features/core/screens/recommendations/indicators.dart';
import 'package:flutter/material.dart';

class SubCarousel extends StatefulWidget {
  const SubCarousel({Key? key, required this.recommendations}) : super(key: key);

  final List<ProviderModel> recommendations;


  @override
  State<SubCarousel> createState() => _SubCarouselState();
}

class _SubCarouselState extends State<SubCarousel> {
  late PageController pageController;
  int activePage = 0;
  late List<Image> images = [];
  final String url = "https://image.tmdb.org/t/p/w500";

  @override
  void initState() {
    super.initState();
    activePage = 0;
    pageController = PageController(viewportFraction: 0.7);
    for (ProviderModel item in widget.recommendations) {
      images.add(Image.network(url + item.logoPath));
    }
  }

  @override
  void didUpdateWidget(SubCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.recommendations != widget.recommendations) {
      setState(() {
        images.clear();
        for (ProviderModel item in widget.recommendations) {
          images.add(Image.network(url + item.logoPath));
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
            height: 200,
            child: PageView.builder(
                itemCount: widget.recommendations.length,
                pageSnapping: true,
                controller: pageController,
                onPageChanged: (page) {
                  setState(() {
                    activePage = page;
                  });
                },
                itemBuilder: (context, pagePosition) {
                  return Container(
                      decoration: BoxDecoration(color: Colors.white,
                        borderRadius: BorderRadius.circular(tDefaultSize)
                      ),
                      margin: const EdgeInsets.all(30),
                      alignment: Alignment.topCenter,
                      child: images[pagePosition]);
                })),
        Indicators(totalNum: widget.recommendations.length, currIndex: activePage),
      ],
    );
  }
}


