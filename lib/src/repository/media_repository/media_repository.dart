import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmtrack/src/features/core/models/media_model.dart';
import 'package:get/get.dart';

class MediaRepository extends GetxController {
  static MediaRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<MediaModel> getMediaData(int id) async {
    var doc = await _db.collection("media").doc(id.toString()).get();
    var mediaData = MediaModel.fromSnapshot(doc);
    return mediaData;

  }
}