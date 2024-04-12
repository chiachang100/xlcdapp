// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:go_router/go_router.dart';

class JoysScreen extends StatefulWidget {
  final Widget child;
  final ValueChanged<int> onTap;
  final int selectedIndex;

  const JoysScreen({
    required this.child,
    required this.onTap,
    required this.selectedIndex,
    super.key,
  });

  @override
  State<JoysScreen> createState() => _JoysScreenState();
}

class _JoysScreenState extends State<JoysScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': '笑裡藏道HomeScreen',
      'xlcdapp_screen_class': 'JoysScreenClass',
    });

    _tabController = TabController(length: 3, vsync: this)
      ..addListener(_handleTabIndexChanged);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndexChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabController.index = widget.selectedIndex;
    return Scaffold(
      appBar: AppBar(
        title: const Text('笑裡藏道'),
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
        //backgroundColor: Colors.orange,
        bottom: TabBar(
          //isScrollable: true,
          controller: _tabController,
          tabs: const [
            Tab(
              text: '喜樂榜',
              icon: Icon(Icons.format_list_numbered, color: Colors.red),
            ),
            Tab(
              text: '新出爐',
              icon: Icon(Icons.rocket_launch_outlined, color: Colors.green),
            ),
            Tab(
              text: '目錄表',
              icon: Icon(Icons.collections_outlined, color: Colors.blueAccent),
            ),
          ],
        ),
      ),
      body: widget.child,
    );
  }

  void _handleTabIndexChanged() {
    widget.onTap(_tabController.index);
  }
}
