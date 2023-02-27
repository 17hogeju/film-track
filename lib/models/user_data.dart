import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmtrack/models/past_rec.dart';

class UserData {
  final String uid;
  List<int>? toWatchMovies = [];
  List<int>? toWatchShows = [];
  List<int>? watchedMovies = [];
  List<int>? watchedShows = [];
  List<PastRec>? pastRecs = [];

  UserData(
      {required this.uid,
        this.toWatchMovies,
        this.toWatchShows,
        this.watchedMovies,
        this.watchedShows,
        this.pastRecs});

  Map<String, dynamic> toMap() {
    return {
      'to_watch_movies': toWatchMovies,
      'to_watch_shows': toWatchShows,
      'watched_movies': watchedMovies,
      'watched_shows': watchedShows,
      'past_recs': pastRecs
    };
  }

  UserData.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uid = doc.id,
        toWatchMovies = doc.data()?["to_watch_movies"]?.cast<int>(),
        toWatchShows = doc.data()?["to_watch_shows"]?.cast<int>(),
        watchedMovies = doc.data()?["watched_movies"]?.cast<int>(),
        watchedShows = doc.data()?["watched_shows"]?.cast<int>(),
        pastRecs = doc.data()?["past_recs"]?.cast<PastRec>();

}