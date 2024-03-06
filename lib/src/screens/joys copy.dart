// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

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
        backgroundColor: Colors.orange,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: '收藏夾',
              icon: Icon(Icons.favorite, color: Colors.red),
            ),
            Tab(
              text: '新系列',
              icon: Icon(Icons.new_releases, color: Colors.green),
            ),
            Tab(
              text: '全部',
              icon: Icon(Icons.collections, color: Colors.blueAccent),
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
