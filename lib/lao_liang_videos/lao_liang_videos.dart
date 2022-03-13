import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'media_category.dart';
import 'dummy_snapshot.dart';
import 'record.dart';

class LaoLiangVideos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LaoLiangVideosState();
  }
}

enum AppBarBehavior { normal, pinned, floating, snapping }

class LaoLiangVideosState extends State<LaoLiangVideos> {
  static final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 20);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _launchURL(String url) => launch(url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('老梁視頻'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    JoymmType type = JoymmType.prod;

    switch (type) {
      case JoymmType.dev:
        {
          return _buildListFromCache(context, dummyLaoLiangVideosSnapshot);
        }
        break;

      case JoymmType.prod:
        {
          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('laoliangvideos')
                .orderBy("votes", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();

              return _buildList(context, snapshot.data.documents);
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
    final record = Record.fromSnapshot(data);

    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(record.title),
                  Text(
                    record.votes.toString(),
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
              subtitle: Text(record.subtitle),
            ),
            GestureDetector(
              onTap: () {
                FirebaseFirestore.instance.runTransaction((transaction) async {
                  final freshSnapshot = await transaction.get(record.reference);
                  final fresh = Record.fromSnapshot(freshSnapshot);

                  await transaction
                      .update(record.reference, {'votes': fresh.votes + 1});
                });

                _launchURL(record.url);
              },
              child: Image.asset(
                'assets/images/laoliang/' + record.icon,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );

    /*
    return Padding(
      key: ValueKey(record.title),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        child: ListTile(
          title: Text(record.title),
          subtitle: Text(record.subtitle),
          leading: CircleAvatar(
            backgroundColor:
                JmmMediaColorList[(record.icon.codeUnitAt(0) - 64)],
            child: Text(
              record.title.substring(0, 1),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          trailing: Text(record.votes.toString()),
          onTap: () {
            FirebaseFirestore.instance.runTransaction((transaction) async {
              final freshSnapshot = await transaction.get(record.reference);
              final fresh = Record.fromSnapshot(freshSnapshot);

              await transaction
                  .update(record.reference, {'votes': fresh.votes + 1});
            });

            _launchURL(record.url);
          },
        ),
      ),
    );
    */
  }

  Widget _buildListFromCache(BuildContext context, List<Map> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot
          .map((data) =>
              _buildListItemFromCache(context, (data as Map<String, dynamic>)))
          .toList(),
    );
  }

  Widget _buildListItemFromCache(
      BuildContext context, Map<String, dynamic> data) {
    final record = Record.fromMap(data);

    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(record.title),
                  Text(
                    record.votes.toString(),
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
              subtitle: Text(record.subtitle),
            ),
            GestureDetector(
              onTap: () {
                FirebaseFirestore.instance.runTransaction((transaction) async {
                  final freshSnapshot = await transaction.get(record.reference);
                  final fresh = Record.fromSnapshot(freshSnapshot);

                  await transaction
                      .update(record.reference, {'votes': fresh.votes + 1});
                });

                _launchURL(record.url);
              },
              child: Image.asset(
                'assets/images/laoliang/' + record.icon,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );

    /*
    return Padding(
      key: ValueKey(record.title),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        child: ListTile(
          title: Text(record.title),
          subtitle: Text(record.subtitle),
          leading: CircleAvatar(
            backgroundColor:
                JmmMediaColorList[(record.icon.codeUnitAt(0) - 64)],
            child: Text(
              record.title.substring(0, 1),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          trailing: Text(record.votes.toString()),
          onTap: () => _launchURL(record.url),
        ),
      ),
    );
    */
  }
}
