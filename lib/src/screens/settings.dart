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
  final String xlcdBookIntro = '笑裡藏道: 書本介紹';

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
              child: const Text('請到靈糧書房購買"笑裡藏道"'),
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
  final String xlcdBookAuthor = '曾興才牧師: 笑裡藏道書本作者';

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
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class AppDeveloperSection extends StatelessWidget {
  const AppDeveloperSection({super.key});
  final String xlcdAppAuthor = '張嘉: 笑裡藏道軟件開發';

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
              'assets/photos/xlcd_image_640x640.png',
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
            '  出生於台灣，畢業於文化大學兒童福利系'
            '感謝主的恩典!於1980年留學來美獲得史蒂文斯理工學院電腦碩士，兼職學習獲得金門大學工商管理碩士。'
            '1981年起曾在矽谷數家電腦公司(startups，Rolm，Sun Micro，Yahoo，Microsoft,etc.) 從事電腦資深軟體工程師職務。2023年於Microsoft職場退休。'
            '出於神的恩惠能在教會裡事奉，曾從事小組長，兒童主日學老師及校長，成人主日學老師，執事，區牧，等服事。祈求能成為傳福音的器皿，效法基督，榮神益人。2009年起在「矽谷生命河靈糧堂」聚會和事奉。'
            '與妻子Judy目前一起享受主所賜兒孫滿堂的福份。哈利路亞!「要常常喜樂，不住地禱告，凡事謝恩，因為這是神在基督耶穌裡向你們所定的旨意。」(帖撒羅尼迦前書 5:16-18)',
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
