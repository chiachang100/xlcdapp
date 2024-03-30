// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io' show Platform;
import 'package:logging/logging.dart';

//import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:window_size/window_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'src/app.dart';
import 'src/data.dart';

final xlcdlog = Logger('main');
late final FirebaseApp app;
late final FirebaseAuth auth;
//late JoyStore joystoreInstance;

Future<void> main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.blueAccent,
    ),
  );

  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  auth = FirebaseAuth.instanceFor(app: app);

  final firestore = FirebaseFirestore.instance;

  //JoyStore joystoreInstance = buildJoyStoreFromFirestoreOrLocal(prod: true);
  joystoreInstance = buildJoyStoreFromFirestoreOrLocal(prod: true);

  final settings = firestore.settings.copyWith(persistenceEnabled: true);
  final updatedSettings = firestore.settings
      .copyWith(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  //firestore.settings = settings;

  if (kIsWeb) {
    await FirebaseAuth.instance.setPersistence(Persistence.NONE);
  }

  // if (!kReleaseMode) {
  //   FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  //   FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  //   //FirebaseDatabase.instance.useDatabaseEmulator('localhost', 9000);
  //   //FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  // }

  // Use package:url_strategy until this pull request is released:
  // https://github.com/flutter/flutter/pull/77103

  // Use to setHashUrlStrategy() to use "/#/" in the address bar (default). Use
  // setPathUrlStrategy() to use the path. You may need to configure your web
  // server to redirect all paths to index.html.
  //
  // On mobile platforms, both functions are no-ops.
  // setHashUrlStrategy();
  setPathUrlStrategy();

  setupWindow();
  runApp(Joystore(firestore: firestore));
  // SystemChrome.setPreferredOrientations(
  //         <DeviceOrientation>[DeviceOrientation.portraitUp])
  //     .then((value) => runApp(Joystore(firestore: firestore)));
}

const double windowWidth = 480;
const double windowHeight = 854;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('笑裡藏道');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}
