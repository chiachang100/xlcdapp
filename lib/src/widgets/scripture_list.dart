// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../data.dart';

class ScriptureList extends StatelessWidget {
  final List<Scripture> scriptures;
  final ValueChanged<Scripture>? onTap;

  ScriptureList({
    required this.scriptures,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'ScriptureListScreen',
      'xlcdapp_screen_class': 'ScriptureListClass',
    });

    return ListView.builder(
      itemCount: scriptures.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(
          scriptures[index].name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          scriptures[index].verse,
        ),
        leading: CircleAvatar(
          backgroundColor: circleAvatarBgColor[
              (scriptures[index].id % circleAvatarBgColor.length)],
          child: Text(
            scriptures[index].name.substring(0, 1),
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        //trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap != null ? () => onTap!(scriptures[index]) : null,
        // onTap: onTap != null ? () => {} : null,
      ),
    );
  }
}
