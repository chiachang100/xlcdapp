// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:go_router/go_router.dart';

import '../data.dart';
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
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': '聖經經文Screen',
      'xlcdapp_screen_class': 'ScripturesScreenClass',
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset('assets/icons/xlcdapp-leading-icon.png'),
              onPressed: () {
                GoRouter.of(context).go('/joys/all');
              },
            );
          },
        ),
      ),
      body: ScriptureList(
        scriptures: joystoreInstance.allScriptures,
        onTap: onTap,
      ),
    );
  }
}
