import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import '../services/locale_services.dart';

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

    String xlcdAppTitle = LocaleServices.getXlcdAppTitle();
    String xlcdAppScriptLabel = LocaleServices.getXlcdAppScriptLabel();
    String xlcdAppSettingsLabel = LocaleServices.getXlcdAppSettingsLabel();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: AdaptiveScaffold(
            //transitionDuration: Durations.short1,
            transitionDuration: Duration.zero,
            selectedIndex: selectedIndex,
            body: (_) => child,
            onSelectedIndexChange: (idx) {
              if (idx == 0) goRouter.go('/joys/all');
              if (idx == 1) goRouter.go('/scriptures');
              if (idx == 2) goRouter.go('/settings');
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
                label: xlcdAppSettingsLabel,
                icon: const Icon(Icons.group_outlined),
                selectedIcon: const Icon(Icons.group),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
