// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../data.dart';

class ScriptureList extends StatelessWidget {
  final List<Scripture> scriptures;
  final ValueChanged<Scripture>? onTap;

  const ScriptureList({
    required this.scriptures,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: scriptures.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            scriptures[index].name,
          ),
          subtitle: Text(
            scriptures[index].verse,
          ),
          leading: CircleAvatar(
            child: Text(
              scriptures[index].name.substring(0, 1),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          onTap: onTap != null ? () => onTap!(scriptures[index]) : null,
        ),
      );
}
