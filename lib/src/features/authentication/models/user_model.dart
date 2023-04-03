import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmtrack/src/features/core/models/media_model.dart';

class RatingMediaModel {
  final MediaModel media;
  final int rating;

  RatingMediaModel({required this.media, required this.rating});
}

class RatingModel {
  final int mediaId;
  final int rating;

  RatingModel({required this.mediaId, required this.rating});

  toJson() {
    return {
      "mediaId": mediaId,
      "rating": rating,
    };
  }
}

class UserModel {
  final String id;
  final List<dynamic> pastMovieRecs;
  final List<dynamic> pastShowRecs;
  List<dynamic> currMovieRecs;
  List<dynamic> currShowRecs;
  final List<dynamic> toWatchMovies;
  final List<dynamic> toWatchShows;
  final List<RatingModel> watchedMovies;
  final List<RatingModel> watchedShows;
  int moviesTillRefresh;
  int showsTillRefresh;


  UserModel({
    required this.id,
    this.pastMovieRecs = const [],
    this.pastShowRecs = const [],
    this.currMovieRecs = const [],
    this.currShowRecs = const [],
    this.toWatchMovies = const [],
    this.toWatchShows = const [],
    this.watchedMovies = const [],
    this.watchedShows = const [],
    this.moviesTillRefresh = 5,
    this.showsTillRefresh = 5,
});

  toJson() {
    return {
      "pastMovieRecs": pastMovieRecs,
      "pastShowRecs": pastShowRecs,
      "currMovieRecs": currMovieRecs,
      "currShowRecs": currShowRecs,
      "toWatchMovies": toWatchMovies,
      "toWatchShows": toWatchShows,
      "watchedMovies": watchedMovies.map((e) => e.toJson()),
      "watchedShows": watchedShows.map((e) => e.toJson()),
      "moviesTillRefresh": moviesTillRefresh,
      "showsTillRefresh": showsTillRefresh
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    final watchedMovies = (data["watchedMovies"] as List)
        .map((ratingData) => RatingModel(
            mediaId: ratingData["mediaId"], rating: ratingData["rating"]))
        .toList();
    final watchedShows = (data["watchedShows"] as List)
        .map((ratingData) => RatingModel(
        mediaId: ratingData["mediaId"], rating: ratingData["rating"]))
        .toList();
    return UserModel(
        id: document.id,
        pastMovieRecs: data["pastMovieRecs"],
        pastShowRecs: data["pastShowRecs"],
        currMovieRecs: data["currMovieRecs"],
        currShowRecs: data["currShowRecs"],
        toWatchMovies: data["toWatchMovies"],
        toWatchShows: data["toWatchShows"],
        watchedMovies: watchedMovies,
        watchedShows: watchedShows,
        moviesTillRefresh: data["moviesTillRefresh"],
        showsTillRefresh: data["showsTillRefresh"]);
  }
}
