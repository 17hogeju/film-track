import 'package:cloud_firestore/cloud_firestore.dart';

class MediaModel {
  final int id;
  final String title;
  final String originalTitle;
  final String mediaType;
  final String overview;
  final String releaseDate;
  final String credits;
  final List<dynamic> genreIds;
  final List<dynamic> providerIds;
  final String posterPath;



  const MediaModel({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.mediaType,
    required this.overview,
    required this.releaseDate,
    required this.credits,
    required this.genreIds,
    required this.providerIds,
    required this.posterPath
  });

  toJson(){
    return {
      "id": id,
      "title": title,
      "original_title": originalTitle,
      "media_type": mediaType,
      "overview": overview,
      "release_date": releaseDate,
      "credits": credits,
      "genre_ids": genreIds,
      "provider_ids": providerIds,
      "poster_path": posterPath,
    };
  }

  factory MediaModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return MediaModel(
        id: data["id"],
        title: data["title"],
        originalTitle: data["original_title"],
        mediaType: data["media_type"],
        overview: data["overview"],
        releaseDate: data["release_date"],
        credits: data["credits"],
        genreIds: data["genre_ids"],
        providerIds: data["provider_ids"],
        posterPath: data["poster_path"]
    );
  }
}