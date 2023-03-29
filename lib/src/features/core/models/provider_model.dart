import 'package:cloud_firestore/cloud_firestore.dart';

class ProviderModel {
  final int id;
  final String logoPath;
  final String name;

  const ProviderModel({
    required this.id,
    required this.logoPath,
    required this.name,
  });

  factory ProviderModel.fromFirestore(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return ProviderModel(
        id: data["id"],
        logoPath: data["logo_path"],
        name: data["name"],
    );
  }

  factory ProviderModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ProviderModel(
      id: data["id"],
      logoPath: data["logo_path"],
      name: data["name"],
    );
  }

}
