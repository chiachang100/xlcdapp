import 'package:cloud_firestore/cloud_firestore.dart';

class Joy {
  //final int id;
  final int itemId;
  final String title;
  final String prelude;
  final String laugh;
  final String photoUrl;
  final String videoId;
  final String videoName;
  final String talk;
  final int likes;
  final int type;
  final bool isNew;
  final String category;

  Joy({
    //required this.id,
    required this.itemId,
    required this.title,
    required this.prelude,
    required this.laugh,
    required this.photoUrl,
    required this.videoId,
    required this.videoName,
    required this.talk,
    required this.likes,
    required this.type,
    required this.isNew,
    required this.category,
  });

  factory Joy.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Joy(
      //id: data['id'],
      itemId: data?['itemId'],
      title: data?['title'],
      prelude: data?['prelude'],
      laugh: data?['laugh'],
      photoUrl: data?['photoUrl'],
      videoId: data?['videoId'],
      videoName: data?['videoName'],
      talk: data?['talk'],
      likes: data?['likes'],
      type: data?['type'],
      isNew: data?['isNew'],
      category: data?['category'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "itemId": itemId,
      "title": title,
      "prelude": prelude,
      "laugh": laugh,
      "photoUrl": photoUrl,
      "videoId": videoId,
      "videoName": videoName,
      "talk": talk,
      "likes": likes,
      "type": type,
      "isNew": isNew,
      "category": category,
    };
  }
}
