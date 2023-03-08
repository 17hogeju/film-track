import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmtrack/src/features/authentication/models/user_model.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user,String uid) async {
    await _db.collection("user_data").doc(uid).set(user.toJson());
  }

  Future<UserModel> getUserData(String uid) async {
    var doc = await _db.collection("user_data").doc(uid).get();
    var userData = UserModel.fromSnapshot(doc);
    return userData;

  }
}
