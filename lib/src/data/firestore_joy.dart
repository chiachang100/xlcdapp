import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class Joy {
  final int id;
  final String title;
  final String scriptureName;
  final String scriptureVerse;
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

  const Joy({
    required this.id,
    required this.title,
    required this.scriptureName,
    required this.scriptureVerse,
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

  Joy.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as int,
          title: json['title']! as String,
          scriptureName: json['scriptureName']! as String,
          scriptureVerse: json['scriptureVerse']! as String,
          prelude: json['prelude']! as String,
          laugh: json['laugh']! as String,
          photoUrl: json['photoUrl']! as String,
          videoId: json['videoId']! as String,
          videoName: json['videoName']! as String,
          talk: json['talk']! as String,
          likes: json['likes']! as int,
          type: json['type']! as int,
          isNew: json['isNew']! as bool,
          category: json['category']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'scriptureName': scriptureName,
      'scriptureVerse': scriptureVerse,
      'prelude': prelude,
      'laugh': laugh,
      'photoUrl': photoUrl,
      'videoId': videoId,
      'videoName': videoName,
      'talk': talk,
      'likes': likes,
      'type': type,
      'isNew': isNew,
      'category': category,
    };
  }

  factory Joy.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Joy(
      id: data?['id'],
      title: data?['title'],
      scriptureName: data?['scriptureName'],
      scriptureVerse: data?['scriptureVerse'],
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
      'id': id,
      'title': title,
      'scriptureName': scriptureName,
      'scriptureVerse': scriptureVerse,
      'prelude': prelude,
      'laugh': laugh,
      'photoUrl': photoUrl,
      'videoId': videoId,
      'videoName': videoName,
      'talk': talk,
      'likes': likes,
      'type': type,
      'isNew': isNew,
      'category': category,
    };
  }
}
