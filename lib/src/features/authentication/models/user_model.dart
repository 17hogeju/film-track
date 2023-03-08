import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final List<dynamic> disliked;
  final List<dynamic> pastRecs;
  final List<dynamic> currRecs;
  final List<dynamic> toWatchMovies;
  final List<dynamic> toWatchShows;
  final List<dynamic> watchedMovies;
  final List<dynamic> watchedShows;

  const UserModel({
    this.disliked = const [],
    this.currRecs = const [],
    this.pastRecs = const [],
    this.toWatchMovies = const [],
    this.toWatchShows = const [],
    this.watchedMovies = const [],
    this.watchedShows = const []
});

  toJson(){
    return {
      "disliked": disliked,
      "pastRecs": pastRecs,
      "currRecs": currRecs,
      "toWatchMovies": toWatchMovies,
      "toWatchShows": toWatchShows,
      "watchedMovies": watchedMovies,
      "watchedShows": watchedShows
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      disliked: data["disliked"],
      pastRecs: data["pastRecs"],
      currRecs: data["currRecs"],
      toWatchMovies: data["toWatchMovies"],
      toWatchShows: data["toWatchShows"],
      watchedMovies: data["watchedMovies"],
      watchedShows: data["watchedShows"]
    );
  }
}