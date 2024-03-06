// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../data.dart';
import '../widgets/joy_list.dart';

class ScriptureDetailsScreen extends StatelessWidget {
  final Scripture scripture;
  final ValueChanged<Joy> onJoyTapped;

  const ScriptureDetailsScreen({
    super.key,
    required this.scripture,
    required this.onJoyTapped,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(scripture.name),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: JoyList(
                  joys: scripture.joys,
                  onTap: (joy) {
                    onJoyTapped(joy);
                  },
                ),
              ),
            ],
          ),
        ),
      );
}
