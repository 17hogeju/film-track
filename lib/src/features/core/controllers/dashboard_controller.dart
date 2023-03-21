import 'package:filmtrack/src/constants/titles.dart';
import 'package:filmtrack/src/features/authentication/models/user_model.dart';
import 'package:filmtrack/src/features/core/models/media_model.dart';
import 'package:filmtrack/src/repository/authentication_repository/authentication_repository.dart';
import 'package:filmtrack/src/repository/media_repository/media_repository.dart';
import 'package:filmtrack/src/repository/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      } else {
        user.toWatchMovies.add(media.id);
      }
      await _userRepo.updateUserRecord(user);
    }
  }

  addToWatchedList(MediaModel media) async {
    final uid = _authRepo.firebaseUser.value?.uid;
    if (uid != null) {
      UserModel user = await _userRepo.getUserData(uid);
      if (media.mediaType == "tv") {
        user.watchedShows.add(media.id);
      } else {
        user.watchedMovies.add(media.id);
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