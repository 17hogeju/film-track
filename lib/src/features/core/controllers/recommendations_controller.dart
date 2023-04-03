import 'package:filmtrack/src/features/authentication/models/user_model.dart';
import 'package:filmtrack/src/features/core/models/media_model.dart';
import 'package:filmtrack/src/repository/authentication_repository/authentication_repository.dart';
import 'package:filmtrack/src/repository/media_repository/media_repository.dart';
import 'package:filmtrack/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RecommendationsController extends GetxController {
  static RecommendationsController get instance => Get.find();

  final _userRepo = Get.put(UserRepository());
  final _authRepo = Get.put(AuthenticationRepository());
  final _mediaRepo = Get.put(MediaRepository());

  final List movieRecommendations = [];
  final List showRecommendations = [];
  late Function(String) snackbarFunction;
  late Function() refreshFunction;

  getMediaRecommendations() async {
    final uid = _authRepo.firebaseUser.value?.uid;
    if (uid != null) {
      UserModel user = await _userRepo.getUserData(uid);
      movieRecommendations.clear();
      showRecommendations.clear();
      for (var id in user.currMovieRecs) {
        final movieData = await _mediaRepo.getMediaData(id);
        movieRecommendations.add(movieData);
      }
      for (var id in user.currShowRecs) {
        final showData = await _mediaRepo.getMediaData(id);
        showRecommendations.add(showData);
      }
    }
  }

  addToWatchList(MediaModel media) async {
    final uid = _authRepo.firebaseUser.value?.uid;
    if (uid != null) {
      UserModel user = await _userRepo.getUserData(uid);
      if (media.mediaType == "tv") {
        user.toWatchShows.add(media.id);
      } else {
        user.toWatchMovies.add(media.id);
      }
      await _userRepo.updateUserRecord(user);
    }
  }

  addToWatchListRec(MediaModel media, int index) async {
    final uid = _authRepo.firebaseUser.value?.uid;
    String snackText = "";
    if (uid != null) {
      UserModel user = await _userRepo.getUserData(uid);
      if (media.mediaType == "tv") {
        user.toWatchShows.add(media.id);
        user.currShowRecs.removeAt(index);
        user.showsTillRefresh -= 1;
        if (user.showsTillRefresh <= 0) {
          user.currShowRecs = await calculateRecommendations(user.toWatchShows, user.watchedShows,user.pastShowRecs, media.mediaType);
          user.showsTillRefresh = 5;
          user.pastShowRecs.addAll(user.currShowRecs);
          snackText = "Added show and refreshed recommendations";
          // dialog tells user there are new recs maybe with refresh button
        } else {
          snackText = "Added show: Add ${user.showsTillRefresh} more to refresh recommendations";
        }
      } else {
        user.toWatchMovies.add(media.id);
        user.currMovieRecs.removeAt(index);
        user.moviesTillRefresh -= 1;
        if (user.moviesTillRefresh <= 0) {
          user.currMovieRecs = await calculateRecommendations(user.toWatchMovies, user.watchedMovies, user.pastMovieRecs, media.mediaType);
          user.moviesTillRefresh = 5;
          user.pastMovieRecs.addAll(user.currMovieRecs);
          snackText = "Added movie and refreshed recommendations";
        }
        else {
          snackText = "Added movie: Add ${user.moviesTillRefresh} more to refresh recommendations";
        }
      }
      snackbarFunction(snackText);
      await _userRepo.updateUserRecord(user);
      refreshFunction();
    }
  }

  addToWatchedList(MediaModel media, int rating) async {
    final uid = _authRepo.firebaseUser.value?.uid;
    if (uid != null) {
      UserModel user = await _userRepo.getUserData(uid);
      if (media.mediaType == "tv") {
        user.watchedShows.add(RatingModel(mediaId: media.id, rating: rating));
      } else {
        user.watchedMovies.add(RatingModel(mediaId: media.id, rating: rating));
      }
      await _userRepo.updateUserRecord(user);
    }
  }

  addToWatchedListRec(MediaModel media, int rating, int index) async {
    final uid = _authRepo.firebaseUser.value?.uid;
    String snackText = "";
    if (uid != null) {
      UserModel user = await _userRepo.getUserData(uid);
      if (media.mediaType == "tv") {
        user.watchedShows.add(RatingModel(mediaId: media.id, rating: rating));
        user.currShowRecs.removeAt(index);
        user.showsTillRefresh -= 1;
        if (user.showsTillRefresh <= 0) {
          user.currShowRecs = await calculateRecommendations(user.toWatchShows, user.watchedShows,user.pastShowRecs, media.mediaType);
          user.showsTillRefresh = 5;
          user.pastShowRecs.addAll(user.currShowRecs);
          snackText = "Added show and refreshed recommendations";
          // dialog tells user there are new recs maybe with refresh button
        } else {
          snackText = "Added show: Add ${user.showsTillRefresh} more to refresh recommendations";
        }
      } else {
        user.watchedMovies.add(RatingModel(mediaId: media.id, rating: rating));
        user.currMovieRecs.removeAt(index);
        user.moviesTillRefresh -= 1;
        if (user.moviesTillRefresh <= 0) {
          user.currMovieRecs = await calculateRecommendations(user.toWatchMovies, user.watchedMovies, user.pastMovieRecs, media.mediaType);
          user.moviesTillRefresh = 5;
          user.pastMovieRecs.addAll(user.currMovieRecs);
          snackText = "Added movie and refreshed recommendations";
        }
        else {
          snackText = "Added movie: Add ${user.moviesTillRefresh} more to refresh recommendations";
        }
        //dia
      }
      snackbarFunction(snackText);
      await _userRepo.updateUserRecord(user);
      refreshFunction();
    }
  }

  Future<List<dynamic>> calculateRecommendations(List<dynamic> toWatch, List<dynamic> watched, List<dynamic> pastRecs, String mediaType) async {
    const String url = 'https://filmtrack.loca.lt';
    var indeces = [];
    var resultList = [];
    for (var id in toWatch) {
      indeces.add(id);
    }
    for (RatingModel item in watched) {
      indeces.add(item.mediaId);
    }

    Map<String, dynamic> data = {
      'media_type': mediaType,
      'data': indeces,
      'past_recs': pastRecs,
    };

    String jsonData = json.encode(data);
    Map<String, String> headers = {
      'Content-Length': utf8
          .encode(jsonData)
          .length
          .toString(),
      'Content-Type': 'application/json',
    };
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: jsonData,
        headers: headers,
      );
      var res = json.decode(response.body);
      resultList = List<int>.from(res['result'].map((x) => int.parse(x)));
    } catch (e) {
      throw Exception('Request failed: $e');
    }
    return resultList;
  }
}