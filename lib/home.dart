import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'media_list/recommended_media.dart';
import 'partners/rollcall_partner.dart';
import 'lao_liang_videos/lao_liang_videos.dart';
import 'recite_scriptures/recite_scriptures.dart';
import 'xlcdapp/xlcdapp.dart';

class Home extends StatefulWidget {
  Home({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String XlcdAppVersion = "v6.2.2";
  static final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/icons/logo.png'),
        title: Text('喜樂抹茶傳媒'),
      ),
      body: ListView(
        children: <Widget>[
          renderViews('傳媒精華推薦', RecommendedMediaApp()),
          renderViews('背誦經文', ReciteScriptures()),
          renderViews('老梁視頻', LaoLiangVideos()),
          renderViews('點名夥伴', RollCallPartner()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Media',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contacts',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void switchView(StatefulWidget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return widget;
      }),
    );
  }

  ListTile renderViews(String title, StatefulWidget widget) {
    return new ListTile(
      onTap: () {
        switchView(widget);
      },
      title: Text(title,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
//      leading: Icon(
//        Icons.arrow_forward,
//        color: Colors.green,
//      ),
      leading: CircleAvatar(
        backgroundColor: Colors.green,
        child: Text(
          title.substring(0, 1),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) => launch(url);

  void _launchJoyMatchaMediaApp() =>
      launch('https://tinyurl.com/joy-matcha-media');

  void _launchJoyMatchaMediaYouTube() => launch(
      'https://www.youtube.com/channel/UCuvN0Tt_LLL-bOwO8LcOPlw/playlists?view_as=subscriber');

  void _launchJoyMatchaMediaFacebook() =>
      _scaffoldMessengerKey.currentState?.showSnackBar(const SnackBar(
          content: Text("喜樂抹茶傳媒 Facebook - Under Construction.")));

  void _launchJoyMatchaMediaTwitter() =>
      _scaffoldMessengerKey.currentState?.showSnackBar(const SnackBar(
          content: Text("喜樂抹茶傳媒 Twitter - Under Construction.")));

//
//  void _launchJoyMatchaMediaFacebook() => launch(
//      'https://www.youtube.com/channel/UCuvN0Tt_LLL-bOwO8LcOPlw/playlists?view_as=subscriber');
//
//  void _launchJoyMatchaMediaTwitter() => launch(
//      'https://www.youtube.com/channel/UCuvN0Tt_LLL-bOwO8LcOPlw/playlists?view_as=subscriber');

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
            child: ScaffoldMessenger(
              key: _scaffoldMessengerKey,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('聯絡喜樂抹茶傳媒'),
                ),
                //key: _scaffoldKey,
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
                                  subtitle: Text(
                                      '(箴言17:22 『喜樂的心乃是良藥，憂傷的靈使骨枯乾。』) [$XlcdAppVersion]'),
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
                                  onTap: _launchJoyMatchaMediaYouTube,
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
                                  onTap: _launchJoyMatchaMediaApp,
                                ),
                                ListTile(
                                  title: Text('喜樂抹茶傳媒 YouTube'),
                                  leading: Icon(
                                    Icons.video_library,
                                    color: Colors.red,
                                  ),
                                  onTap: _launchJoyMatchaMediaYouTube,
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
            ),
          );
        },
      ),
    );
  }

  void _mediaHandler() {
    _launchJoyMatchaMediaYouTube();
  }

/*
  StatefulWidget _mediaHandler() {
    return RecommendedMediaApp();
  }
*/
}
