import 'package:filmtrack/src/repository/authentication_repository/authentication_repository.dart';
import 'package:filmtrack/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';

class RecommendationsController extends GetxController {
  static RecommendationsController get instance => Get.find();

  final _userRepo = Get.put(UserRepository());
  final _authRepo = Get.put(AuthenticationRepository());

  getUserData() {
    final uid = _authRepo.firebaseUser.value?.uid;
    if (uid != null) {
      return _userRepo.getUserData(uid);
    }
  }

}