import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestorePage extends StatelessWidget {
  final FirebaseFirestore db;
  FirestorePage(this.db);
  final bool initDb = false;
  final bool initMediaDb = false;

  void getStarted_addData() async {
    // [START get_started_add_data_1]
    // Create a new user with a first and last name
    final user = <String, dynamic>{
      "first": "Ada",
      "last": "Lovelace",
      "born": 1815
    };

    // Add a new document with a generated ID
    db.collection("users").add(user).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
    // [END get_started_add_data_1]
  }

  void getStarted_addData2() async {
    // [START get_started_add_data_2]
    // Create a new user with a first and last name
    final user = <String, dynamic>{
      "first": "Alan",
      "middle": "Mathison",
      "last": "Turing",
      "born": 1912
    };

    // Add a new document with a generated ID
    db.collection("users").add(user).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
    // [END get_started_add_data_2]
  }

  void getStarted_readData() async {
    // [START get_started_read_data]
    await db.collection("users").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
    // [END get_started_read_data]
  }

  void getStarted_addMediaData() async {
    final media = <String, dynamic>{
      "icon": 'D',
      "title": "喜樂的心乃是良藥",
      "subtitle": "喜樂的心乃是良藥，憂傷的靈使骨枯乾 - 神話語的科學證明。",
      "url": "http://www.luke54.org/view/34/3382.html",
      "votes": 14,
    };

    // Add a new document with a generated ID
    db.collection("media").add(media).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  void getStarted_addMediaData2() async {
    final media = <String, dynamic>{
      "icon": 'C',
      "title": "宣教士 第一集 - 叩门",
      "subtitle": "从汉朝多马入华的传说, 经唐朝景教, 元朝也里可温教, 到明末清初的天主教, 一千多年间叩门, 开门和关门的故事. ",
      "url": "https://www.youtube.com/watch?v=Tor90TgVKOs",
      "votes": 6,
    };

    // Add a new document with a generated ID
    db.collection("media").add(media).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  void getStarted_addMediaData3() async {
    final media = <String, dynamic>{
      "icon": 'D',
      "title": "Good TV",
      "subtitle": "GOOD TV好消息電視台",
      "url": "https://www.youtube.com/user/goodtv",
      "votes": 3,
    };

    // Add a new document with a generated ID
    db.collection("media").add(media).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  void getStarted_readMediaData() async {
    await db.collection("media").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (initDb) {
      getStarted_addData();
      getStarted_addData2();
    }
    getStarted_readData();

    if (initMediaDb) {
      getStarted_addMediaData();
      getStarted_addMediaData2();
      getStarted_addMediaData3();
    }
    getStarted_readMediaData();

    return Scaffold(
      body: Card(
        shadowColor: Colors.transparent,
        margin: const EdgeInsets.all(8.0),
        child: SizedBox.expand(
          child: Center(
            child: Text(
              'Firestore page',
            ),
          ),
        ),
      ),
    );
  }
}
