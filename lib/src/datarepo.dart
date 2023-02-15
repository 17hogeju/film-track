import 'package:cloud_firestore/cloud_firestore.dart';

class DataRepository {
  final CollectionReference mediaCollection =
      FirebaseFirestore.instance.collection('media');
  final CollectionReference genreCollection =
      FirebaseFirestore.instance.collection('genres');

  Stream<QuerySnapshot> getStream() {
    return mediaCollection.snapshots();
  }

  Future<Object> getMediaItem(String id) async {
    Query query = mediaCollection.where(FieldPath.documentId, isEqualTo: id);
    QuerySnapshot querySnapshot = await query.get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<Object> getGenre(String id) async {
    Query query = genreCollection.where(FieldPath.documentId, isEqualTo: id);
    QuerySnapshot querySnapshot = await query.get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
}
