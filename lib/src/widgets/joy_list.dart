// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../data.dart';

class JoyList extends StatelessWidget {
  final List<Joy> joys;
  final ValueChanged<Joy>? onTap;

  JoyList({
    required this.joys,
    this.onTap,
    super.key,
  });

  List<Color> circleAvatarBgColor = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: joys.length,
        itemBuilder: (context, index) => Card(
          color: Colors.yellow[50],
          elevation: 8.0,
          margin: const EdgeInsets.all(8.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
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
                  Text(
                    joys[index].title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                '${joys[index].scripture.verse}(${joys[index].scripture.name})',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              ElevatedButton(
                onPressed: (onTap != null ? () => onTap!(joys[index]) : null),
                child: const Text(
                  '看內容',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
/*         itemBuilder: (context, index) => ListTile(
          title: Text(
            joys[index].title,
          ),
          subtitle: Text(
              '${joys[index].scripture.verse}(${joys[index].scripture.name})'),
          leading: CircleAvatar(
            backgroundColor: circleAvatarBgColor[
                (joys[index].id % circleAvatarBgColor.length)],
            child: Text(
              joys[index].title.substring(0, 1),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          //trailing: const Icon(Icons.arrow_forward_ios),
          onTap: onTap != null ? () => onTap!(joys[index]) : null,
        ),
 */
      );
}
