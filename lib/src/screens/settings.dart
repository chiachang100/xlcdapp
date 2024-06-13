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

import 'package:easy_localization/easy_localization.dart';
import 'package:xlcdapp/l10n/codegen_loader.g.dart';
import 'package:xlcdapp/l10n/locale_keys.g.dart';

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
        title: Text(LocaleKeys.settings.tr()),
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
  String xlcdLanguageSelection = LocaleKeys.settingsLangSetting.tr();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'LanguageSection',
      'xlcdapp_screen_class': 'SettingsScreenClass',
    });

    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              "assets/logos/xlcd_splash_logo.png",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  LocaleKeys.settingsLangSetting.tr(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  LocaleKeys.settingsLangSettingsSubtitle.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          OverflowBar(
            spacing: 10,
            overflowSpacing: 20,
            alignment: MainAxisAlignment.center,
            overflowAlignment: OverflowBarAlignment.center,
            children: <Widget>[
              OutlinedButton(
                onPressed: () {
                  joysCurrentLocale = LOCALE_ZH_TW;
                  joystoreName = JOYSTORE_NAME_ZH_TW;
                  XlcdAppDataServices.saveDataStoreKeyValueDataOnDisk(
                    key: 'joysCurrentLocale',
                    value: LOCALE_ZH_TW,
                  );
                  XlcdAppDataServices.saveDataStoreKeyValueDataOnDisk(
                    key: 'joystoreName',
                    value: JOYSTORE_NAME_ZH_TW,
                  );
                  context.setLocale(const Locale('zh', 'TW'));
                  joystoreInstance =
                      buildJoyStoreFromFirestoreOrLocal(prod: true);
                  FirebaseAnalytics.instance
                      .logEvent(name: 'screen_view', parameters: {
                    'xlcdapp_screen': 'LanguageSection',
                    'xlcdapp_screen_class': 'SetLocaleToZhTW',
                  });
                  xlcdlogSettings.info(
                      '[Settings] Notify listeners: Locale=${context.locale.toString()};'
                      ' joysCurrentLocale=$joysCurrentLocale; joystoreName=$joystoreName.');
                },
                child: Text(LocaleKeys.localeZhTw.tr()),
              ),
              OutlinedButton(
                onPressed: () {
                  joysCurrentLocale = LOCALE_ZH_CN;
                  joystoreName = JOYSTORE_NAME_ZH_CN;
                  XlcdAppDataServices.saveDataStoreKeyValueDataOnDisk(
                    key: 'joysCurrentLocale',
                    value: LOCALE_ZH_CN,
                  );
                  XlcdAppDataServices.saveDataStoreKeyValueDataOnDisk(
                    key: 'joystoreName',
                    value: JOYSTORE_NAME_ZH_CN,
                  );
                  context.setLocale(const Locale('zh', 'CN'));
                  joystoreInstance =
                      buildJoyStoreFromFirestoreOrLocal(prod: true);
                  FirebaseAnalytics.instance
                      .logEvent(name: 'screen_view', parameters: {
                    'xlcdapp_screen': 'LanguageSection',
                    'xlcdapp_screen_class': 'SetLocaleToZhCN',
                  });
                  xlcdlogSettings.info(
                      '[Settings] Notify listeners: Locale=${context.locale.toString()};'
                      ' joysCurrentLocale=$joysCurrentLocale; joystoreName=$joystoreName.');
                },
                child: Text(LocaleKeys.localeZhCn.tr()),
              ),
              OutlinedButton(
                onPressed: () {
                  joysCurrentLocale = LOCALE_EN_US;
                  joystoreName = JOYSTORE_NAME_EN_US;
                  XlcdAppDataServices.saveDataStoreKeyValueDataOnDisk(
                    key: 'joysCurrentLocale',
                    value: LOCALE_EN_US,
                  );
                  XlcdAppDataServices.saveDataStoreKeyValueDataOnDisk(
                    key: 'joystoreName',
                    value: JOYSTORE_NAME_EN_US,
                  );
                  context.setLocale(const Locale('en', 'US'));
                  joystoreInstance =
                      buildJoyStoreFromFirestoreOrLocal(prod: true);
                  FirebaseAnalytics.instance
                      .logEvent(name: 'screen_view', parameters: {
                    'xlcdapp_screen': 'LanguageSection',
                    'xlcdapp_screen_class': 'SetLocaleToEnUs',
                  });
                  xlcdlogSettings.info(
                      '[Settings] Notify listeners: Locale=${context.locale.toString()};'
                      ' joysCurrentLocale=$joysCurrentLocale; joystoreName=$joystoreName.');
                },
                child: Text(LocaleKeys.localeEnUs.tr()),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
