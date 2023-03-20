import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final List<dynamic> disliked;
  final List<dynamic> pastMovieRecs;
  final List<dynamic> pastShowRecs;
  final List<dynamic> currMovieRecs;
  final List<dynamic> currShowRecs;
  final List<dynamic> toWatchMovies;
  final List<dynamic> toWatchShows;
  final List<dynamic> watchedMovies;
  final List<dynamic> watchedShows;

  const UserModel({
    this.id,
    this.disliked = const [],
    this.pastMovieRecs = const [],
    this.pastShowRecs = const [],
    this.currMovieRecs = const [],
    this.currShowRecs = const [],
    this.toWatchMovies = const [],
    this.toWatchShows = const [],
    this.watchedMovies = const [],
    this.watchedShows = const []
});

  toJson(){
    return {
      "disliked": disliked,
      "pastMovieRecs": pastMovieRecs,
      "pastShowRecs": pastShowRecs,
      "currMovieRecs": currMovieRecs,
      "currShowRecs": currShowRecs,
      "toWatchMovies": toWatchMovies,
      "toWatchShows": toWatchShows,
      "watchedMovies": watchedMovies,
      "watchedShows": watchedShows
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      disliked: data["disliked"],
      pastMovieRecs: data["pastMovieRecs"],
      pastShowRecs: data["pastShowRecs"],
      currMovieRecs: data["currMovieRecs"],
      currShowRecs: data["currShowRecs"],
      toWatchMovies: data["toWatchMovies"],
      toWatchShows: data["toWatchShows"],
      watchedMovies: data["watchedMovies"],
      watchedShows: data["watchedShows"]
    );
  }
}