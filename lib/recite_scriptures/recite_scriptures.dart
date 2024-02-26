import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'media_category.dart';
import 'dummy_snapshot.dart';
import 'record.dart';

class ReciteScriptures extends StatefulWidget {
  // const ReciteScriptures({
  //   super.key,
  //   required this.firestore,
  // });
  ReciteScriptures(this.firestore);
  final FirebaseFirestore firestore;

  @override
  State<StatefulWidget> createState() {
    return ReciteScripturesState();
  }
}

enum AppBarBehavior { normal, pinned, floating, snapping }

class ReciteScripturesState extends State<ReciteScriptures> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 20);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _launchURL(String url) => launch(url);

  String _getURL(String book, String chapter) {
    String urlPrefix = 'https://www.biblegateway.com/passage/?search=';
    String urlSuffix = '&version=CUVMPT';
    String urlVerse = book + ' ' + chapter;
    String url1 = urlPrefix + urlVerse + urlSuffix;
    print(url1);
    var targetURL = Uri.https("www.biblegateway.com", "/passage/",
        {"search": urlVerse, "version": "CUVMPT"}).toString();
    print(targetURL);
    return targetURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    //XlcdFlavorType type = XlcdFlavorType.prod;
    XlcdFlavorType type = XlcdFlavorType.dev;

    switch (type) {
      case XlcdFlavorType.dev:
        {
          return _buildListFromCache(context, dummyReciteScripturesSnapshot);
        }
        break;

      case XlcdFlavorType.prod:
        {
          return StreamBuilder<QuerySnapshot>(
            stream: widget.firestore
                .collection('bibleverses')
                .orderBy("votes", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();

              return _buildList(
                  context, snapshot.data as List<DocumentSnapshot>);
            },
          );
        }
    }
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record =
        Record.fromSnapshot(data as DocumentSnapshot<Map<String, dynamic>>);

    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(record.book + ' ' + record.chapter),
                  Text(
                    record.votes.toString(),
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.firestore.runTransaction((transaction) async {
                  final freshSnapshot = await transaction
                      .get(record.reference as DocumentReference<Object?>);
                  final fresh = Record.fromSnapshot(
                      freshSnapshot as DocumentSnapshot<Map<String, dynamic>>);

                  await transaction.update(
                      record.reference as DocumentReference<Object?>,
                      {'votes': fresh.votes + 1});
                });

                //_launchURL(record.url);
                String verseURL = _getURL(record.book, record.chapter);
                _launchURL(verseURL);
              },
              child: Center(
                child: Text(
                  record.verse,
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListFromCache(BuildContext context, List<Map> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot
          .map((data) => _buildListItemFromCache(context, data))
          .toList(),
    );
  }

  Widget _buildListItemFromCache(BuildContext context, Map data) {
    final record = Record.fromMap(data as Map<String, dynamic>);

    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${record.book} ${record.chapter}'),
                  Text(
                    record.votes.toString(),
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.firestore.runTransaction((transaction) async {
                  final freshSnapshot = await transaction
                      .get(record.reference as DocumentReference<Object?>);
                  final fresh = Record.fromSnapshot(
                      freshSnapshot as DocumentSnapshot<Map<String, dynamic>>);

                  transaction.update(
                      record.reference as DocumentReference<Object?>,
                      {'votes': fresh.votes + 1});
                });

                //_launchURL(record.url);
                String verseURL = _getURL(record.book, record.chapter);
                _launchURL(verseURL);
              },
              child: Text(
                record.verse,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
