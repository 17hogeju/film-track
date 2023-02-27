class PastRec {
  final int id;
  final bool disliked;

  PastRec(
      {required this.id,
        required this.disliked});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'disliked': disliked
    };
  }

  PastRec.fromMap(Map<String, dynamic> pastRecMap)
      : id = pastRecMap["id"],
        disliked = pastRecMap["disliked"];
}