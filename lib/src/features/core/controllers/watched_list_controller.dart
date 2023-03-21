import 'package:filmtrack/src/features/authentication/models/user_model.dart';
import 'package:filmtrack/src/repository/authentication_repository/authentication_repository.dart';
import 'package:filmtrack/src/repository/media_repository/media_repository.dart';
import 'package:filmtrack/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';

class WatchedListController extends GetxController {
  static WatchedListController get instance => Get.find();

  final _userRepo = Get.put(UserRepository());
  final _authRepo = Get.put(AuthenticationRepository());
  final _mediaRepo = Get.put(MediaRepository());

  final List watchedMovies = [];
  final List watchedShows = [];

  getToWatchList() async {
    final uid = _authRepo.firebaseUser.value?.uid;
    if (uid != null) {
      UserModel user = await _userRepo.getUserData(uid);
      watchedMovies.clear();
      watchedShows.clear();
      for (var id in user.watchedMovies) {
        final movieData = await _mediaRepo.getMediaData(id);
        watchedMovies.add(movieData);
      }
      for (var id in user.watchedShows) {
        final showData = await _mediaRepo.getMediaData(id);
        watchedShows.add(showData);
      }
    }
  }
}