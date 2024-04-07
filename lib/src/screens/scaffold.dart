// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

import 'package:firebase_analytics/firebase_analytics.dart';

class JoystoreScaffold extends StatelessWidget {
  final Widget child;
  final int selectedIndex;

  const JoystoreScaffold({
    required this.child,
    required this.selectedIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);

    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'AdaptiveScaffoldScreen',
      'xlcdapp_screen_class': 'JoystoreScaffoldClass',
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: AdaptiveScaffold(
            //transitionDuration: Durations.short1,
            transitionDuration: Duration.zero,
            selectedIndex: selectedIndex,
            body: (_) => child,
            onSelectedIndexChange: (idx) {
              if (idx == 0) goRouter.go('/joys/all');
              if (idx == 1) goRouter.go('/scriptures');
              if (idx == 2) goRouter.go('/settings');
            },
            destinations: const <NavigationDestination>[
              NavigationDestination(
                label: '笑裡藏道',
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                //icon: ImageIcon(AssetImage('assets/icons/xlcdapp-leading-icon.png')),
              ),
              NavigationDestination(
                label: '聖經經文',
                icon: Icon(Icons.list_outlined),
                selectedIcon: Icon(Icons.list),
              ),
              NavigationDestination(
                label: '資源簡介',
                icon: Icon(Icons.group_outlined),
                selectedIcon: Icon(Icons.group),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
