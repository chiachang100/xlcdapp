// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../data.dart';

class JoyList extends StatelessWidget {
  final List<Joy> joys;
  final ValueChanged<Joy>? onTap;

  JoyList({
    required this.joys,
    this.onTap,
    super.key,
  });

  static List<String> dynamicText = [
    '⚕️喜樂的心乃是良藥',
    '🤣盡情地開懷大笑吧',
    '💓神的道是活潑的',
    '✝️神的道是有功效的',
    '😌領受一份幽默感',
    '🏦累積你的笑話存款',
    '📈提升你的親和指數'
  ];

  String getNextText() => dynamicText[Random().nextInt(dynamicText.length)];

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'JoyListScreen',
      'xlcdapp_screen_class': 'JoyListClass',
    });

    return ListView.builder(
      itemCount: joys.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.yellow[50],
          elevation: 8.0,
          margin: const EdgeInsets.all(8.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  joys[index].photoUrl,
                  height: MediaQuery.of(context).size.width * (3 / 4),
                  width: MediaQuery.of(context).size.width,
                  //height: 120, width: 640,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: circleAvatarBgColor[
                        (joys[index].id % circleAvatarBgColor.length)],
                    child: Text(
                      joys[index].title.substring(0, 1),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    //joys[index].title,
                    '${joys[index].articleId}. ${joys[index].title}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Chip(
                    avatar: const Icon(Icons.thumb_up_outlined),
                    label: Text('${joys[index].likes}'),
                    backgroundColor: Colors.yellow[50],
                  ),
                  // Badge(
                  //   label: Text(joys[index].likes.toString()),
                  //   child: const Icon(Icons.thumb_up_outlined),
                  // ),
                ],
              ),
              Text(
                '${joys[index].scripture.verse}(${joys[index].scripture.name})',
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    //backgroundColor: Colors.orange, // background
                    //foregroundColor: Colors.yellow, // foreground
                    ),
                onPressed: (onTap != null ? () => onTap!(joys[index]) : null),
                child: Text(
                  // '觀賞詳情',
                  getNextText(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
