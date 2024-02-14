import 'package:flutter/material.dart';

import '../components.dart';

class AboutMobile extends StatefulWidget {
  const AboutMobile({Key? key}) : super(key: key);

  @override
  State<AboutMobile> createState() => _AboutMobileState();
}

const versionId = "0.6.1";

class _AboutMobileState extends State<AboutMobile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(size: 35.0, color: Colors.black),
        ),
        endDrawer: DrawersMobile(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              //Introduction, first section
              CircleAvatar(
                radius: 117.0,
                backgroundColor: Colors.tealAccent,
                child: CircleAvatar(
                  radius: 113.0,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 110.0,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      "assets/profile2-circle.png",
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SansBold("笑裡藏道", 35.0),
                    Sans("v$versionId", 15.0),
                    SizedBox(height: 10.0),
                    Sans("作者: 曾興才牧師", 15.0),
                    Sans("曾興才牧師出生於馬來西亞,至英國及美國路易斯安那州攻讀建築學位。", 15.0),
                    Sans(
                        "全職奉獻後於1990年獲得達拉斯神學院神學碩士,曾於德州阿靈頓聖經教會牧會。" +
                            "1995年返回馬來西亞擔任吉隆坡信義會主任牧師。" +
                            "2001年全家返美,加入矽谷生命河靈糧堂事奉團隊,目前負責牧養處事工。" +
                            "與師母 Connie 育有兩個女兒。",
                        15.0),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              _tile('若同樣有功效,能用幽默的笑話,把神的道解明,豈不更好?鄭重推薦本書,幫助你分享真道,有笑果,更有效果!',
                  '靈糧全球使徒性網路主席 周神助', Icons.favorite),
              _tile('', '', Icons.favorite),
              _tile('喜樂的心乃是良藥，憂傷的靈使骨枯乾。', '箴言 17:22', Icons.favorite),
              _tile('神的道是活潑的，是有功效的，比一切兩刃的劍更快。', '希伯來書 4:12', Icons.favorite),

/*
              ListView(
                children: [
                  _tile('喜樂的心乃是良藥，憂傷的靈使骨枯乾。', '箴言 17:22',
                      Icons.heat_pump_rounded),
                  _tile('神的道是活潑的，是有功效的，比一切兩刃的劍更快。', '希伯來書 4:12',
                      Icons.heat_pump_rounded),
                  const Divider(),
                  _tile('a', 'b', Icons.heat_pump_rounded),
                  _tile('c', 'd', Icons.heat_pump_rounded),
                ],
              ),
*/
              SizedBox(height: 40.0),

              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('1177 Laurelwood Rd'),
                      subtitle: const Text('Santa Clara, CA 95054'),
                      leading: Icon(
                        Icons.mail,
                        color: Colors.blue[500],
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text(
                        '1-408-260-0257',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      leading: Icon(
                        Icons.contact_phone,
                        color: Colors.blue[500],
                      ),
                    ),
                    ListTile(
                      title: const Text('office@rolcc.net'),
                      leading: Icon(
                        Icons.contact_mail,
                        color: Colors.blue[500],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}

ListTile _tile(String title, String subtitle, IconData icon) {
  return ListTile(
    title: Text(title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(subtitle),
    leading: Icon(
      icon,
      color: Colors.red[500],
    ),
  );
}
