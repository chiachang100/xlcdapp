import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:go_router/go_router.dart';
import '../data.dart';
import '../widgets/scripture_list.dart';
import '../services/locale_services.dart';

class ScripturesScreen extends StatefulWidget {
  final String title;
  final ValueChanged<Scripture> onTap;

  ScripturesScreen({
    required this.onTap,
    // this.title = '聖經經文',
    required this.title,
    super.key,
  });

  @override
  State<ScripturesScreen> createState() => _ScripturesScreenState();
}

class _ScripturesScreenState extends State<ScripturesScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': '聖經經文Screen',
      'xlcdapp_screen_class': 'ScripturesScreenClass',
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                  joystoreInstance.allScriptures,
                  widget.onTap,
                ),
              );
            },
          ),
        ],
      ),
      body: ScriptureList(
        scriptures: joystoreInstance.allScriptures,
        onTap: widget.onTap,
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  // final List<String> items;
  final List<Scripture> allScriptures;
  final ValueChanged<Scripture>? onTap;

  CustomSearchDelegate(this.allScriptures, this.onTap);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = allScriptures
        .where((item) =>
            item.name.toLowerCase().contains(query.toLowerCase()) ||
            item.verse.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ScriptureList(
      scriptures: results,
      onTap: onTap,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = allScriptures
        .where((item) =>
            item.name.toLowerCase().contains(query.toLowerCase()) ||
            item.verse.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ScriptureList(
      scriptures: suggestions,
      onTap: onTap,
    );
  }
}
