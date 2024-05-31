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
            isThreeLine: true,
            title: Text(
              '${(index + 1)}. ${joys[index].title} (${joys[index].articleId})',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '✞ (${joys[index].scripture.name})${joys[index].scripture.verse.substring(0, 12)}...' +
                  '\n🌞${joys[index].laugh.substring(0, 22)}...',
            ),
            leading: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 44,
                minHeight: 44,
                maxWidth: 64,
                maxHeight: 64,
              ),
              child: Image.asset('${joys[index].photoUrl}'),
            ),
            //trailing: const Icon(Icons.arrow_forward_ios),
            onTap: onTap != null ? () => onTap!(joys[index]) : null,
            // onTap: onTap != null ? () => {} : null,
          );
        });

/* 
    return ListView.builder(
      itemCount: joys.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.yellow[50],
          elevation: 8.0,
          margin: const EdgeInsets.all(8.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  joys[index].photoUrl,
                  height: MediaQuery.of(context).size.width * (2 / 4),
                  width: MediaQuery.of(context).size.width * (2 / 4),
                  fit: BoxFit.scaleDown,
                ),
              ),
              Row(
                children: [
                  Text(
                    isRanked ? '🏆#${(index + 1)}:' : '',
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 5),
                  CircleAvatar(
                    backgroundColor: circleAvatarBgColor[
                        (joys[index].id % circleAvatarBgColor.length)],
                    child: Text(
                      joys[index].articleId.toString(),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      joys[index].title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Chip(
                    avatar: const Icon(Icons.thumb_up_outlined),
                    label: Text('${joys[index].likes}'),
                    side: BorderSide.none,
                  ),
                ],
              ),
              Text(
                '✞${joys[index].scripture.verse}(${joys[index].scripture.name})',
              ),
              Text(
                '🌞${joys[index].laugh.substring(0, 20)}...',
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
              ElevatedButton(
                onPressed: (onTap != null ? () => onTap!(joys[index]) : null),
                child: Text(
                  // '觀賞詳情',
                  getNextText(),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
 */
  }
}
