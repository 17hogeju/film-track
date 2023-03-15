import 'package:cloud_firestore/cloud_firestore.dart';

class TitleModel {
  final List<dynamic> titles;

  const TitleModel({
    required this.titles
  });

  toJson(){
    return {
      "titles": titles,
    };
  }

  factory TitleModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return TitleModel(
        titles: data["titles"]
    );
  }
}