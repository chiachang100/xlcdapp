// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../data/scripture.dart';
import '../data/library.dart';
import '../widgets/scripture_list.dart';

class ScripturesScreen extends StatelessWidget {
  final String title;
  final ValueChanged<Scripture> onTap;

  const ScripturesScreen({
    required this.onTap,
    this.title = '聖經經文',
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ScriptureList(
          scriptures: libraryInstance.allScriptures,
          onTap: onTap,
        ),
      );
}
