// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'scripture.dart';
import 'joy.dart';
import 'local_joystore.dart';

const int topList = 10;

final joysRef = FirebaseFirestore.instance
    .collection('joys')
    .orderBy("likes", descending: true)
    .withConverter<Joy>(
      fromFirestore: (snapshots, _) => Joy.fromJson(snapshots.data()!),
      toFirestore: (joy, _) => joy.toJson(),
    );

class JoyStore {
  final List<Joy> allJoys = [];
  final List<Scripture> allScriptures = [];

  void addJoy({
    required int id,
    required int articleId,
    required String title,
    required String scriptureName,
    required String scriptureVerse,
    required String prelude,
    required String laugh,
    required String photoUrl,
    required String videoId,
    required String videoName,
    required String talk,
    required int likes,
    required int type,
    required bool isNew,
    required String category,
  }) {
    var scripture = allScriptures.firstWhere(
      (scripture) => scripture.name == scriptureName,
      orElse: () {
        final value =
            Scripture(allScriptures.length, scriptureName, scriptureVerse);
        allScriptures.add(value);
        return value;
      },
    );
    var joy = Joy(
      id: allJoys.length,
      articleId: articleId,
      title: title,
      scriptureName: scriptureName,
      scriptureVerse: scriptureVerse,
      prelude: prelude,
      laugh: laugh,
      photoUrl: photoUrl,
      videoId: videoId,
      videoName: videoName,
      talk: talk,
      likes: likes,
      type: type,
      isNew: isNew,
      category: category,
      scripture: scripture,
    );

    scripture.joys.add(joy);
    allJoys.add(joy);
  }

  Joy getJoy(String id) {
    return allJoys[int.parse(id)];
  }

  List<Joy> getTopList(List<Joy> allJoys, int filter) {
    //allJoys.sort((a, b) => a.likes.compareTo(b.likes)); // ascending
    allJoys.sort((a, b) => b.likes.compareTo(a.likes)); // descending
    return allJoys.take(filter).toList();
  }

  // List<Joy> get likeJoys => [
  //       ...allJoys.where((joy) => (joy.likes > 0)),
  //     ];

  List<Joy> get likeJoys => [
        ...getTopList(allJoys, topList).where((joy) => (joy.likes > 0)),
      ];

  List<Joy> get newJoys => [
        ...allJoys.where((joy) => joy.isNew),
      ];

  // <Future>JoyStore joysReadDataFromJoyStore() async {
  Future<JoyStore> joysReadDataFromJoyStore() async {
    JoyStore joystoreInstanceFromJoyStore = JoyStore();

    //await joysRef.get().then((event) {
    await joysRef.get().then((event) {
      for (var doc in event.docs) {
        print(
            "Firestore: ${doc.id} => id=${doc.data().id}:articleId=${doc.data().articleId}:likes=${doc.data().likes}:isNew=${doc.data().isNew}:category=${doc.data().category}");
        //var joy = Joy.fromJson(doc.data());
        var joy = doc.data();
        print(
            "JoyStore:  ${doc.id} => id=${joy.id}:articleId=${doc.data().articleId}:likes=${joy.likes}:isNew=${joy.isNew}:category=${joy.category}");

        var scripture = joystoreInstanceFromJoyStore.allScriptures.firstWhere(
          (scripture) => scripture.name == joy.scriptureName,
          orElse: () {
            final value =
                Scripture(joy.id, joy.scriptureName, joy.scriptureVerse);
            joystoreInstanceFromJoyStore.allScriptures.add(value);
            return value;
          },
        );

        joystoreInstanceFromJoyStore.allJoys.add(joy);
        scripture.joys.add(joy);
      }
    });

    //return Future.value(joystoreInstanceFromJoyStore);
    if (joystoreInstanceFromJoyStore.allJoys.isNotEmpty) {
      return joystoreInstanceFromJoyStore;
    } else {
      //return joystoreInstanceFromLocal;
      return joystoreInstance;
    }
  }
}

// Build JoyStore Instance from Remote Firestore JoyStore
JoyStore buildJoyStoreFromFirestore() {
  var js = buildJoyStoreFromLocal();

  joysRef.get().then((event) {
    for (var doc in event.docs) {
      print(
          "Firestore: ${doc.id} => id=${doc.data().id}:articleId=${doc.data().articleId}:likes=${doc.data().likes}:isNew=${doc.data().isNew}:category=${doc.data().category}");
      //var joy = Joy.fromJson(doc.data());
      var joy = doc.data();
      print(
          "JoyStore:  ${doc.id} => id=${joy.id}:articleId=${doc.data().articleId}:likes=${joy.likes}:isNew=${joy.isNew}:category=${joy.category}");
      js.addJoy(
        id: joy.id,
        articleId: joy.articleId,
        title: joy.title,
        scriptureName: joy.scriptureName,
        scriptureVerse: joy.scriptureVerse,
        prelude: joy.prelude,
        laugh: joy.laugh,
        photoUrl: joy.photoUrl,
        videoId: joy.videoId,
        videoName: joy.videoName,
        talk: joy.talk,
        likes: joy.likes,
        type: joy.type,
        isNew: joy.isNew,
        category: joy.category,
      );
    }
  });

  return js;
}

// Build JoyStore Instance from local JoyStore
JoyStore buildJoyStoreFromLocal() {
  var js = JoyStore();
  for (var joyMap in localJoyStore) {
    var joy = Joy.fromJson(joyMap);
    js.addJoy(
      id: joy.id,
      articleId: joy.articleId,
      title: joy.title,
      scriptureName: joy.scriptureName,
      scriptureVerse: joy.scriptureVerse,
      prelude: joy.prelude,
      laugh: joy.laugh,
      photoUrl: joy.photoUrl,
      videoId: joy.videoId,
      videoName: joy.videoName,
      talk: joy.talk,
      likes: joy.likes,
      type: joy.type,
      isNew: joy.isNew,
      category: joy.category,
    );
  }
  return js;
}

JoyStore buildJoyStoreFromFirestoreOrLocal({prod = true}) {
  if (prod) {
    // Build JoyStore Instance from Firestore JoyStore
    return buildJoyStoreFromFirestore();
  } else {
    // Build JoyStore Instance from local JoyStore
    return buildJoyStoreFromLocal();
  }

  /*
  if (!prod) {
    // Build JoyStore Instance from local JoyStore
    return buildJoyStoreFromLocal();
  }

  // Build JoyStore Instance from Firestore JoyStore
  var js = buildJoyStoreFromFirestore();
  if (js.allJoys.isNotEmpty) {
    print('[INFO] Firestore retuns JoyStore.');
    return js;
  } else {
    print(
        '[INFO] Firestore retuns an empty JoyStore. Therefore, we use the local JoyStore instead.');
    // Build JoyStore Instance from local JoyStore
    return buildJoyStoreFromLocal();
  }
  */
}

// For prod: use buildJoyStoreFromFirestore()
JoyStore joystoreInstance = buildJoyStoreFromFirestoreOrLocal(prod: true);

// For dev: use buildJoyStoreFromLocal()
//JoyStore joystoreInstance = buildJoyStoreFromFirestoreOrLocal(prod: false);
