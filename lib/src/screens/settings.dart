// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import '../auth.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

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
        body: const SafeArea(
          child: SettingsContent(),
        ),
      );
}

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        BookIntroSection(),
        BookAuthorSection(),
        AppDeveloperSection(),
        CopyrightSection(),
        SizedBox(height: 10),
      ],
    );
  }
}

class BookIntroSection extends StatelessWidget {
  const BookIntroSection({super.key});
  final String xlcdBookIntro = '笑裡藏道書籍介紹';

  final String bookSiteLink =
      'https://www.rolcc.net/opencart/index.php?route=product/product&product_id=358';

  Future<void> purchaseBook() async {
    Uri urlForPurchasingBook = Uri.parse(bookSiteLink);
    if (!await launchUrl(urlForPurchasingBook)) {
      throw Exception('無法啟動 $urlForPurchasingBook');
    }
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
                backgroundColor: Colors.orange,
                child: Text(
                  xlcdBookIntro.substring(0, 1),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Text(
                xlcdBookIntro,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Text(
            '  笑裡藏道，曾興才著，天恩出版社，2016年11月初版，2022第七版。'
            '"笑裡藏道"是曾興才牧師首本著作，收集了五十二篇他這些年於矽谷生命河靈糧堂主日證道中分享的精彩笑話及其中引申的經文應用。'
            '喜樂的心乃是良藥，這本讓人開懷大笑的好書，能使大家從幽默文字中領悟屬靈的道理，也為您打開與人分享真理的機會之門！',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: purchaseBook,
              child: const Text('請到靈糧書房購買"笑裡藏道"書籍'),
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

  Future<void> viewPlaylist() async {
    Uri urlForViewPlaylist = Uri.parse(youtubePlaylistLink);
    if (!await launchUrl(urlForViewPlaylist)) {
      throw Exception('無法啟動 $urlForViewPlaylist');
    }
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
                backgroundColor: Colors.orange,
                child: Text(
                  xlcdBookAuthor.substring(0, 1),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Text(
                xlcdBookAuthor,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Text(
            '  出生於馬來西亞，至英國及美國路易斯安那州攻讀建築學位。'
            '全職奉獻後於1990年獲得達拉斯神學院神學碩士，曾於德州阿靈頓聖經教會牧會。'
            '1995年返回馬來西亞擔任吉隆坡信義會主任牧師。'
            '2001年全家返美，加入「矽谷生命河靈糧堂」事奉團隊，目前負責牧養處事工。'
            '與師母 Connie 育有兩個女兒。',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: viewPlaylist,
              child: const Text('觀賞曾興才牧師YouTube講道視頻'),
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
                backgroundColor: Colors.orange,
                child: Text(
                  xlcdAppAuthor.substring(0, 1),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Text(
                xlcdAppAuthor,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Text(
            '  感謝主!我一生一世如神應許:「必有主的恩惠、慈愛隨著我!」出生於台灣，大學畢業，服完兵役，來美留學，完成電腦碩士及兼職完成企管碩士。'
            '1981年起即在矽谷電腦公司，從事多種電腦軟體工程開發。2023年於Microsoft職場上退休。'
            '業餘時靠著主的恩典得在教會裡擔任過多種事奉，傳主福音，跟隨耶穌，榮神益人。'
            '與妻子Judy目前領受主賜兒孫滿堂。'
            '祈求藉著"笑裡藏道"書籍+App能為主多傳喜樂的福音，領人歸主。哈利路亞!頌讚、榮耀歸於我們的神，直到永永遠遠！阿們。'
            '\n\n「要常常喜樂，不住地禱告，凡事謝恩，因為這是神在基督耶穌裡向你們所定的旨意。」(帖撒羅尼迦前書 5:16-18)。',
            style: TextStyle(
              fontSize: 14,
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
