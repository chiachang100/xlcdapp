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

final xlcdlogSettings = Logger('settings');

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
        title: Text(LocaleServices.getSettingsScreenTitle()),
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

class SettingsContent extends StatefulWidget {
  const SettingsContent({super.key, required this.firestore});
  final FirebaseFirestore firestore;

  @override
  State<SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'SettingsContent',
      'xlcdapp_screen_class': 'SettingsScreenClass',
    });

    return ListView(
      children: const <Widget>[
        LanguageSection(),
        // CopyrightSection(),
        SizedBox(height: 10),
      ],
    );
  }
}

class LanguageSection extends StatefulWidget {
  const LanguageSection({super.key});

  @override
  State<LanguageSection> createState() => _LanguageSectionState();
}

class _LanguageSectionState extends State<LanguageSection> {
  String xlcdLanguageSelection = LocaleServices.getLanguageSelection();

  final String xlcdappWebsiteLink = 'https://xlcdapp.web.app';

  LanguageType? _language = LocaleServices.getCurrentLanguage();
  List<bool> isSelected =
      LocaleServices.isTraditionalLanguage() ? [true, false] : [false, true];

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            xlcdLanguageSelection,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            direction: Axis.horizontal,
            children: <Widget>[
              Text(LocaleServices.getLanguageSelectionHeader()),
              ToggleButtons(
                isSelected: isSelected,
                color: Colors.blue,
                selectedColor: Colors.amberAccent,
                fillColor: Colors.purple,
                highlightColor: Colors.purpleAccent,
                splashColor: Colors.lightBlue,
                borderColor: Colors.white,
                borderWidth: 2,
                selectedBorderColor: Colors.greenAccent,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
                renderBorder: true,
                borderRadius: BorderRadius.circular(10),
                onPressed: (int index) {
                  setState(() {
                    for (int buttonIndex = 0;
                        buttonIndex < isSelected.length;
                        buttonIndex++) {
                      if (buttonIndex == index) {
                        isSelected[buttonIndex] = true;
                      } else {
                        isSelected[buttonIndex] = false;
                      }
                    }
                    if (index == LanguageType.traditional.index) {
                      joysCurrentLocale = LOCALE_ZH_TW;
                      joystoreName = JOYSTORE_NAME_ZH_TW;
                    } else {
                      joysCurrentLocale = LOCALE_ZH_CN;
                      joystoreName = JOYSTORE_NAME_ZH_CN;
                    }

                    XlcdAppDataServices.saveDataStoreKeyValueDataOnDisk(
                        key: 'joysCurrentLocale', value: joysCurrentLocale);
                    XlcdAppDataServices.saveDataStoreKeyValueDataOnDisk(
                        key: 'joystoreName', value: joystoreName);
                  });
                },
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(LocaleServices.getTraditionalLanguage()),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(LocaleServices.getSimplifiedLanguage()),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
