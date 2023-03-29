import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmtrack/src/features/core/models/provider_model.dart';
import 'package:get/get.dart';

class ProviderRepository extends GetxController {
  static ProviderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<ProviderModel> getProviderData(int id) async {
    var doc = await _db.collection("providers").doc(id.toString()).get();
    var providerData = ProviderModel.fromSnapshot(doc);
    return providerData;
  }

}

