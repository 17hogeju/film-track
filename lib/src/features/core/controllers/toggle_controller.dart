import 'package:filmtrack/src/constants/titles.dart';
import 'package:filmtrack/src/features/authentication/models/user_model.dart';
import 'package:filmtrack/src/features/core/models/media_model.dart';
import 'package:filmtrack/src/repository/authentication_repository/authentication_repository.dart';
import 'package:filmtrack/src/repository/media_repository/media_repository.dart';
import 'package:filmtrack/src/repository/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToggleController extends GetxController {
  static ToggleController get instance => Get.find();

  final _userRepo = Get.put(UserRepository());
  final _authRepo = Get.put(AuthenticationRepository());

  int showsTillRefresh = 5;
  int moviesTillRefresh = 5;


  getUser() async {
    final uid = _authRepo.firebaseUser.value?.uid;
    if (uid != null) {
      var temp = await _userRepo.getUserData(uid);
      showsTillRefresh = temp.showsTillRefresh;
      moviesTillRefresh = temp.moviesTillRefresh;
    }
  }
}