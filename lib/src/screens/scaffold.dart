import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import '../services/locale_services.dart';
import 'package:logging/logging.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:xlcdapp/l10n/codegen_loader.g.dart';
import 'package:xlcdapp/l10n/locale_keys.g.dart';

final xlcdlogJoystoreScaffold = Logger('JoystoreScaffold');

class JoystoreScaffold extends StatelessWidget {
  final Widget child;
  final int selectedIndex;

  const JoystoreScaffold({
    required this.child,
    required this.selectedIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);

    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'AdaptiveScaffoldScreen',
      'xlcdapp_screen_class': 'JoystoreScaffoldClass',
    });

    String xlcdAppTitle = LocaleKeys.xlcd.tr();
    String xlcdAppScriptLabel = LocaleKeys.bibleVerse.tr();
    String xlcdAppSettingsLabel = LocaleKeys.settings.tr();
    String xlcdAppAboutLabel = LocaleKeys.about.tr();

    // const maxWidth = 600.0;
    final maxWidth = (MediaQuery.of(context).size.width) * 1.0;
    xlcdlogJoystoreScaffold
        .info('[JoystoreScaffold] Scaffold max width: $maxWidth');

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Center(
            child: SizedBox(
              width: maxWidth,
              child: AdaptiveScaffold(
                //transitionDuration: Durations.short1,
                transitionDuration: Duration.zero,
                selectedIndex: selectedIndex,
                body: (_) => child,
                onSelectedIndexChange: (idx) {
                  if (idx == 0) goRouter.go('/joys/all');
                  if (idx == 1) goRouter.go('/scriptures');
                  if (idx == 2) goRouter.go('/settings');
                  if (idx == 3) goRouter.go('/about');
                },
                destinations: <NavigationDestination>[
                  NavigationDestination(
                    // label: '笑裡藏道',
                    label: xlcdAppTitle,
                    icon: const Icon(Icons.home_outlined),
                    selectedIcon: const Icon(Icons.home),
                  ),
                  NavigationDestination(
                    // label: '聖經經文',
                    label: xlcdAppScriptLabel,
                    icon: const Icon(Icons.list_outlined),
                    selectedIcon: Icon(Icons.list),
                  ),
                  NavigationDestination(
                    // label: '資源簡介',
                    label: xlcdAppAboutLabel,
                    icon: const Icon(Icons.group_outlined),
                    selectedIcon: const Icon(Icons.group),
                  ),
                  NavigationDestination(
                    // label: '我的設定',
                    label: xlcdAppSettingsLabel,
                    icon: const Icon(Icons.settings_outlined),
                    selectedIcon: const Icon(Icons.settings),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
