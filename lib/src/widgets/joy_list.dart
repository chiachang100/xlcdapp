import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:xlcdapp/src/services/locale_services.dart';
import '../data.dart';

class JoyList extends StatelessWidget {
  final List<Joy> joys;
  final bool isRanked;
  final ValueChanged<Joy>? onTap;

  JoyList({
    required this.joys,
    this.isRanked = false,
    this.onTap,
    super.key,
  });

  List<String> dynamicText = LocaleServices.getButtonText();
  String getNextText() => dynamicText[Random().nextInt(dynamicText.length)];

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'JoyListScreen',
      'xlcdapp_screen_class': 'JoyListClass',
    });

    return ListView.builder(
      itemCount: joys.length,
      itemBuilder: (context, index) {
        return ListTile(
          // isThreeLine: true,
          title: Text(
            '${(index + 1)}. ${joys[index].title} (${joys[index].articleId})',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            children: [
              Text(
                '✞ (${joys[index].scripture.name})${joys[index].scripture.verse}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
              Text(
                '🌞${joys[index].laugh}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ],
          ),
          leading: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 44,
              minHeight: 44,
              maxWidth: 64,
              maxHeight: 64,
            ),
            child: Image.asset(joys[index].photoUrl),
          ),
          //trailing: const Icon(Icons.arrow_forward_ios),
          onTap: onTap != null ? () => onTap!(joys[index]) : null,
          // onTap: onTap != null ? () => {} : null,
        );
      },
    );
  }
}
