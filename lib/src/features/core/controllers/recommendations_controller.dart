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

  getUserID() async {
    final uid = _authRepo.firebaseUser.value?.uid;
    return uid;
  }

  resetMediaCount(String mediaType) async {
    final uid = _authRepo.firebaseUser.value?.uid;
    if (uid != null) {
      UserModel user = await _userRepo.getUserData(uid);
      if (mediaType == "shows") {
        user.showsTilRefresh = 5;
      } else {
        user.moviesTilRefresh = 5;
      }
      await _userRepo.updateUserRecord(user);
    }
  }

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
        user.showsTilRefresh -= 1;
        user.currShowRecs.remove(media.id);
        user.pastShowRecs.add(media.id);
      } else {
        user.toWatchMovies.add(media.id);
        user.moviesTilRefresh -= 1;
        user.currMovieRecs.remove(media.id);
        user.pastMovieRecs.add(media.id);
      }
      await _userRepo.updateUserRecord(user);
    }
  }

  addToWatchedList(MediaModel media, int rating) async {
    final uid = _authRepo.firebaseUser.value?.uid;
    if (uid != null) {
      UserModel user = await _userRepo.getUserData(uid);
      if (media.mediaType == "tv") {
        user.watchedShows.add(RatingModel(mediaId: media.id, rating: rating));
        user.showsTilRefresh -= 1;
        user.currShowRecs.remove(media.id);
        user.pastShowRecs.add(media.id);
      } else {
        user.watchedMovies.add(RatingModel(mediaId: media.id, rating: rating));
        user.moviesTilRefresh -= 1;
        user.currMovieRecs.remove(media.id);
        user.pastMovieRecs.add(media.id);
      }
      await _userRepo.updateUserRecord(user);
    }
  }

  calculateRecommendations(String mediaType) async {
    final uid = _authRepo.firebaseUser.value?.uid;
    const String url = 'https://filmtrack.loca.lt';
    var indeces = [];
    var pastRecs = [];
    if (uid != null) {
      UserModel user = await _userRepo.getUserData(uid);
      for (var id in user.toWatchMovies) {
        indeces.add(id);
      }
      for (RatingModel item in user.watchedMovies) {
        indeces.add(item.mediaId);
      }

      Map<String, dynamic> data = {
        'media_type': mediaType,
        'data': indeces,
        'past_recs': pastRecs,
      };

      String jsonData = json.encode(data);

      Map<String, String> headers = {
        'Content-Length': utf8.encode(jsonData).length.toString(),
        'Content-Type': 'application/json',
      };

      try {
        http.Response response = await http.post(
          Uri.parse(url),
          body: jsonData,
          headers: headers,
        );

        var res = json.decode(response.body);
        List<int> real_res =
            List<int>.from(res['result'].map((x) => int.parse(x)));
        user.currMovieRecs = real_res;

        // print(res["result"]);
      } catch (e) {
        throw Exception('Request failed: $e');
      }
      await _userRepo.updateUserRecord(user);
    }
  }
}
