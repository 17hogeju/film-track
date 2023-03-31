import 'package:filmtrack/src/constants/titles.dart';
import 'package:filmtrack/src/features/authentication/models/user_model.dart';
import 'package:filmtrack/src/features/core/models/media_model.dart';
import 'package:filmtrack/src/repository/authentication_repository/authentication_repository.dart';
import 'package:filmtrack/src/repository/media_repository/media_repository.dart';
import 'package:filmtrack/src/repository/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  final _mediaRepo = Get.put(MediaRepository());
  final _userRepo = Get.put(UserRepository());
  final _authRepo = Get.put(AuthenticationRepository());

  final searchText = TextEditingController();

  List<int> computeLPS(String pattern) {
    int m = pattern.length;
    List<int> lps = List<int>.filled(m, 0);

    int prefLen = 0;
    int i = 1;

    while (i < m) {
      if (pattern[i] == pattern[prefLen]) {
        prefLen++;
        lps[i] = prefLen;
        i++;
      } else if (prefLen != 0) {
        prefLen = lps[prefLen - 1];
      } else {
        lps[i] = 0;
        i++;
      }
    }
    return lps;
  }

  int kmp(String text, String pattern) {
    int n = text.length;
    int m = pattern.length;

    if (m == 0) {
      return 0;
    }

    List<int> lps = computeLPS(pattern);
    int i = 0;
    int j = 0;
    int counter = 0;

    while (i < n) {
      if (text[i] == pattern[j]) {
        i++;
        j++;
      } else if (text[i] != pattern[j] && j != 0) {
        j = lps[j - 1];
      } else {
        i++;
      }

      if (j == m) {
        counter++;
        j = 0;
      }
    }
    return counter;
  }

  addToWatchList(MediaModel media) async {
    final uid = _authRepo.firebaseUser.value?.uid;
    if (uid != null) {
      UserModel user = await _userRepo.getUserData(uid);
      if (media.mediaType == "tv") {
        user.toWatchShows.add(media.id);
        user.showsTilRefresh -= 1;
        if (user.showsTilRefresh == 0) {
          user.showsTilRefresh = 5;
          // refresh recs
        }
      } else {
        user.toWatchMovies.add(media.id);
        user.moviesTilRefresh -= 1;
        if (user.moviesTilRefresh == 0) {
          user.moviesTilRefresh = 5;
          // refresh recs
        }
      }
      //update user count
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
        if (user.showsTilRefresh == 0) {
          user.showsTilRefresh = 5;
          // refresh recs
        }
      } else {
        user.watchedMovies.add(RatingModel(mediaId: media.id, rating: rating));
        user.moviesTilRefresh -= 1;
        if (user.moviesTilRefresh == 0) {
          user.moviesTilRefresh = 5;
          // refresh recs
        }
      }
      await _userRepo.updateUserRecord(user);
    }
  }

  calculateRecommendations() async {
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
        'media_type': 'movie',
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

  Future<List<MediaModel>> getSearchResults(searchQuery) async {
    List<String> titles = [];
    List<MediaModel> res = [];
    if (searchQuery != null) {
      for (var title in tTitlesLowercase) {
        if (kmp(title, searchQuery) != 0) {
          titles.add(title);
        }
      }
    }
    if (titles.isNotEmpty && titles != null) {
      for (var titleL in titles) {
        final mediaData = await _mediaRepo.getMediaDataByTitleL(titleL);
        if (mediaData != null) {
          res.add(mediaData);
        }
      }
      return res;
    } else {
      return [];
    }
  }
}
