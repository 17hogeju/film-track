import 'package:cloud_firestore/cloud_firestore.dart';

class MediaModel {
  final String credits;
  final String genres;
  final String genreIds;
  final int id;
  final String mediaType;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String providerNames;
  final String providerIds;
  final String releaseDate;
  final String title;
  final String titleLowercase;



  const MediaModel({
    required this.credits,
    required this.genres,
    required this.genreIds,
    required this.id,
    required this.mediaType,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.providerNames,
    required this.providerIds,
    required this.releaseDate,
    required this.title,
    required this.titleLowercase,
  });

  // toJson(){
  //   return {
  //     "credits": credits,
  //     "genres": genres,
  //     "genre_ids": genreIds,
  //     "id": id,
  //     "media_type": mediaType,
  //     "original_title": originalTitle,
  //     "overview": overview,
  //     "poster_path": posterPath,
  //     "provider_ids": providerIds,
  //     "release_date": releaseDate,
  //     "title": title,
  //     "title_lowercase": titleLowercase
  //   };
  // }

  factory MediaModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
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
        titleLowercase: data["title_lowercase"]
    );
  }

  factory MediaModel.fromQuerySnapshot(QueryDocumentSnapshot<Map<String, dynamic>> document) {
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
        titleLowercase: data["title_lowercase"]
    );
  }

  // factory MediaModel.fromFirestore(
  //     DocumentSnapshot<Map<String, dynamic>> snapshot,
  //     SnapshotOptions? options,
  //     ) {
  //   final data = snapshot.data();
  //   return MediaModel(
  //       credits: data?["credits"],
  //       genres: data?["genres"],
  //       genreIds: data?["genre_ids"],
  //       id: data?["id"],
  //       mediaType: data?["media_type"],
  //       originalTitle: data?["original_title"],
  //       overview: data?["overview"],
  //       posterPath: data?["poster_path"],
  //       providerIds: data?["provider_ids"],
  //       releaseDate: data?["release_date"],
  //       title: data?["title"],
  //       titleLowercase: data?["title_lowercase"]
  //   );
  // }

  // Map<String, dynamic> toFirestore() {
  //   return {
  //     "credits": credits,
  //     "genres": genres,
  //     "genre_ids": genreIds,
  //     "id": id,
  //     "media_type": mediaType,
  //     "original_title": originalTitle,
  //     "overview": overview,
  //     "poster_path": posterPath,
  //     "provider_ids": providerIds,
  //     "release_date": releaseDate,
  //     "title": title,
  //     "title_lowercase": titleLowercase
  //   };
  // }

  // factory MediaModel.fromJson(Map<String,dynamic> json) {
  //   return MediaModel(
  //       credits: json["credits"],
  //       genres: json["genres"],
  //       genreIds: json["genre_ids"],
  //       id: json["id"],
  //       mediaType: json["media_type"],
  //       originalTitle: json["original_title"],
  //       overview: json["overview"],
  //       posterPath: json["poster_path"],
  //       providerIds: json["provider_ids"],
  //       releaseDate: json["release_date"],
  //       title: json["title"],
  //       titleLowercase: json["title_lowercase"]
  //   );
  // }
}
