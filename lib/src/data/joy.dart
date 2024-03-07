// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'scripture.dart';

class Joy {
  final int id;
  final String title;
  final String prelude;
  final String laugh;
  final String photoUrl;
  final String talk;
  final int votes;
  final int type;
  final bool isNew;
  final Scripture scripture;

  Joy(
    this.id,
    this.title,
    this.prelude,
    this.laugh,
    this.photoUrl,
    this.talk,
    this.votes,
    this.type,
    this.isNew,
    this.scripture,
  );
}
