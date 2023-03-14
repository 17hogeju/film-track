import 'package:filmtrack/src/repository/media_repository/media_repository.dart';
import 'package:get/get.dart';

class SearchBarController extends GetxController {
  static SearchBarController get instance => Get.find();

  final _mediaRepo = Get.put(MediaRepository());

  getSearchResults(search) async {
    return await _mediaRepo.getSearchMediaData(search);
  }
}
