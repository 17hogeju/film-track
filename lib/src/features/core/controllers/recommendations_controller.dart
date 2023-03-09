import 'package:filmtrack/src/features/authentication/models/user_model.dart';
import 'package:filmtrack/src/repository/authentication_repository/authentication_repository.dart';
import 'package:filmtrack/src/repository/media_repository/media_repository.dart';
import 'package:filmtrack/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';

class RecommendationsController extends GetxController {
  static RecommendationsController get instance => Get.find();

  final _userRepo = Get.put(UserRepository());
  final _authRepo = Get.put(AuthenticationRepository());
  final _mediaRepo = Get.put(MediaRepository());

  final List movieRecommendations = [];
  final List showRecommendations = [];

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



  // getMediaData(int id) {
  //   return _mediaRepo.getMediaData(id);
  // }



}