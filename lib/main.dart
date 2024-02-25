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
import 'pages/personal_page.dart';
import 'pages/firestore_page.dart';

import 'media_list/recommended_media.dart';
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
      home: Home(
        title: '笑裡藏道',
        analytics: analytics,
        observer: observer,
        firestore: firestore,
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
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
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onDestinationSelected,
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.favorite),
            icon: Icon(Icons.favorite_outline),
            label: 'Favorites',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Personal',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.storage),
            icon: Icon(Icons.storage_outlined),
            label: 'Firestore',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.media_bluetooth_on),
            icon: Icon(Icons.media_bluetooth_off),
            label: 'Media',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.book),
            icon: Icon(Icons.book_outlined),
            label: 'BibleVerse',
          ),
        ],
      ),
      body: <Widget>[
        HomePage(),
        FavoritesPage(),
        PersonalPage(),
        FirestorePage(widget.firestore),
        RecommendedMediaApp(widget.firestore),
        ReciteScriptures(widget.firestore),
      ][currentPageIndex],
    );
  }
}
