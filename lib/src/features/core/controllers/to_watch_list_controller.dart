import 'package:filmtrack/src/features/authentication/models/user_model.dart';
import 'package:filmtrack/src/features/core/models/media_model.dart';
import 'package:filmtrack/src/repository/authentication_repository/authentication_repository.dart';
import 'package:filmtrack/src/repository/media_repository/media_repository.dart';
import 'package:filmtrack/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';

class ToWatchListController extends GetxController {
  static ToWatchListController get instance => Get.find();

  final _userRepo = Get.put(UserRepository());
  final _authRepo = Get.put(AuthenticationRepository());
  final _mediaRepo = Get.put(MediaRepository());

  final List toWatchMovies = [];
  final List toWatchShows = [];

  getToWatchList() async {
    final uid = _authRepo.firebaseUser.value?.uid;
    if (uid != null) {
      UserModel user = await _userRepo.getUserData(uid);
      toWatchMovies.clear();
      toWatchShows.clear();
      for (var id in user.toWatchMovies) {
        final movieData = await _mediaRepo.getMediaData(id);
        toWatchMovies.add(movieData);
      }
      for (var id in user.toWatchShows) {
        final showData = await _mediaRepo.getMediaData(id);
        toWatchShows.add(showData);
      }
    }
  }

  addToWatchedList(MediaModel media, int rating) async {
    final uid = _authRepo.firebaseUser.value?.uid;
    if (uid != null) {
      UserModel user = await _userRepo.getUserData(uid);
      if (media.mediaType == "tv") {
        user.toWatchShows.remove(media.id);
        user.watchedShows.add(RatingModel(mediaId: media.id, rating: rating));
      } else {
        user.toWatchMovies.remove(media.id);
        user.watchedMovies.add(RatingModel(mediaId: media.id, rating: rating));
      }
      await _userRepo.updateUserRecord(user);
    }
  }
}