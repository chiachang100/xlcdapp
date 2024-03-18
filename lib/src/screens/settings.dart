// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:xlcdapp/src/data/firestore_joy.dart';
//import 'package:xlcdapp/src/data/firestore_db.dart';

import '../auth.dart';
import '../data/joy.dart';
import '../data/joystore.dart';

const showFirebaseDb = true;

Future<void> lauchTargetUrl(String urlString) async {
  Uri urlForPurchasingBook = Uri.parse(urlString);
  if (!await launchUrl(urlForPurchasingBook)) {
    //throw Exception('無法啟動 $urlForPurchasingBook');
  }
}

List<Color> circleAvatarBgColor = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.amber,
  Colors.grey,
];

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.firestore});
  final FirebaseFirestore firestore;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('笑裡藏道簡介'),
          leading: Image.asset('assets/icons/xlcdapp-leading-icon.png'),
        ),
        body: SafeArea(
          child: SettingsContent(firestore: widget.firestore),
        ),
      );
}

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key, required this.firestore});
  final FirebaseFirestore firestore;

  Widget showFirebaseDbSection() {
    if (showFirebaseDb) {
      return FirebaseDbSection(firestore: firestore);
    } else {
      return const SizedBox(height: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const BookIntroSection(),
        const BookAuthorSection(),
        const AppDeveloperSection(),
        const QRCodeSection(),
        showFirebaseDbSection(),
        const CopyrightSection(),
        const SizedBox(height: 10),
      ],
    );
  }
}

class BookIntroSection extends StatelessWidget {
  const BookIntroSection({super.key});
  final String xlcdBookIntro = '笑裡藏道書籍介紹';

  final String bookSiteLink =
      'https://www.rolcc.net/opencart/index.php?route=product/product&product_id=358';

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow[50],
      elevation: 8.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/photos/xlcd_book_photo.png',
              height: MediaQuery.of(context).size.width * (3 / 4),
              width: MediaQuery.of(context).size.width,
              //height: 120, width: 640,
              fit: BoxFit.scaleDown,
            ),
          ),
          Row(
            children: [
              CircleAvatar(
                //backgroundColor: Colors.orange,
                backgroundColor: circleAvatarBgColor[0],
                child: Text(
                  xlcdBookIntro.substring(0, 1),
                ),
              ),
              Text(
                xlcdBookIntro,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Text(
            '  笑裡藏道，曾興才著，天恩出版社，2016年11月初版，2022第七版。'
            '"笑裡藏道"是曾興才牧師首本著作，收集了五十二篇他這些年於矽谷生命河靈糧堂主日證道中分享的精彩笑話及其中引申的經文應用。'
            '喜樂的心乃是良藥，這本讓人開懷大笑的好書，能使大家從幽默文字中領悟屬靈的道理，也為您打開與人分享真理的機會之門！',
          ),
          Center(
            child: ElevatedButton(
              //onPressed: visitBuyBookWebsite,
              onPressed: () => lauchTargetUrl(bookSiteLink),
              child: const Text('📚靈糧書房購買書'),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class BookAuthorSection extends StatelessWidget {
  const BookAuthorSection({super.key});
  final String xlcdBookAuthor = '曾興才牧師: "笑裡藏道"書籍作者';

  final String youtubePlaylistLink =
      'https://www.youtube.com/results?search_query=%22%E6%9B%BE%E8%88%88%E6%89%8D%E7%89%A7%E5%B8%AB%22';

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow[50],
      elevation: 8.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/photos/pastor_cheng_photo.png',
              height: MediaQuery.of(context).size.width * (3 / 4),
              width: MediaQuery.of(context).size.width,
              //height: 120, width: 640,
              fit: BoxFit.scaleDown,
            ),
          ),
          Row(
            children: [
              CircleAvatar(
                //backgroundColor: Colors.orange,
                backgroundColor: circleAvatarBgColor[1],
                child: Text(
                  xlcdBookAuthor.substring(0, 1),
                ),
              ),
              Text(
                xlcdBookAuthor,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Text(
            '  出生於馬來西亞，至英國及美國路易斯安那州攻讀建築學位。'
            '全職奉獻後於1990年獲得達拉斯神學院神學碩士，曾於德州阿靈頓聖經教會牧會。'
            '1995年返回馬來西亞擔任吉隆坡信義會主任牧師。'
            '2001年全家返美，加入「矽谷生命河靈糧堂」事奉團隊，目前負責牧養處事工。'
            '與師母 Connie 育有兩個女兒。',
          ),
          Center(
            child: ElevatedButton(
              //onPressed: visitYouTubePlaylist,
              onPressed: () => lauchTargetUrl(youtubePlaylistLink),
              child: const Text('▶️曾牧師講道視頻'),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class AppDeveloperSection extends StatelessWidget {
  const AppDeveloperSection({super.key});
  final String xlcdAppAuthor = '張嘉: "笑裡藏道"App開發者';

  final String bibleGatewayLink =
      'https://www.biblegateway.com/passage/?search=%E5%B8%96%E6%92%92%E7%BE%85%E5%B0%BC%E8%BF%A6%E5%89%8D%E6%9B%B8+5%3A16-18&version=CUVMPT';

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow[50],
      elevation: 8.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/photos/joy_pray_thanks.png',
              height: MediaQuery.of(context).size.width * (3 / 4),
              width: MediaQuery.of(context).size.width,
              //height: 120, width: 640,
              fit: BoxFit.scaleDown,
            ),
          ),
          Row(
            children: [
              CircleAvatar(
                //backgroundColor: Colors.orange,
                backgroundColor: circleAvatarBgColor[2],
                child: Text(
                  xlcdAppAuthor.substring(0, 1),
                ),
              ),
              Text(
                xlcdAppAuthor,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Text(
              '  感謝主! 我一生一世如同聖經上應許:「必有主的恩惠、慈愛隨著我!」出生於台灣，大學畢業，服完兵役，來美留學，完成電腦碩士及兼職完成企管碩士。'
              '1981年起即在矽谷電腦公司，從事多種電腦軟體工程開發。2023年職場上於Microsoft退休。'
              '業餘時領受主的呼召及恩典，得在教會裡擔任過多種事奉，傳主福音，跟隨耶穌，榮神益人。'
              '與妻子Judy目前領受主賜兒孫滿堂。'
              '祈求藉著"笑裡藏道"書籍+App能為主多傳喜樂的福音，領人歸主。哈利路亞! 頌讚、榮耀歸於我們的神，直到永永遠遠！阿們。'),
          Center(
            child: ElevatedButton(
              //onPressed: visitBibleWebsite,
              onPressed: () => lauchTargetUrl(bibleGatewayLink),
              child: const Text('✝️請閱讀線上聖經'),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class QRCodeSection extends StatelessWidget {
  const QRCodeSection({super.key});
  final String xlcdQRCodeIntro = 'QR Code: xlcdapp(笑裡藏道 App)';

  final String xlcdappWebsiteLink = 'https://xlcdapp.web.app';

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow[50],
      elevation: 8.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/xlcdapp_qrcode.png',
              height: MediaQuery.of(context).size.width * (2 / 4),
              width: MediaQuery.of(context).size.width,
              //height: 120, width: 640,
              fit: BoxFit.scaleDown,
            ),
          ),
          Row(
            children: [
              CircleAvatar(
                //backgroundColor: Colors.orange,
                backgroundColor: circleAvatarBgColor[0],
                child: Text(
                  xlcdQRCodeIntro.substring(0, 1),
                ),
              ),
              Text(
                xlcdQRCodeIntro,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Text(
            '  請掃描xlcdapp QR Code 以便於使用 xlcdapp(笑裡藏道 App)。',
          ),
          Center(
            child: ElevatedButton(
              //onPressed: visitXlcdappWebsite,
              onPressed: () => lauchTargetUrl(xlcdappWebsiteLink),
              child: const Text('🔗xlcdapp(笑裡藏道 App)'),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class FirebaseDbSection extends StatelessWidget {
  const FirebaseDbSection({super.key, required this.firestore});
  final FirebaseFirestore firestore;

  final String xlcdFirestore = '儲藏庫初始設定和搜尋';

  void joysAddData() async {
    // Add new documents
    //for (var joy in firestoreDbInstance.allJoys) {
    for (var joy in joystoreInstance.allJoys) {
      // firestore.collection("joys").add(joy.toFirestore()).then(
      //     (DocumentReference doc) =>
      //         print('DocumentSnapshot added with ID: ${doc.id}'));
      final docRef = firestore.collection("joys").doc(joy.articleId.toString());
      // Add document
      docRef
          .set(joy.toJson())
          .onError((e, _) => print("Error writing documen(t: $e"));
      // Read document
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          print('DocumentSnapshot added with ID: ${doc.id}:${data['id']}');
        },
        onError: (e) => print("Error getting document: $e"),
      );
    }
  }

  void joysReadData() async {
    await firestore.collection("joys").get().then((event) {
      for (var doc in event.docs) {
        print("Firestore: ${doc.id} => ${doc.data()}");
        var joy = Joy.fromJson(doc.data());
        print(
            "Joy: ${doc.id} => id=${joy.id}:articleId=${joy.articleId}:likes=${joy.likes}:isNew=${joy.isNew}:category=${joy.category}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow[50],
      elevation: 8.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/photos/xlcdapp_photo_default.png',
              height: MediaQuery.of(context).size.width * (3 / 4),
              width: MediaQuery.of(context).size.width,
              //height: 120, width: 640,
              fit: BoxFit.scaleDown,
            ),
          ),
          Row(
            children: [
              CircleAvatar(
                //backgroundColor: Colors.orange,
                backgroundColor: circleAvatarBgColor[2],
                child: Text(
                  xlcdFirestore.substring(0, 1),
                ),
              ),
              Text(
                xlcdFirestore,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Text('笑裡藏道: 儲藏庫初始設定和搜尋'),
          Center(
            child: ElevatedButton(
              onPressed: joysReadData,
              child: const Text('🔍搜尋'),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: joysAddData,
            child: const Text('⚙️初始設定'),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class CopyrightSection extends StatelessWidget {
  const CopyrightSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: <Widget>[
        Text('Copyright '),
        Icon(Icons.copyright),
        Text(
          ' 2024 Chia Chang. All rights reserved.',
          softWrap: true,
        ),
      ],
    );
  }
}
