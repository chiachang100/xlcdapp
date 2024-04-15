import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../data.dart';
import '../widgets/joy_list.dart';

class ScriptureDetailsScreen extends StatelessWidget {
  final Scripture scripture;
  final ValueChanged<Joy> onJoyTapped;

  const ScriptureDetailsScreen({
    super.key,
    required this.scripture,
    required this.onJoyTapped,
  });

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'ScriptureDetailsScreen',
      'xlcdapp_screen_class': 'ScriptureDetailsScreenClass',
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(scripture.name),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: JoyList(
                joys: scripture.joys,
                // onTap: (joy) {
                //   onJoyTapped(joy);
                // },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
