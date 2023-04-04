import 'package:filmtrack/src/features/authentication/models/user_model.dart';
import 'package:filmtrack/src/repository/authentication_repository/authentication_repository.dart';
import 'package:filmtrack/src/repository/user_repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final _authRepo = Get.put(AuthenticationRepository());

  void registerUser(String email, String password) async {
    _authRepo.registerUserWithEmailAndPassword(email, password);
  }

  void loginUser(String email, String password) {
    _authRepo.loginUserWithEmailAndPassword(email, password);
  }

  void logOut() {
    AuthenticationRepository.instance.logout();
  }

}