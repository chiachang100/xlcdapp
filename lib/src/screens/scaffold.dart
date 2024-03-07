// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

    return Scaffold(
      body: AdaptiveNavigationScaffold(
        selectedIndex: selectedIndex,
        body: child,
        onDestinationSelected: (idx) {
          if (idx == 0) goRouter.go('/joys/like');
          if (idx == 1) goRouter.go('/scriptures');
          if (idx == 2) goRouter.go('/settings');
        },
        destinations: const [
          AdaptiveScaffoldDestination(
            title: '笑裡藏道',
            icon: Icons.favorite,
            //icon: ImageIcon(AssetImage('assets/icons/xlcdapp-icon-48x48.png')),
          ),
          AdaptiveScaffoldDestination(
            title: '聖經經文',
            icon: Icons.book,
          ),
          // AdaptiveScaffoldDestination(
          //   title: '設定',
          //   icon: Icons.settings,
          // ),
        ],
      ),
    );
  }
}
