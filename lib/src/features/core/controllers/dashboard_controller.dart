import 'package:filmtrack/src/features/core/models/title_model.dart';
import 'package:filmtrack/src/repository/media_repository/media_repository.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  final _mediaRepo = Get.put(MediaRepository());
  final List queryResults = [];

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

  getSearchResults(userQuery) async {
    queryResults.clear();
    TitleModel mediaTitles = await _mediaRepo.getMediaTitles();
    var titles = mediaTitles.titles;
    for (var title in titles){
      if (kmp(title, userQuery) != 0) {
        queryResults.add(title);
      }
    }
  }


}