import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import '../auth.dart';
import '../data.dart';

final xlcdlogSettings = Logger('settings');

Future<void> lauchTargetUrl(String urlString) async {
  Uri urlForPurchasingBook = Uri.parse(urlString);
  if (!await launchUrl(urlForPurchasingBook)) {
    //throw Exception('無法啟動 $urlForPurchasingBook');
  }
}

int circleAvatarBgColorIndex = 0;

enum LanguageType { traditional, simplified }

LanguageType getCurrentLanguage() {
  var lang = LanguageType.traditional;
  switch (joysCurrentLocale) {
    case LOCALE_ZH_CN:
      lang = LanguageType.simplified;
    case LOCALE_ZH_TW:
      lang = LanguageType.traditional;
    default:
      lang = LanguageType.traditional;
  }
  return lang;
}

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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset('assets/icons/xlcdapp-leading-icon.png'),
              onPressed: () {
                GoRouter.of(context).go('/joys/all');
              },
            );
          },
        ),
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
      children: <Widget>[
        QRCodeSection(),
        const LanguageSection(),
        BookIntroSection(),
        BookAuthorSection(),
        BookPraiseSection(),
        AppDeveloperSection(),
        const CopyrightSection(),
        const SizedBox(height: 10),
      ],
    );
  }
}

class QRCodeSection extends StatelessWidget {
  QRCodeSection({super.key});
  final String xlcdQRCodeIntro =
      joysCurrentLocale == LOCALE_ZH_CN ? '二维码(QR Code)' : '二維碼(QR Code)';

  final String xlcdappWebsiteLink = 'https://xlcdapp.web.app';

  String getQRCodeDescription() {
    String str = '';

    switch (joysCurrentLocale) {
      case LOCALE_ZH_CN:
        str = '  请扫描二维码(QR Code)便于使用xlcdapp(「笑里藏道」App)。';
      case LOCALE_ZH_TW:
      default:
        str = '  請掃描二維碼(QR Code)便於使用xlcdapp(「笑裡藏道」App)。';
    }
    return str;
  }

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
              'assets/icons/xlcdapp_qrcode.png',
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
          Text(getQRCodeDescription()),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class LanguageSection extends StatefulWidget {
  const LanguageSection({super.key});

  @override
  State<LanguageSection> createState() => _LanguageSectionState();
}

class _LanguageSectionState extends State<LanguageSection> {
  final String xlcdLanguageSelection =
      joysCurrentLocale == LOCALE_ZH_CN ? '设定喜好' : '設定喜好';

  final String xlcdappWebsiteLink = 'https://xlcdapp.web.app';

  LanguageType? _language = getCurrentLanguage();

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'LanguageSection',
      'xlcdapp_screen_class': 'SettingsScreenClass',
    });

    return Card(
      color: Colors.yellow[50],
      elevation: 8.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              CircleAvatar(
                backgroundColor: getNextCircleAvatarBgColor(),
                child: Text(
                  xlcdLanguageSelection.substring(0, 1),
                ),
              ),
              Expanded(
                child: Text(
                  xlcdLanguageSelection,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            children: <Widget>[
              //const Text('語言選擇: '),
              RadioListTile<LanguageType>(
                  title: const Text('繁體'),
                  value: LanguageType.traditional,
                  groupValue: _language,
                  onChanged: (LanguageType? value) {
                    setState(() {
                      _language = value;
                      joysCurrentLocale = LOCALE_ZH_TW;
                      joystoreName = JOYSTORE_NAME_ZH_TW;
                    });
                  }),
              RadioListTile<LanguageType>(
                  title: const Text('簡體'),
                  value: LanguageType.simplified,
                  groupValue: _language,
                  onChanged: (LanguageType? value) {
                    setState(() {
                      _language = value;
                      joysCurrentLocale = LOCALE_ZH_CN;
                      joystoreName = JOYSTORE_NAME_ZH_CN;
                    });
                  }),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class BookIntroSection extends StatelessWidget {
  BookIntroSection({super.key});
  final String xlcdBookIntro =
      joysCurrentLocale == LOCALE_ZH_CN ? '笑里藏道书籍介绍' : '笑裡藏道書籍介紹';

  final String riverbankSite =
      'https://www.rolcc.net/opencart/index.php?route=product/product&product_id=358';
  final String gracephSite = 'https://graceph.com/product/01i072/';

  String getBookIntroDescription() {
    String str = '';

    switch (joysCurrentLocale) {
      case LOCALE_ZH_CN:
        str = '  「笑里藏道」，曾兴才着，天恩出版社，2016年11月初版，2022第七版。 '
            '「笑里藏道」是曾兴才牧师首本著作，收集了五十二篇他这些年于矽谷生命河灵粮堂主日证道中分享的精彩笑话及其中引申的经文应用。 '
            '喜乐的心乃是良药，这本让人开怀大笑的好书，能使大家从幽默文字中领悟属灵的道理，也为您打开与人分享真理的机会之门！ ';
      case LOCALE_ZH_TW:
      default:
        str = '  「笑裡藏道」，曾興才著，天恩出版社，2016年11月初版，2022第七版。'
            '「笑裡藏道」是曾興才牧師首本著作，收集了五十二篇他這些年於矽谷生命河靈糧堂主日證道中分享的精彩笑話及其中引申的經文應用。'
            '喜樂的心乃是良藥，這本讓人開懷大笑的好書，能使大家從幽默文字中領悟屬靈的道理，也為您打開與人分享真理的機會之門！';
    }
    return str;
  }

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
          Text(getBookIntroDescription()),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => lauchTargetUrl(gracephSite),
                child: const Text('天恩出版社'),
              ),
              const Text(' || '),
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
  BookAuthorSection({super.key});
  final String xlcdBookAuthor = joysCurrentLocale == LOCALE_ZH_CN
      ? '曾兴才牧师: 「笑里藏道」书籍作者'
      : '曾興才牧師: 「笑裡藏道」書籍作者';

  final String youtubePlaylistLink =
      'https://www.youtube.com/results?search_query=%22%E6%9B%BE%E8%88%88%E6%89%8D%E7%89%A7%E5%B8%AB%22';

  String getBookAuthorDescription() {
    String str = '';

    switch (joysCurrentLocale) {
      case LOCALE_ZH_CN:
        str = '  出生于马来西亚，至英国及美国路易斯安那州攻读建筑学位。 '
            '全职奉献后于1990年获得达拉斯神学院神学硕士，曾于德州阿灵顿圣经教会牧会。 '
            '1995年返回马来西亚担任吉隆坡信义会主任牧师。 '
            '2001年全家返美，加入「矽谷生命河灵粮堂」事奉团队，目前负责牧养处事工。 '
            '与师母 Connie 育有两个女儿。 ';
      case LOCALE_ZH_TW:
      default:
        str = '  出生於馬來西亞，至英國及美國路易斯安那州攻讀建築學位。'
            '全職奉獻後於1990年獲得達拉斯神學院神學碩士，曾於德州阿靈頓聖經教會牧會。'
            '1995年返回馬來西亞擔任吉隆坡信義會主任牧師。'
            '2001年全家返美，加入「矽谷生命河靈糧堂」事奉團隊，目前負責牧養處事工。'
            '與師母 Connie 育有兩個女兒。';
    }
    return str;
  }

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
          Text(getBookAuthorDescription()),
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
  BookPraiseSection({super.key});
  final String bookPraiseSectionTitle =
      joysCurrentLocale == LOCALE_ZH_CN ? '赞扬「笑里藏道」书籍' : '讚揚「笑裡藏道」書籍';

  String getBookPraiseDescription1() {
    String str = '';
    switch (joysCurrentLocale) {
      case LOCALE_ZH_CN:
        str = '来，领受一份 「幽默感」的恩膏！ 累积你的笑话存款，提升你的亲和指数，打开分享真理的机会之门！';
      case LOCALE_ZH_TW:
      default:
        str = '來，領受一份 「幽默感」的恩膏！ 累積你的笑話存款，提升你的親和指數，打開分享真理的機會之門！';
    }
    return str;
  }

  String getBookPraiseDescription2Title() {
    String str = '';
    switch (joysCurrentLocale) {
      case LOCALE_ZH_CN:
        str = '若同样有功效，能用幽默的笑话，把神的道解明，岂不更好？ 郑重推荐本书，帮助你分享真道，有笑果，更有效果！';
      case LOCALE_ZH_TW:
      default:
        str = '若同樣有功效，能用幽默的笑話，把神的道解明，豈不更好？鄭重推薦本書，幫助你分享真道，有笑果，更有效果！';
    }
    return str;
  }

  String getBookPraiseDescription2SubTitle() {
    String str = '';
    switch (joysCurrentLocale) {
      case LOCALE_ZH_CN:
        str = '👍灵粮全球使徒性网络主席 周神助';
      case LOCALE_ZH_TW:
      default:
        str = '👍靈糧全球使徒性網絡主席 周神助';
    }
    return str;
  }

  String getBookPraiseDescription3Title() {
    String str = '';
    switch (joysCurrentLocale) {
      case LOCALE_ZH_CN:
        str =
            '幽默感能使我们从新的角度来看每天周遭发生的事，也使我们可以笑谈自己的缺失，并接纳别人的软弱。 事实上，幽默感能帮助我们的信仰 更人性化，使人更容易来亲近神。';
      case LOCALE_ZH_TW:
      default:
        str =
            '幽默感能使我們從新的角度來看每天周遭發生的事，也使我們可以笑談自己的缺失，並接納別人的軟弱。事實上，幽默感能幫助我們的信仰 更人性化，使人更容易來親近神。';
    }
    return str;
  }

  String getBookPraiseDescription3SubTitle() {
    String str = '';
    switch (joysCurrentLocale) {
      case LOCALE_ZH_CN:
        str = '👍美国加州矽谷生命河灵粮堂主任牧师 刘彤';
      case LOCALE_ZH_TW:
      default:
        str = '👍美國加州矽谷生命河靈糧堂主任牧師 劉彤';
    }
    return str;
  }

  String getBookPraiseDescription4Title() {
    String str = '';
    switch (joysCurrentLocale) {
      case LOCALE_ZH_CN:
        str = '曾牧师这本书颠覆传统，诠释了矽谷的创新精神⋯⋯一个牧师写本关于「笑」的书，就如同严肃人讲笑话，讲的时候常有意想不到的效果。';
      case LOCALE_ZH_TW:
      default:
        str = '曾牧師這本書顛覆傳統，詮釋了矽谷的創新精神⋯⋯一個牧師寫本關於「笑」的書，就如同嚴肅人講笑話，講的時候常有意想不到的效果。';
    }
    return str;
  }

  String getBookPraiseDescription4SubTitle() {
    String str = '';
    switch (joysCurrentLocale) {
      case LOCALE_ZH_CN:
        str = '👍矽谷创新频道「丁丁电视」创办人丁维平';
      case LOCALE_ZH_TW:
      default:
        str = '👍矽谷創新頻道「丁丁電視」創辦人丁維平';
    }
    return str;
  }

  String getBookPraiseDescription5Title() {
    String str = '';
    switch (joysCurrentLocale) {
      case LOCALE_ZH_CN:
        str = '每篇短文都像是曾牧师喜欢的一杯好茶，初尝不酸，再喝不涩，品完后喉韵甘醇，回味无穷。';
      case LOCALE_ZH_TW:
      default:
        str = '每篇短文都像是曾牧師喜歡的一杯好茶，初嚐不酸，再喝不澀，品完後喉韻甘醇，回味無窮。';
    }
    return str;
  }

  String getBookPraiseDescription5SubTitle() {
    String str = '';
    switch (joysCurrentLocale) {
      case LOCALE_ZH_CN:
        str = '👍欣欣教育基金会教育顾问 廖本荣';
      case LOCALE_ZH_TW:
      default:
        str = '👍欣欣教育基金會教育顧問 廖本榮';
    }
    return str;
  }

  String getBookPraiseDescription6Title() {
    String str = '';
    switch (joysCurrentLocale) {
      case LOCALE_ZH_CN:
        str =
            '独乐乐，不如众乐乐。 我预测你的朋友们会和你一样，迫不及待地想要享受 《笑里藏道》。 所以，做一件让他们大为开怀的事一一送他们一人一本吧！';
      case LOCALE_ZH_TW:
      default:
        str =
            '獨樂樂，不如眾樂樂。我預測你的朋友們會和你一樣，迫不及待地想要享受 《笑裡藏道》。所以，做一件讓他們大為開懷的事一一送他們一人一本吧！';
    }
    return str;
  }

  String getBookPraiseDescription6SubTitle() {
    String str = '';
    switch (joysCurrentLocale) {
      case LOCALE_ZH_CN:
        str = '👍北加州全福会会长、优势频道执行委员会主席 刘效宏';
      case LOCALE_ZH_TW:
      default:
        str = '👍北加州全福會會長、優勢頻道執行委員會主席 劉效宏';
    }
    return str;
  }

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
            title: Text(
              getBookPraiseDescription1(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(''),
          ),
          const Divider(height: 0),
          ListTile(
            leading: CircleAvatar(
                backgroundColor: getNextCircleAvatarBgColor(),
                child: const Text('若')),
            title: Text(getBookPraiseDescription2Title()),
            subtitle: Text(
              getBookPraiseDescription2SubTitle(),
              style: const TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const Divider(height: 0),
          ListTile(
            leading: CircleAvatar(
                backgroundColor: getNextCircleAvatarBgColor(),
                child: const Text('幽')),
            title: Text(getBookPraiseDescription3Title()),
            subtitle: Text(
              getBookPraiseDescription3SubTitle(),
              style: const TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const Divider(height: 0),
          ListTile(
            leading: CircleAvatar(
                backgroundColor: getNextCircleAvatarBgColor(),
                child: const Text('曾')),
            title: Text(getBookPraiseDescription4Title()),
            subtitle: Text(
              getBookPraiseDescription4SubTitle(),
              style: const TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const Divider(height: 0),
          ListTile(
            leading: CircleAvatar(
                backgroundColor: getNextCircleAvatarBgColor(),
                child: const Text('每')),
            title: Text(getBookPraiseDescription5Title()),
            subtitle: Text(
              getBookPraiseDescription5SubTitle(),
              style: const TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const Divider(height: 0),
          ListTile(
            leading: CircleAvatar(
                backgroundColor: getNextCircleAvatarBgColor(),
                child: const Text('獨')),
            title: Text(getBookPraiseDescription6Title()),
            subtitle: Text(
              getBookPraiseDescription6SubTitle(),
              style: const TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class AppDeveloperSection extends StatelessWidget {
  AppDeveloperSection({super.key});
  final String xlcdAppAuthor = joysCurrentLocale == LOCALE_ZH_CN
      ? '张嘉: 「笑里藏道」App开发者'
      : '張嘉: 「笑裡藏道」App開發者';

  final String bibleGatewayLink =
      'https://www.biblegateway.com/passage/?search=%E5%B8%96%E6%92%92%E7%BE%85%E5%B0%BC%E8%BF%A6%E5%89%8D%E6%9B%B8+5%3A16-18&version=CUVMPT';

  String getAppDeveloperDescription() {
    String str = '';

    switch (joysCurrentLocale) {
      case LOCALE_ZH_CN:
        str =
            '  感谢主! 我一生一世如同圣经上应许:「有主的恩惠、慈爱随着我!」出生于台湾，大学毕业，服完兵役，来美留学，完成电脑硕士及兼职完成企管硕士。 '
            '1981年起即在矽谷电脑公司，从事多种电脑软体工程开发。 2023年从Microsoft退休。 '
            '业余时领受主的呼召及恩典，在教会里担任过多种事奉，传主福音，跟随耶稣，荣神益人。 '
            '与妻子Judy目前领受主赐儿孙满堂。 '
            '祈求借着「笑里藏道」书籍+App为主多传喜乐的福音，领人归主。 颂赞、荣耀归于我们的神，直到永永远远！ 阿们。 ';
      case LOCALE_ZH_TW:
      default:
        str =
            '  感謝主! 我一生一世如同聖經上應許:「有主的恩惠、慈愛隨著我!」出生於台灣，大學畢業，服完兵役，來美留學，完成電腦碩士及兼職完成企管碩士。'
            '1981年起即在矽谷電腦公司，從事多種電腦軟體工程開發。2023年從Microsoft退休。'
            '業餘時領受主的呼召及恩典，在教會裡擔任過多種事奉，傳主福音，跟隨耶穌，榮神益人。'
            '與妻子Judy目前領受主賜兒孫滿堂。'
            '祈求藉著「笑裡藏道」書籍+App為主多傳喜樂的福音，領人歸主。頌讚、榮耀歸於我們的神，直到永永遠遠！阿們。';
    }
    return str;
  }

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
          Text(getAppDeveloperDescription()),
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
          Text('Copyright 2024 Chia Chang. Apache License, Version 2.0.'),
        ],
      ),
    );
  }
}
