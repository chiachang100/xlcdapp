// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../auth.dart';
import '../data.dart';

final xlcdlog = Logger('settings');

Future<void> lauchTargetUrl(String urlString) async {
  Uri urlForPurchasingBook = Uri.parse(urlString);
  if (!await launchUrl(urlForPurchasingBook)) {
    //throw Exception('無法啟動 $urlForPurchasingBook');
  }
}

int circleAvatarBgColorIndex = 0;

Color getNextCircleAvatarBgColor() {
  Color nextColor = circleAvatarBgColor[
      circleAvatarBgColorIndex % circleAvatarBgColor.length];
  circleAvatarBgColorIndex++;
  return nextColor;
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.firestore});
  final FirebaseFirestore firestore;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': '笑裡藏道簡介Screen',
      'xlcdapp_screen_class': 'SettingsScreenClass',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('「笑裡藏道」簡介'),
        leading: Image.asset('assets/icons/xlcdapp-leading-icon.png'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('There are currently no settings available.'),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            tooltip: 'Sign out',
            onPressed: () async {
              await JoystoreAuth.of(context).signOut();
              xlcdlog.info('User just signed out!');

              FirebaseAnalytics.instance
                  .logEvent(name: 'signin_view', parameters: {
                'xlcdapp_screen': 'UserSignedOut',
                'xlcdapp_screen_class': 'SettingsScreenClass',
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SettingsContent(firestore: widget.firestore),
      ),
    );
  }
}

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key, required this.firestore});
  final FirebaseFirestore firestore;

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'SettingsContent',
      'xlcdapp_screen_class': 'SettingsScreenClass',
    });

    return ListView(
      children: const <Widget>[
        QRCodeSection(),
        BookIntroSection(),
        BookAuthorSection(),
        BookPraiseSection(),
        AppDeveloperSection(),
        CopyrightSection(),
        SizedBox(height: 10),
      ],
    );
  }
}

class QRCodeSection extends StatelessWidget {
  const QRCodeSection({super.key});
  final String xlcdQRCodeIntro = '二維碼(QR Code)';

  final String xlcdappWebsiteLink = 'https://xlcdapp.web.app';

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'QRCodeSection',
      'xlcdapp_screen_class': 'SettingsScreenClass',
    });

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
                backgroundColor: getNextCircleAvatarBgColor(),
                child: Text(
                  xlcdQRCodeIntro.substring(0, 1),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                xlcdQRCodeIntro,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Text(
            '  請掃描二維碼(QR Code)便於使用xlcdapp(「笑裡藏道」App)。',
          ),
          // Center(
          //   child: ElevatedButton(
          //     //onPressed: visitXlcdappWebsite,
          //     onPressed: () => lauchTargetUrl(xlcdappWebsiteLink),
          //     child: const Text('🔗xlcdapp(「笑裡藏道」App)'),
          //   ),
          // ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class BookIntroSection extends StatelessWidget {
  const BookIntroSection({super.key});
  final String xlcdBookIntro = '笑裡藏道書籍介紹';

  final String riverbankSite =
      'https://www.rolcc.net/opencart/index.php?route=product/product&product_id=358';
  final String gracephSite = 'https://graceph.com/product/01i072/';

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'BookIntroSection',
      'xlcdapp_screen_class': 'SettingsScreenClass',
    });

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
                backgroundColor: getNextCircleAvatarBgColor(),
                child: Text(
                  xlcdBookIntro.substring(0, 1),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                xlcdBookIntro,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Text(
            '  「笑裡藏道」，曾興才著，天恩出版社，2016年11月初版，2022第七版。'
            '「笑裡藏道」是曾興才牧師首本著作，收集了五十二篇他這些年於矽谷生命河靈糧堂主日證道中分享的精彩笑話及其中引申的經文應用。'
            '喜樂的心乃是良藥，這本讓人開懷大笑的好書，能使大家從幽默文字中領悟屬靈的道理，也為您打開與人分享真理的機會之門！',
          ),
          Row(
            children: [
              const Text('📚購書請到: '),
              ElevatedButton(
                onPressed: () => lauchTargetUrl(gracephSite),
                child: const Text('天恩出版社'),
              ),
              const Text(' / '),
              ElevatedButton(
                onPressed: () => lauchTargetUrl(riverbankSite),
                child: const Text('靈糧書房'),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class BookAuthorSection extends StatelessWidget {
  const BookAuthorSection({super.key});
  final String xlcdBookAuthor = '曾興才牧師: 「笑裡藏道」書籍作者';

  final String youtubePlaylistLink =
      'https://www.youtube.com/results?search_query=%22%E6%9B%BE%E8%88%88%E6%89%8D%E7%89%A7%E5%B8%AB%22';

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'BookAuthorSection',
      'xlcdapp_screen_class': 'SettingsScreenClass',
    });

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
                backgroundColor: getNextCircleAvatarBgColor(),
                child: Text(
                  xlcdBookAuthor.substring(0, 1),
                ),
              ),
              const SizedBox(width: 5),
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
              child: const Text('▶️曾興才牧師講道視頻'),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class BookPraiseSection extends StatelessWidget {
  const BookPraiseSection({super.key});
  final String bookPraiseSectionTitle = '讚揚「笑裡藏道」書籍';

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'BookPraiseSection',
      'xlcdapp_screen_class': 'SettingsScreenClass',
    });

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
                backgroundColor: getNextCircleAvatarBgColor(),
                child: const Icon(Icons.thumb_up_outlined),
                // child: Text(
                //   bookPraiseSectionTitle.substring(0, 1),
                // ),
              ),
              const SizedBox(width: 5),
              Text(
                bookPraiseSectionTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          ListTile(
            leading: CircleAvatar(
                backgroundColor: getNextCircleAvatarBgColor(),
                child: const Text('來')),
            title: const Text(
              '來，領受一份 「幽默感」的恩膏！ 累積你的笑話存款，提升你的親和指數，打開分享真理的機會之門！',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(''),
          ),
          const Divider(height: 0),
          ListTile(
            leading: CircleAvatar(
                backgroundColor: getNextCircleAvatarBgColor(),
                child: const Text('若')),
            title: const Text(
                '若同樣有功效，能用幽默的笑話，把神的道解明，豈不更好？鄭重推薦本書，幫助你分享真道，有笑果，更有效果！'),
            subtitle: const Text('靈糧全球使徒性網絡主席 周神助'),
          ),
          const Divider(height: 0),
          ListTile(
            leading: CircleAvatar(
                backgroundColor: getNextCircleAvatarBgColor(),
                child: const Text('幽')),
            title: const Text(
                '幽默感能使我們從新的角度來看每天周遭發生的事，也使我們可以笑談自己的缺失，並接納別人的軟弱。事實上，幽默感能幫助我們的信仰 更人性化，使人更容易來親近神。'),
            subtitle: const Text('美國加州矽谷生命河靈糧堂主任牧師 劉彤'),
          ),
          const Divider(height: 0),
          ListTile(
            leading: CircleAvatar(
                backgroundColor: getNextCircleAvatarBgColor(),
                child: const Text('曾')),
            title: const Text(
                '曾牧師這本書顛覆傳統，詮釋了矽谷的創新精神⋯⋯一個牧師寫本關於「笑」的書，就如同嚴肅人講笑話，講的時候常有意想不到的效果。'),
            subtitle: const Text('矽谷創新頻道「丁丁電視」創辦人丁維平'),
          ),
          const Divider(height: 0),
          ListTile(
            leading: CircleAvatar(
                backgroundColor: getNextCircleAvatarBgColor(),
                child: const Text('每')),
            title: const Text('每篇短文都像是曾牧師喜歡的一杯好茶，初嚐不酸，再喝不澀，品完後喉韻甘醇，回味無窮。'),
            subtitle: const Text('欣欣教育基金會教育顧問 廖本榮'),
          ),
          const Divider(height: 0),
          ListTile(
            leading: CircleAvatar(
                backgroundColor: getNextCircleAvatarBgColor(),
                child: const Text('獨')),
            title: const Text(
                '獨樂樂，不如眾樂樂。我預測你的朋友們會和你一樣，迫不及待地想要享受 《笑裡藏道》。所以，做一件讓他們大為開懷的事一一送他們一人一本吧！'),
            subtitle: const Text('北加州全福會會長、優勢頻道執行委員會主席 劉效宏'),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class AppDeveloperSection extends StatelessWidget {
  const AppDeveloperSection({super.key});
  final String xlcdAppAuthor = '張嘉: 「笑裡藏道」App開發者';

  final String bibleGatewayLink =
      'https://www.biblegateway.com/passage/?search=%E5%B8%96%E6%92%92%E7%BE%85%E5%B0%BC%E8%BF%A6%E5%89%8D%E6%9B%B8+5%3A16-18&version=CUVMPT';

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'AppDevelopeSection',
      'xlcdapp_screen_class': 'SettingsScreenClass',
    });

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
                backgroundColor: getNextCircleAvatarBgColor(),
                child: Text(
                  xlcdAppAuthor.substring(0, 1),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                xlcdAppAuthor,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Text(
              '  感謝主! 我一生一世如同聖經上應許:「有主的恩惠、慈愛隨著我!」出生於台灣，大學畢業，服完兵役，來美留學，完成電腦碩士及兼職完成企管碩士。'
              '1981年起即在矽谷電腦公司，從事多種電腦軟體工程開發。2023年從Microsoft退休。'
              '業餘時領受主的呼召及恩典，在教會裡擔任過多種事奉，傳主福音，跟隨耶穌，榮神益人。'
              '與妻子Judy目前領受主賜兒孫滿堂。'
              '祈求藉著「笑裡藏道」書籍+App為主多傳喜樂的福音，領人歸主。頌讚、榮耀歸於我們的神，直到永永遠遠！阿們。'),
          Center(
            child: ElevatedButton(
              //onPressed: visitBibleWebsite,
              onPressed: () => lauchTargetUrl(bibleGatewayLink),
              child: const Text('✝️線上閱讀聖經'),
            ),
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
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'CopyrightSection',
      'xlcdapp_screen_class': 'SettingsScreenClass',
    });

    return Card(
      color: Colors.yellow[50],
      elevation: 8.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: const Column(
        children: <Widget>[
          Text('Copyright (c) 2024 Chia Chang. All rights reserved.'),
        ],
      ),
    );
  }
}
