// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/link.dart';
//import 'package:web/helpers.dart';

import '../data.dart';
import 'scripture_details.dart';

class JoyDetailsScreen extends StatelessWidget {
  final Joy? joy;

  const JoyDetailsScreen({
    super.key,
    this.joy,
  });

  @override
  Widget build(BuildContext context) {
    if (joy == null) {
      return const Scaffold(
        body: Center(
          child: Text('No joy found.'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(joy!.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleSection(
              name: joy!.scripture.name,
              verse: joy!.scripture.verse,
              votes: joy!.votes,
              isLike: joy!.isLike,
            ),
            ImageSection(image: joy!.photoUrl),
            TextSection(description: joy!.prelude),
            const DividerSection(),
            TextSection(description: joy!.laugh),
            const DividerSection(),
            TextSection(description: joy!.talk),
          ],
        ),
      ),
    );
  }
}

class DividerSection extends StatelessWidget {
  const DividerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        child: Icon(Icons.stars),
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: 400,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Image.asset(
          image,
        ),
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
    required this.name,
    required this.verse,
    required this.votes,
    required this.isLike,
  });
  final String name;
  final String verse;
  final int votes;
  final bool isLike;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    // '「$verse」($name)',
                    '$verse($name)',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Text(
                //   name,
                //   style: TextStyle(
                //     color: Colors.grey[500],
                //   ),
                // ),
              ],
            ),
          ),
          isLike ? Icon(Icons.thumb_up) : Icon(Icons.thumb_up_alt_outlined),
          Text('${votes}'),
        ],
      ),
    );
  }
}

class TextSection extends StatelessWidget {
  const TextSection({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding: const EdgeInsets.all(32),
      padding: const EdgeInsets.all(12),
      child: Text(
        description,
        softWrap: true,
      ),
    );
  }
}
