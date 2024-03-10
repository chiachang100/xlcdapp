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
      // appBar: AppBar(
      //   leading: Image.asset('assets/icons/xlcdapp-leading-icon.png'),
      //   title: const Text('笑裡藏道'),
      //   centerTitle: true,
      //   //backgroundColor: Colors.orange,
      // ),
      //extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: AdaptiveNavigationScaffold(
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
                icon: Icons.favorite_border,
                //icon: ImageIcon(AssetImage('assets/icons/xlcdapp-leading-icon.png')),
              ),
              AdaptiveScaffoldDestination(
                title: '聖經經文',
                icon: Icons.list,
              ),
              AdaptiveScaffoldDestination(
                title: '資源介紹',
                icon: Icons.person_outline_sharp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
