// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'scripture.dart';

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
  final Scripture scripture;

  Joy({
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
    required this.scripture,
  });
}
