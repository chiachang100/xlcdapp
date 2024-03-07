// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io' show Platform;

//import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:window_size/window_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firestore = FirebaseFirestore.instance;

  final settings = firestore.settings.copyWith(persistenceEnabled: true);
  final updatedSettings = firestore.settings
      .copyWith(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  firestore.settings = settings;

  if (kIsWeb) {
    await FirebaseAuth.instance.setPersistence(Persistence.NONE);
  }

  if (!kReleaseMode) {
    FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    //FirebaseDatabase.instance.useDatabaseEmulator('localhost', 9000);
    //FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  }

  // Use package:url_strategy until this pull request is released:
  // https://github.com/flutter/flutter/pull/77103

  // Use to setHashUrlStrategy() to use "/#/" in the address bar (default). Use
  // setPathUrlStrategy() to use the path. You may need to configure your web
  // server to redirect all paths to index.html.
  //
  // On mobile platforms, both functions are no-ops.
  setHashUrlStrategy();
  // setPathUrlStrategy();

  setupWindow();
  runApp(Joystore(firestore: firestore));
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






/* 
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'pages/home_page.dart';
import 'pages/favorites_page.dart';
import 'pages/settings_page.dart';
import 'pages/firestore_page.dart';

import 'joys/joys_page.dart';
import 'recite_scriptures/recite_scriptures.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firestore = FirebaseFirestore.instance;

  final settings = firestore.settings.copyWith(persistenceEnabled: true);
  final updatedSettings = firestore.settings
      .copyWith(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  firestore.settings = settings;

  if (kIsWeb) {
    await FirebaseAuth.instance.setPersistence(Persistence.NONE);
  }

  if (!kReleaseMode) {
    FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    //FirebaseDatabase.instance.useDatabaseEmulator('localhost', 9000);
    //FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  }

  runApp(
    MainApp(
      firestore: firestore,
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '笑裡藏道',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home: NavigationHome(
        title: '笑裡藏道',
        analytics: analytics,
        observer: observer,
        firestore: firestore,
      ),
    );
  }
}

class NavigationHome extends StatefulWidget {
  const NavigationHome({
    super.key,
    required this.title,
    required this.analytics,
    required this.observer,
    required this.firestore,
  });

  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  final FirebaseFirestore firestore;

  @override
  State<NavigationHome> createState() => _NavigationHomeState();
}

class _NavigationHomeState extends State<NavigationHome> {
  int currentPageIndex = 0;
  int _selectedIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text('笑裡藏道'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 120,
              child: const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Business'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('School'),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onDestinationSelected,
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: '首頁',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.favorite,
              color: Colors.pink,
            ),
            icon: Icon(
              Icons.favorite_border,
              color: Colors.pink,
            ),
            label: '收藏夾',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: '設定',
          ),
          // NavigationDestination(
          //   selectedIcon: Icon(Icons.book),
          //   icon: Icon(Icons.book_outlined),
          //   label: '聖經金句',
          // ),
          // NavigationDestination(
          //   selectedIcon: Icon(Icons.media_bluetooth_on),
          //   icon: Icon(Icons.media_bluetooth_off),
          //   label: 'Joys',
          // ),
          // NavigationDestination(
          //   selectedIcon: Icon(Icons.storage),
          //   icon: Icon(Icons.storage_outlined),
          //   label: 'Firestore',
          // ),
        ],
      ),
      body: <Widget>[
        HomePage(widget.firestore),
        JoysPage(widget.firestore),
        SettingsPage(),
        //ReciteScriptures(widget.firestore),
        //FirestorePage(widget.firestore),
        //FavoritesPage(),
      ][currentPageIndex],
    );
  }
}
 */