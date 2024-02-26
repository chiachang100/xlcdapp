import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Record {
  final String id;
  final String icon;
  final String title;
  final String subtitle;
  final Uri url;
  final String prelude;
  final String joke;
  final String image;
  final String talk;
  final bool like;
  final int type;
  final int votes;
  final DocumentReference<Map<String, dynamic>>? reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['id'] != null),
        assert(map['icon'] != null),
        assert(map['title'] != null),
        assert(map['subtitle'] != null),
        id = map['id'],
        icon = map['icon'],
        title = map['title'],
        subtitle = map['subtitle'],
        url = Uri.parse(map['url']),
        prelude = map['prelude'],
        joke = map['joke'],
        image = map['image'],
        talk = map['talk'],
        like = map['like'],
        type = map['type'],
        votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromMap(snapshot.data as Map<String, dynamic>,
            reference: snapshot.reference);

  @override
  String toString() => "Record<$id:$icon:$title:$subtitle:$url$votes";
}
