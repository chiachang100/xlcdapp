// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/link.dart';

import '../auth.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                    child: SettingsContent(),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class SettingsContent extends StatelessWidget {
  const SettingsContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          ...[
            Text(
              '設定',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            FilledButton(
              onPressed: () {
                JoystoreAuth.of(context).signOut();
              },
              child: const Text('Sign out'),
            ),
            const Text('Example using the Link widget:'),
            Link(
              uri: Uri.parse('/joys/all/joy/0'),
              builder: (context, followLink) => TextButton(
                onPressed: followLink,
                child: const Text('/joys/all/joy/0'),
              ),
            ),
            const Text('Example using GoRouter.of(context).go():'),
            TextButton(
              child: const Text('/joys/all/joy/0'),
              onPressed: () {
                GoRouter.of(context).go('/joys/all/joy/0');
              },
            ),
          ].map((w) => Padding(padding: const EdgeInsets.all(8), child: w)),
          const Text('Displays a dialog on the root Navigator:'),
          TextButton(
            onPressed: () => showDialog<String>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Alert!'),
                content: const Text('The alert description goes here.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
            child: const Text('Show Dialog'),
          )
        ],
      );
}
