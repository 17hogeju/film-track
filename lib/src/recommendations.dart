import 'package:flutter/material.dart';
import 'datarepo.dart';

class Recommendations extends StatelessWidget {
  Recommendations({super.key});
  final DataRepository repository = DataRepository();
  final List mediaList = [];

  Future<List> getList() async {
    List<String> ids = ["100088", "10009", "10020"];
    for (var id in ids) {
      var item = await repository.getMediaItem(id) as List;
      String genres = await convertGenreIds(item[0]["genre_ids"]);
      item[0]['genres'] = genres;
      mediaList.add(item[0]);
    }
    return mediaList;
  }

  Future<String> convertGenreIds(ids) async {
    List<String> genresList = [];
    String genreString = "";

    for (var id in ids) {
      var genre = await repository.getGenre(id.toString()) as List;
      genresList.add(genre[0]["name"]);
    }

    for (var genre in genresList) {
      genreString += ' $genre •';
    }

    return genreString.substring(1, genreString.length - 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: Colors.black),
          backgroundColor: Colors.white,
          title: const Text(
            'Recommendations',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
        body: FutureBuilder<List>(
            future: getList(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text('loading...'));
              } else {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return CarouselAndCard(mediaList: mediaList);
                }
              }
            }));
  }
}

class RecommendationsContainer extends StatelessWidget {
  const RecommendationsContainer(
      {super.key,
      required this.title,
      required this.genres,
      required this.description});

  final String title;
  final String genres;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Card(
            color: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              children: [
                const Buttons(),
                const Padding(padding: EdgeInsets.only(bottom: 25)),
                Title(title: title),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
                const Divider(
                    indent: 100,
                    endIndent: 100,
                    height: .005,
                    thickness: 1.5,
                    color: Colors.black),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
                Genre(genres: genres),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Description(description: description),
              ],
            )));
  }
}

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: IconButton(
              onPressed: () {},
              icon: Image.asset(
                "assets/images/dislike.png",
                fit: BoxFit.cover,
              ))),
      Expanded(
          child: IconButton(
              onPressed: () {},
              icon: Image.asset(
                "assets/images/star.png",
                fit: BoxFit.cover,
              ))),
      Expanded(
          child: IconButton(
              onPressed: () {},
              icon: Image.asset(
                "assets/images/pin.png",
                fit: BoxFit.cover,
              ))),
      Expanded(
          child: IconButton(
              onPressed: () {},
              icon: Image.asset(
                "assets/images/like.png",
                fit: BoxFit.cover,
              ))),
    ]);
  }
}

class Title extends StatelessWidget {
  const Title({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: FractionallySizedBox(
                widthFactor: 1.6,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )))
      ],
    );
  }
}

class Genre extends StatelessWidget {
  const Genre({super.key, required this.genres});

  final String genres;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: FractionallySizedBox(
                widthFactor: 1.6,
                child: Text(
                  genres,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                )))
      ],
    );
  }
}

class Description extends StatelessWidget {
  const Description({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Flexible(
            child: FractionallySizedBox(
          widthFactor: 0.52,
        )),
        Flexible(
            child: FractionallySizedBox(
                widthFactor: 1.8,
                child: Text(description,
                    style: const TextStyle(color: Colors.black, fontSize: 17))))
      ],
    );
  }
}

class CarouselAndCard extends StatefulWidget {
  const CarouselAndCard({super.key, required this.mediaList});

  final List mediaList;

  @override
  State<CarouselAndCard> createState() => CarouselAndCardState();
}

class CarouselAndCardState extends State<CarouselAndCard> {
  final String url = "https://image.tmdb.org/t/p/w500";
  late PageController pageController;
  late List<Image> images = [];
  int activePage = 0;
  String activeMediaType = "movies";

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.7);
    for (var item in widget.mediaList) {
      images.add(Image.network(url + item["poster_path"]));
    }
    // get list of media IDs to recommend
  }

  Widget mediaButton(String mediaType, bool isFirst) {
    return Align(
        child: SizedBox(
            width: 75,
            height: 27,
            child: TextButton(
              onPressed: () {
                setState(() {
                  activePage = 0;
                  activeMediaType = mediaType;
                });
              },
              style: TextButton.styleFrom(
                  side: BorderSide(
                      width: 1.0,
                      color: activeMediaType == mediaType
                          ? const Color.fromRGBO(120, 132, 248, 1)
                          : const Color.fromRGBO(100, 100, 100, 1)),
                  foregroundColor: activeMediaType == mediaType
                      ? const Color.fromRGBO(120, 132, 248, 1)
                      : const Color.fromRGBO(100, 100, 100, 1),
                  backgroundColor: activeMediaType == mediaType
                      ? const Color.fromRGBO(217, 221, 255, 1)
                      : const Color.fromRGBO(217, 217, 217, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft:
                              isFirst ? const Radius.circular(30) : Radius.zero,
                          bottomLeft:
                              isFirst ? const Radius.circular(30) : Radius.zero,
                          topRight:
                              isFirst ? Radius.zero : const Radius.circular(30),
                          bottomRight: isFirst
                              ? Radius.zero
                              : const Radius.circular(30)))),
              child: Text(mediaType,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w700)),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 15),
        child: ListView(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              mediaButton("Movies", true),
              mediaButton("Shows", false)
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 22),
          ),
          SizedBox(
              height: 440,
              child: Column(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                      child: PageView.builder(
                          itemCount: images.length,
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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: indicators(images.length, activePage))
                ],
              )),
          Container(
            height: 400,
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: RecommendationsContainer(
                title: widget.mediaList[activePage]["title"],
                genres: widget.mediaList[activePage]["genres"],
                description: widget.mediaList[activePage]["overview"]),
          )
        ]));
  }
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: const EdgeInsets.all(3),
      alignment: Alignment.topCenter,
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index ? Colors.black : Colors.black26,
          shape: BoxShape.circle),
    );
  });
}
