import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xlcdapp/joys/joys_category.dart';
import 'package:xlcdapp/joys/dummy_snapshot.dart';
import 'package:xlcdapp/joys/record.dart';

class JoysPage extends StatefulWidget {
  JoysPage(this.firestore);
  final FirebaseFirestore firestore;

  @override
  State<StatefulWidget> createState() {
    return JoysPageState();
  }
}

enum AppBarBehavior { normal, pinned, floating, snapping }

class JoysPageState extends State<JoysPage> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _launchURL(Uri url) => launchUrl(url);

  void _launchXlcdAppApp() => launchUrl(
        Uri.parse('https://tinyurl.com/joy-matcha-media'),
      );

  void _launchXlcdAppYouTube() => launchUrl(
        Uri.parse(
            'https://www.youtube.com/channel/UCuvN0Tt_LLL-bOwO8LcOPlw/playlists?view_as=subscriber'),
      );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        {
          // Home: stay here
          print('Stay Home');
        }
        break;

      case 1:
        {
          // Media
          _mediaHandler();
        }
        break;

      case 2:
        {
          // Contacts
          _contactsHandler();
        }
        break;

      default:
        {
          // Shouldn't be here.
          print('default-index: $index');
        }
        break;
    }
  }

  void showMenuSelection(XlcdMediaPlaylist value) {
    switch (value) {
      case XlcdMediaPlaylist.art:
        {
          _launchURL(
            Uri.parse(
                'https://www.youtube.com/watch?v=qMY4EJC_p6g&list=PLFyg5v4HpNhUhodeO1Gev38prblBEGzDH'),
          );
        }
        break;
      case XlcdMediaPlaylist.business:
        {
          _launchURL(
            Uri.parse(
                'https://www.youtube.com/watch?v=Wb4DVzdZEDg&list=PLFyg5v4HpNhUZkGBLBvkykce3Oe88lQ9G'),
          );
        }
        break;
      case XlcdMediaPlaylist.religion:
        {
          _launchURL(
            Uri.parse(
                'https://www.youtube.com/watch?v=QnulW3-l4Y4&list=PLFyg5v4HpNhWYmHFyeoz8RiQLUye7Tk3P'),
          );
        }
        break;
      case XlcdMediaPlaylist.media:
        {
          _launchURL(
            Uri.parse(
                'https://www.youtube.com/watch?v=BAXcA1xNmfM&list=PLFyg5v4HpNhXa2D9UiJyZp61l6VK-9w4r'),
          );
        }
        break;
      case XlcdMediaPlaylist.education:
        {
          _launchURL(
            Uri.parse(
                'https://www.youtube.com/watch?v=hipdxr2R3wM&list=PLFyg5v4HpNhV-lDWzPLFguujTOyNegVUV'),
          );
        }
        break;
      case XlcdMediaPlaylist.family:
        {
          _launchURL(
            Uri.parse(
                'https://www.youtube.com/watch?v=H52uw6ng36U&list=PLFyg5v4HpNhXWv5VsnyPIiCASMoEuYeiQ'),
          );
        }
        break;
      case XlcdMediaPlaylist.government:
        {
          _launchURL(
            Uri.parse(
                'https://www.youtube.com/watch?v=vzxdQU92n_A&list=PLFyg5v4HpNhXH_kfg_kr83SkhYe7B1wDS'),
          );
        }
        break;
      default:
        {
          // XlcdMediaPlaylist.religion
          _launchURL(
            Uri.parse(
                'https://www.youtube.com/watch?v=QnulW3-l4Y4&list=PLFyg5v4HpNhWYmHFyeoz8RiQLUye7Tk3P'),
          );
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.purple,
        centerTitle: true,
        titleSpacing: 0.0,
        title: Text('收藏夾'),
        actions: <Widget>[
          //IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
          PopupMenuButton<XlcdMediaPlaylist>(
            icon: Icon(Icons.more_vert),
            onSelected: showMenuSelection,
            itemBuilder: (BuildContext context) =>
                <PopupMenuItem<XlcdMediaPlaylist>>[
              PopupMenuItem<XlcdMediaPlaylist>(
                value: XlcdMediaPlaylist.art,
                child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        String.fromCharCode(64 + XlcdMediaPlaylist.art.index),
                        style: TextStyle(
                            //color: Colors.white,
                            //fontSize: 20,
                            ),
                      ),
                      backgroundColor:
                          XlcdMediaColorList[XlcdMediaPlaylist.art.index],
                    ),
                    title: Text('藝術')),
              ),
              PopupMenuItem<XlcdMediaPlaylist>(
                value: XlcdMediaPlaylist.business,
                child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        String.fromCharCode(
                            64 + XlcdMediaPlaylist.business.index),
                        style: TextStyle(
                            //color: Colors.white,
                            ),
                      ),
                      backgroundColor:
                          XlcdMediaColorList[XlcdMediaPlaylist.business.index],
                    ),
                    title: Text('商界')),
              ),
              PopupMenuItem<XlcdMediaPlaylist>(
                value: XlcdMediaPlaylist.religion,
                child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        String.fromCharCode(
                            64 + XlcdMediaPlaylist.religion.index),
                        style: TextStyle(
                            //color: Colors.white,
                            ),
                      ),
                      backgroundColor:
                          XlcdMediaColorList[XlcdMediaPlaylist.religion.index],
                    ),
                    title: Text('宗教')),
              ),
              PopupMenuItem<XlcdMediaPlaylist>(
                value: XlcdMediaPlaylist.media,
                child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        String.fromCharCode(64 + XlcdMediaPlaylist.media.index),
                        style: TextStyle(
                            //color: Colors.white,
                            ),
                      ),
                      backgroundColor:
                          XlcdMediaColorList[XlcdMediaPlaylist.media.index],
                    ),
                    title: Text('媒體')),
              ),
              PopupMenuItem<XlcdMediaPlaylist>(
                value: XlcdMediaPlaylist.education,
                child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        String.fromCharCode(
                            64 + XlcdMediaPlaylist.education.index),
                        style: TextStyle(
                            //color: Colors.white,
                            ),
                      ),
                      backgroundColor:
                          XlcdMediaColorList[XlcdMediaPlaylist.education.index],
                    ),
                    title: Text('教育')),
              ),
              PopupMenuItem<XlcdMediaPlaylist>(
                value: XlcdMediaPlaylist.family,
                child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        String.fromCharCode(
                            64 + XlcdMediaPlaylist.family.index),
                        style: TextStyle(
                            //color: Colors.white,
                            ),
                      ),
                      backgroundColor:
                          XlcdMediaColorList[XlcdMediaPlaylist.family.index],
                    ),
                    title: Text('家庭')),
              ),
              PopupMenuItem<XlcdMediaPlaylist>(
                value: XlcdMediaPlaylist.government,
                child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        String.fromCharCode(
                            64 + XlcdMediaPlaylist.government.index),
                        style: TextStyle(
                            //color: Colors.white,
                            ),
                      ),
                      backgroundColor: XlcdMediaColorList[
                          XlcdMediaPlaylist.government.index],
                    ),
                    title: Text('政府')),
              ),
            ],
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  void _contactsHandler() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Theme(
            data: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.green,
              platform: Theme.of(context).platform,
            ),
            child: Scaffold(
              appBar: AppBar(
                title: Text('聯絡喜樂抹茶傳媒'),
              ),
              key: _scaffoldKey,
              body: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      //minHeight: viewportConstraints.maxHeight,
                      ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Card(
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text('傳遞好信息 喜樂心良藥'),
                                subtitle:
                                    Text('(箴言17:22 『喜樂的心乃是良藥，憂傷的靈使骨枯乾。』)'),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.green[800],
                                  child: Text(
                                    '傳遞好信息 喜樂心良藥'.substring(0, 1),
                                    style: TextStyle(
                                      //color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                onTap: _launchXlcdAppYouTube,
                              ),
                              Divider(),
                              Image.asset(
                                'assets/images/joy_matcha_media_qrcode.png',
                                fit: BoxFit.contain,
                              ),
                              ListTile(
                                title: Text(
                                    'https://tinyurl.com/joy-matcha-media'),
                                leading: Icon(
                                  Icons.link,
                                  color: Colors.indigo,
                                ),
                                onTap: _launchXlcdAppApp,
                              ),
                              ListTile(
                                title: Text('喜樂抹茶傳媒 YouTube'),
                                leading: Icon(
                                  Icons.video_library,
                                  color: Colors.red,
                                ),
                                onTap: _launchXlcdAppYouTube,
                              ),
                              ListTile(
                                title: Text(
                                    '2019-2019 喜樂抹茶傳媒 Joy Matcha Media. All rights reserved'),
                                leading: Icon(Icons.copyright),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _mediaHandler() {
    _launchXlcdAppYouTube();
  }

  Widget _buildBody(BuildContext context) {
    //XlcdFlavorType type = XlcdFlavorType.prod;
    XlcdFlavorType type = XlcdFlavorType.dev;

    switch (type) {
      case XlcdFlavorType.dev:
        {
          return _buildListFromCache(context, dummySnapshot);
        }

      case XlcdFlavorType.prod:
        {
          return StreamBuilder<QuerySnapshot>(
            stream: widget.firestore
                .collection('joys')
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

    return Padding(
      key: ValueKey(record.title),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        child: ListTile(
          title: Text(record.title),
          subtitle: Text(record.subtitle),
          leading: CircleAvatar(
            backgroundColor:
                XlcdMediaColorList[(record.icon.codeUnitAt(0) - 64)],
            child: Text(
              record.title.substring(0, 1),
              style: TextStyle(
                //color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          trailing: Text(record.votes.toString()),
          onTap: () {
            //record.reference.updateData({'votes': record.votes + 1});
            widget.firestore.runTransaction((transaction) async {
              final freshSnapshot = await transaction
                  .get(record.reference as DocumentReference<Object?>);
              final fresh = Record.fromSnapshot(
                  freshSnapshot as DocumentSnapshot<Map<String, dynamic>>);

              await transaction.update(
                  record.reference as DocumentReference<Object?>,
                  {'votes': fresh.votes + 1});
            });

            _launchURL(record.url);
          },
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

    return Padding(
      key: ValueKey(record.title),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        child: ListTile(
          title: Text(record.title),
          subtitle: Text(record.subtitle),
          leading: CircleAvatar(
            backgroundColor:
                XlcdMediaColorList[(record.icon.codeUnitAt(0) - 64)],
            child: Text(
              //String.fromCharCode(64 + record.icon),
              //record.icon,
              record.title.substring(0, 1),
              style: TextStyle(
                //color: Colors.white,
                //fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          trailing: Text(record.votes.toString()),
          onTap: () => _launchURL(record.url),
        ),
      ),
    );
  }
}
