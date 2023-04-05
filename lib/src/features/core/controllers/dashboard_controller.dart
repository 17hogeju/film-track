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
  late Function(String) snackbarFunction;
  late Function() refreshFunction;

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
    String snackText = "";
    if (uid != null) {
      UserModel user = await _userRepo.getUserData(uid);
      if (media.mediaType == "tv") {
        user.toWatchShows.add(media.id);
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
    String snackText = "";
    if (uid != null) {
      UserModel user = await _userRepo.getUserData(uid);
      if (media.mediaType == "tv") {
        user.watchedShows.add(RatingModel(mediaId: media.id, rating: rating));
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
        List<MediaModel?> mediaData = await _mediaRepo.getMediaDataByTitleL(titleL);
        if (mediaData.isNotEmpty) {
          for (MediaModel? item in mediaData){
            res.add(item!);
          }
        }
      }
      return res;
    } else {

      return [];
    }

  }


  Future<List<dynamic>> calculateRecommendations(List<dynamic> toWatch, List<dynamic> watched, List<dynamic> pastRecs, String mediaType) async {
    const String url = 'http://192.168.200.226:8000';
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