import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Record {
  final String book;
  final String chapter;
  final String verse;
  final int votes;
  final DocumentReference? reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['book'] != null),
        assert(map['chapter'] != null),
        assert(map['verse'] != null),
        assert(map['votes'] != null),
        book = map['book'],
        chapter = map['chapter'],
        verse = map['verse'],
        votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromMap(snapshot.data as Map<String, dynamic>,
            reference: snapshot.reference);

  @override
  String toString() => "Record<$book:$chapter:$verse:$votes";
}
