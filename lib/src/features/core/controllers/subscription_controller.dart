import 'package:filmtrack/src/features/authentication/models/user_model.dart';
import 'package:filmtrack/src/features/core/models/provider_model.dart';
import 'package:filmtrack/src/repository/authentication_repository/authentication_repository.dart';
import 'package:filmtrack/src/repository/media_repository/media_repository.dart';
import 'package:filmtrack/src/repository/provider_repository/provider_repository.dart';
import 'package:filmtrack/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  static SubscriptionController get instance => Get.find();

  final _userRepo = Get.put(UserRepository());
  final _authRepo = Get.put(AuthenticationRepository());
  final _mediaRepo = Get.put(MediaRepository());
  final _providerRepo = Get.put(ProviderRepository());

  final List<ProviderModel> toWatchRecommendations = [];
  final List<ProviderModel> watchedRecommendations = [];

  getSubscriptionRecommendations() async {
    final uid = _authRepo.firebaseUser.value?.uid;
    if (uid != null) {
      UserModel user = await _userRepo.getUserData(uid);
      toWatchRecommendations.clear();
      watchedRecommendations.clear();

      var toWatch = [];
      var watched = [];
      if (user.toWatchShows.isNotEmpty) {
        toWatch.addAll(user.toWatchShows);
      }
      if (user.toWatchMovies.isNotEmpty) {
        toWatch.addAll(user.toWatchMovies);
      }
      if (user.watchedShows.isNotEmpty) {
        watched.addAll(user.watchedShows);
      }
      if (user.watchedMovies.isNotEmpty) {
        watched.addAll(user.watchedMovies);
      }
      if (watched.isEmpty || toWatch.isEmpty) {
        return;
      }

      // Combine lists
      Map<int, int> toWatchCountMap = {};
      for (var id in toWatch) {
        final movie = await _mediaRepo.getMediaData(id);
        List<String> providerIds = movie.providerIds.split(" ").toList();
        for (var id in providerIds) {
          if (id.isNotEmpty) {
            var idI = int.parse(id);
            toWatchCountMap.update(idI, (count) => count + 1, ifAbsent: () => 1);
          }
        }
      }

      List<MapEntry<int, int>> toWatchCountList = toWatchCountMap.entries.toList();
      toWatchCountList.sort((a, b) => b.value.compareTo(a.value));
      List<int> toWatchModes = [];
      if (toWatchCountList.length >= 3) {
        toWatchModes = toWatchCountList.sublist(0, 3).map((entry) => entry.key).toList();
      } else {
        toWatchModes = toWatchCountList.map((entry) => entry.key).toList();
      }
      for (var id in toWatchModes) {
        final provider = await _providerRepo.getProviderData(id);
        toWatchRecommendations.add(provider);
      }

      Map<int, int> watchedCountMap = {};
      for (RatingModel data in watched) {
        final movie = await _mediaRepo.getMediaData(data.mediaId);
        List<String> providerIds = movie.providerIds.split(" ").toList();
        for (var id in providerIds) {
          if (id.isNotEmpty) {
            var idI = int.parse(id);
            watchedCountMap.update(idI, (count) => count + 1, ifAbsent: () => 1);
          }
        }
      }

      List<MapEntry<int, int>> watchedCountList = watchedCountMap.entries.toList();
      watchedCountList.sort((a, b) => b.value.compareTo(a.value));
      List<int> watchedModes = [];
      if (watchedCountList.length >= 3) {
        watchedModes = watchedCountList.sublist(0, 3).map((entry) => entry.key).toList();
      } else {
        watchedModes = watchedCountList.map((entry) => entry.key).toList();
      }
      for (var id in watchedModes) {
        final provider = await _providerRepo.getProviderData(id);
        watchedRecommendations.add(provider);
      }

    }
  }
}