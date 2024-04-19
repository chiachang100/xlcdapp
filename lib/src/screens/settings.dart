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
import '../models/locale_info_model.dart';

final xlcdlogSettings = Logger('settings');

// List<String> langList = <String>['繁體中文', '簡體中文'];
List<String> langList = <String>[
  LocaleServices.getTraditionalLanguageText(),
  LocaleServices.getSimplifiedLanguageText(),
];

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

  String dropdownValue = LocaleServices.getLanguageTextByLanguageType(
      LocaleServices.getCurrentLanguageType());
  final TextEditingController langController = TextEditingController();

  @override
  void dispose() {
    langController.dispose();
    super.dispose();
  }

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10),
            Wrap(
              direction: Axis.horizontal,
              children: <Widget>[
                DropdownMenu<String>(
                  initialSelection:
                      LocaleServices.getLanguageTextByLanguageType(
                          LocaleServices.getCurrentLanguageType()),
                  controller: langController,
                  requestFocusOnTap: true,
                  label: Text(
                    LocaleServices.getLanguageSelectionHeader(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onSelected: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;

                      if (dropdownValue ==
                          LocaleServices.getSimplifiedLanguageText()) {
                        joysCurrentLocale = LOCALE_ZH_CN;
                        joystoreName = JOYSTORE_NAME_ZH_CN;
                      } else {
                        joysCurrentLocale = LOCALE_ZH_TW;
                        joystoreName = JOYSTORE_NAME_ZH_TW;
                      }

                      XlcdAppDataServices.saveDataStoreKeyValueDataOnDisk(
                          key: 'joysCurrentLocale', value: joysCurrentLocale);
                      XlcdAppDataServices.saveDataStoreKeyValueDataOnDisk(
                          key: 'joystoreName', value: joystoreName);

                      langList[0] = LocaleServices.getTraditionalLanguageText();
                      langList[1] = LocaleServices.getSimplifiedLanguageText();

                      var newRecords = <String, String>{
                        'locale': joysCurrentLocale,
                        'store': joystoreName,
                      };

                      // Change the locale and store name and notify all listeners.
                      var localeInfo = LocaleInfoModel();
                      localeInfo.setAppLocaleInfo(newRecords);
                      xlcdlogSettings.info(
                          'LanguageSection: Notify listeners: joysCurrentLocale=$joysCurrentLocale; joystoreName=$joystoreName.');
                    });
                  },
                  dropdownMenuEntries:
                      langList.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
