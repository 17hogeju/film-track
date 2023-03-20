import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmtrack/src/features/core/models/media_model.dart';
import 'package:filmtrack/src/features/core/models/title_model.dart';
import 'package:get/get.dart';

class MediaRepository extends GetxController {
  static MediaRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<MediaModel> getMediaData(int id) async {
    var doc = await _db.collection("media").doc(id.toString()).get();
    var mediaData = MediaModel.fromSnapshot(doc);
    return mediaData;
  }

  Future<MediaModel?> getMediaDataByTitleL(String titleL) async {
    var doc = await _db.collection("media").where('title_lowercase', isEqualTo: titleL).get().then(
        (querySnapshot) {
          return querySnapshot.docs[0];
        }
    );
    var mediaData = MediaModel.fromQuerySnapshot(doc);
    return mediaData;

  }

  Future<TitleModel> getMediaTitles() async {
    var doc = await _db.collection("titles").doc("titles").get();
    var titleData = TitleModel.fromSnapshot(doc);
    return titleData;
  }

}

