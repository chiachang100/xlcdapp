// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'joy.dart';

class Scripture {
  final int id;
  final String name;
  final String verse;
  final joys = <Joy>[];

  Scripture(this.id, this.name, this.verse);
}
