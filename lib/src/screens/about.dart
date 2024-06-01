import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import '../auth.dart';
import '../data.dart';
import '../services/locale_services.dart';
import '../services/data_services.dart';
import '../widgets/copyright.dart';

final xlcdlogAbout = Logger('about');

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

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key, required this.firestore});
  final FirebaseFirestore firestore;

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': '笑裡藏道簡介Screen',
      'xlcdapp_screen_class': 'AboutScreenClass',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleServices.getAboutScreenTitle()),
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
        child: AboutContent(firestore: widget.firestore),
      ),
    );
  }
}

class AboutContent extends StatefulWidget {
  const AboutContent({super.key, required this.firestore});
  final FirebaseFirestore firestore;

  @override
  State<AboutContent> createState() => _AboutContentState();
}

class _AboutContentState extends State<AboutContent> {
  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'AboutContent',
      'xlcdapp_screen_class': 'AboutScreenClass',
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

class QRCodeSection extends StatefulWidget {
  const QRCodeSection({super.key});

  @override
  State<QRCodeSection> createState() => _QRCodeSectionState();
}

class _QRCodeSectionState extends State<QRCodeSection> {
  String xlcdQRCodeIntro = LocaleServices.getQRCodeIntro();

  final String xlcdappWebsiteLink = 'https://xlcdapp.web.app';

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'QRCodeSection',
      'xlcdapp_screen_class': 'AboutScreenClass',
    });

    return Card(
      // color: Colors.yellow[50],
      elevation: 8.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Text(
            xlcdQRCodeIntro,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text('${LocaleServices.getQRCodeDescription()} (v$appVersion)'),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class BookIntroSection extends StatefulWidget {
  const BookIntroSection({super.key});

  @override
  State<BookIntroSection> createState() => _BookIntroSectionState();
}

class _BookIntroSectionState extends State<BookIntroSection> {
  String xlcdBookIntro = LocaleServices.getBookIntro();

  final String riverbankSite =
      'https://www.rolcc.net/opencart/index.php?route=product/product&product_id=358';

  final String gracephSite = 'https://graceph.com/product/01i072/';

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'BookIntroSection',
      'xlcdapp_screen_class': 'AboutScreenClass',
    });

    return Card(
      // color: Colors.yellow[50],
      elevation: 8.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Text(
            xlcdBookIntro,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(LocaleServices.getBookIntroDescription()),
          Center(
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                ElevatedButton(
                  onPressed: () => lauchTargetUrl(gracephSite),
                  child: Text(LocaleServices.getGraceBookStoreButtonLabel()),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () => lauchTargetUrl(riverbankSite),
                  child: Text(LocaleServices.getRiverBookStoreButtonLabel()),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class BookAuthorSection extends StatefulWidget {
  const BookAuthorSection({super.key});

  @override
  State<BookAuthorSection> createState() => _BookAuthorSectionState();
}

class _BookAuthorSectionState extends State<BookAuthorSection> {
  String xlcdBookAuthor = LocaleServices.getBookAuthor();

  final String youtubePlaylistLink =
      'https://www.youtube.com/results?search_query=%22%E6%9B%BE%E8%88%88%E6%89%8D%E7%89%A7%E5%B8%AB%22';

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'BookAuthorSection',
      'xlcdapp_screen_class': 'AboutScreenClass',
    });

    return Card(
      // color: Colors.yellow[50],
      elevation: 8.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Text(
            xlcdBookAuthor,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(LocaleServices.getBookAuthorDescription()),
          Center(
            child: ElevatedButton(
              //onPressed: visitYouTubePlaylist,
              onPressed: () => lauchTargetUrl(youtubePlaylistLink),
              child: Text(LocaleServices.getBookAuthorVideoButtonLabel()),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class BookPraiseSection extends StatefulWidget {
  const BookPraiseSection({super.key});

  @override
  State<BookPraiseSection> createState() => _BookPraiseSectionState();
}

class _BookPraiseSectionState extends State<BookPraiseSection> {
  String bookPraiseSectionTitle = LocaleServices.getBookPraiseSectionTitle();

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'BookPraiseSection',
      'xlcdapp_screen_class': 'AboutScreenClass',
    });

    return Card(
      // color: Colors.yellow[50],
      elevation: 8.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Text(
            bookPraiseSectionTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            // tileColor: Colors.yellow[50],
            title: Text(
              LocaleServices.getBookPraiseDescription1(),
              // style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(''),
          ),
          const Divider(height: 0),
          ListTile(
            // leading: CircleAvatar(
            //     backgroundColor: getNextCircleAvatarBgColor(),
            //     child: const Text('若')),
            title: Text(LocaleServices.getBookPraiseDescription2Title()),
            subtitle: Center(
              child: Text(
                LocaleServices.getBookPraiseDescription2SubTitle(),
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          const Divider(height: 0),
          ListTile(
            // tileColor: Colors.yellow[50],
            title: Text(LocaleServices.getBookPraiseDescription3Title()),
            subtitle: Center(
              child: Text(
                LocaleServices.getBookPraiseDescription3SubTitle(),
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          const Divider(height: 0),
          ListTile(
            title: Text(LocaleServices.getBookPraiseDescription4Title()),
            subtitle: Center(
              child: Text(
                LocaleServices.getBookPraiseDescription4SubTitle(),
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          const Divider(height: 0),
          ListTile(
            // tileColor: Colors.yellow[50],
            title: Text(LocaleServices.getBookPraiseDescription5Title()),
            subtitle: Center(
              child: Text(
                LocaleServices.getBookPraiseDescription5SubTitle(),
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          const Divider(height: 0),
          ListTile(
            title: Text(LocaleServices.getBookPraiseDescription6Title()),
            subtitle: Center(
              child: Text(
                LocaleServices.getBookPraiseDescription6SubTitle(),
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class AppDeveloperSection extends StatefulWidget {
  const AppDeveloperSection({super.key});

  @override
  State<AppDeveloperSection> createState() => _AppDeveloperSectionState();
}

class _AppDeveloperSectionState extends State<AppDeveloperSection> {
  String xlcdAppAuthor = LocaleServices.getAppAuthor();

  final String bibleGatewayLink =
      'https://www.biblegateway.com/passage/?search=%E5%B8%96%E6%92%92%E7%BE%85%E5%B0%BC%E8%BF%A6%E5%89%8D%E6%9B%B8+5%3A16-18&version=CUVMPT';

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'AppDevelopeSection',
      'xlcdapp_screen_class': 'AboutScreenClass',
    });

    return Card(
      // color: Colors.yellow[50],
      elevation: 8.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Text(
            xlcdAppAuthor,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(LocaleServices.getAppDeveloperDescription()),
          Center(
            child: ElevatedButton(
              //onPressed: visitBibleWebsite,
              onPressed: () => lauchTargetUrl(bibleGatewayLink),
              child: Text(LocaleServices.getOnlineBibleButtonLabel()),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
