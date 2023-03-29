import 'package:cloud_firestore/cloud_firestore.dart';

class MediaModel {
  final int id;
  final String credits;
  final String genreIds;
  final String genres;
  final String providerIds;
  final String posterPath;
  final String providerNames;
  final String releaseDate;
  final String title;
  final String titleLowercase;
  final String originalTitle;
  final String mediaType;
  final String overview;

  const MediaModel(
      {required this.id,
      required this.title,
      required this.originalTitle,
      required this.mediaType,
      required this.overview,
      required this.releaseDate,
      required this.credits,
      required this.genreIds,
      required this.genres,
      required this.providerIds,
      required this.providerNames,
      required this.titleLowercase,
      required this.posterPath});

  toJson() {
    return {
      "id": id,
      "title": title,
      "original_title": originalTitle,
      "media_type": mediaType,
      "overview": overview,
      "release_date": releaseDate,
      "credits": credits,
      "genre_ids": genreIds,
      "genres": genres,
      "provider_ids": providerIds,
      "poster_path": posterPath,
    };
  }

  factory MediaModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return MediaModel(
        id: data['id'],
        title: data['title'],
        originalTitle: data['original_title'],
        mediaType: data['media_type'],
        overview: data['overview'],
        releaseDate: data['release_date'],
        credits: data["credits"],
        genres: data["genres"],
        genreIds: data["genre_ids"],
        providerIds: data["provider_ids"],
        providerNames: data['provider_names'],
        titleLowercase: data['title_lowercase'],
        posterPath: data["poster_path"]);
  }

  factory MediaModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return MediaModel(
        credits: data["credits"],
        genres: data["genres"],
        genreIds: data["genre_ids"],
        id: data["id"],
        mediaType: data["media_type"],
        originalTitle: data["original_title"],
        overview: data["overview"],
        posterPath: data["poster_path"],
        providerNames: data["provider_names"],
        providerIds: data["provider_ids"],
        releaseDate: data["release_date"],
        title: data["title"],
        titleLowercase: data["title_lowercase"]);
  }
}
