import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Record {
  final String icon;
  final String title;
  final String subtitle;
  final String url;
  final int votes;
  final DocumentReference? reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['icon'] != null),
        assert(map['title'] != null),
        assert(map['subtitle'] != null),
        assert(map['url'] != null),
        assert(map['votes'] != null),
        icon = map['icon'],
        title = map['title'],
        subtitle = map['subtitle'],
        url = map['url'],
        votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromMap((snapshot.data() as Map<String, dynamic>),
            reference: snapshot.reference);

  @override
  String toString() => "Record<$icon:$title:$subtitle:$url:$votes";
}
