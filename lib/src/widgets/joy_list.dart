// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../data.dart';

class JoyList extends StatelessWidget {
  final List<Joy> joys;
  final ValueChanged<Joy>? onTap;

  const JoyList({
    required this.joys,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: joys.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            joys[index].title,
          ),
          subtitle: Text(
            joys[index].scripture.name,
          ),
          leading: CircleAvatar(
            child: Text(
              joys[index].title.substring(0, 1),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          onTap: onTap != null ? () => onTap!(joys[index]) : null,
        ),
      );
}
