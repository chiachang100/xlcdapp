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

  final String iconUrl = 'assets/icons/xlcdapp-icon-48x48.png';

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
            ImageSection(image: joy!.photoUrl),
            TitleSection(
              name: joy!.scripture.name,
              verse: joy!.scripture.verse,
              votes: joy!.votes,
              isLike: joy!.isLike,
            ),
            const DividerSection(
                Icon(Icons.favorite_outline, color: Colors.red)),
            TextSection(description: joy!.prelude),
            const DividerSection(Icon(Icons.face, color: Colors.red)),
            TextSection(description: joy!.laugh),
            LeadingIconTextSection(description: joy!.talk, iconUrl: iconUrl),
          ],
        ),
      ),
    );
  }
}

class DividerSection extends StatelessWidget {
  const DividerSection(this.icon);
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: icon,
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
      height: 320,
      width: 640,
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

class LeadingIconTextSection extends StatelessWidget {
  const LeadingIconTextSection({
    super.key,
    required this.description,
    required this.iconUrl,
  });

  final String description;
  final String iconUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(iconUrl),
        Text(
          description,
          softWrap: true,
        ),
      ],
    );
  }
}
