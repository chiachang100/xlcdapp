// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'scripture.dart';

@immutable
class Joy {
  final int id;
  final int articleId;
  final String title;
  final String scriptureName;
  final String scriptureVerse;
  final String prelude;
  final String laugh;
  final String photoUrl;
  final String videoId;
  final String videoName;
  final String talk;
  //final int likes;
  int likes;
  final int type;
  final bool isNew;
  final String category;
  final Scripture scripture;

  Joy({
    required this.id,
    required this.articleId,
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
    required this.scripture,
  });

  Joy.fromJson(Map<String, Object?> json)
      : this(
            id: json['id']! as int,
            articleId: json['articleId']! as int,
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
            scripture: Scripture(
                (json['id']! as int),
                (json['scriptureName']! as String),
                (json['scriptureVerse']! as String)));

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'articleId': articleId,
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
