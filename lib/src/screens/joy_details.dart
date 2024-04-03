// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

//import 'dart:developer' as developer;
import 'package:logging/logging.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/link.dart';
//import 'package:web/helpers.dart';
import 'package:flutter/services.dart';
import 'package:xlcdapp/src/screens/scaffold.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as ypf;
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart' as ypi;

import '../data.dart';
import 'scripture_details.dart';

final xlcdlog = Logger('joy_details');

class JoyDetailsScreen extends StatefulWidget {
  final Joy? joy;

  JoyDetailsScreen({
    super.key,
    this.joy,
  });

  @override
  State<JoyDetailsScreen> createState() => _JoyDetailsScreenState();
}

class _JoyDetailsScreenState extends State<JoyDetailsScreen> {
  final String iconUrl = 'assets/icons/xlcdapp-leading-icon.png';
  bool favorite = false;

  final joysRef =
      FirebaseFirestore.instance.collection('joys').withConverter<Joy>(
            fromFirestore: (snapshots, _) => Joy.fromJson(snapshots.data()!),
            toFirestore: (joy, _) => joy.toJson(),
          );

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'JoyDetailsScreen',
      'xlcdapp_screen_class': 'JoyDetailsScreenClass',
    });

    if (widget.joy == null) {
      return const Scaffold(
        body: Center(
          child: Text('No joy found.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.joy!.articleId}. ${widget.joy!.title}'),
        actions: <Widget>[
          ActionChip(
            avatar: const Icon(Icons.thumb_up_outlined),
            label: Text('${widget.joy!.likes}'),
            onPressed: () {
              setState(() {
                if (!favorite) {
                  favorite = true;
                  widget.joy!.likes++;
                  final joyRef = joysRef.doc(widget.joy!.articleId.toString());
                  FirebaseFirestore.instance
                      .runTransaction((transaction) async {
                    final snapshot = await transaction.get(joyRef);
                    // final newLikes = snapshot.get("likes") + 1;
                    widget.joy!.likes = snapshot.get("likes") + 1;
                    transaction.update(joyRef, {'likes': widget.joy!.likes});
                  });
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImageSection(image: widget.joy!.photoUrl),
            TitleSection(
              name: widget.joy!.scripture.name,
              verse: widget.joy!.scripture.verse,
              likes: widget.joy!.likes,
            ),
            const DividerSection(Icon(Icons.star_border_rounded)),
            TextSection(description: widget.joy!.prelude),
            const DividerSection(Icon(Icons.face_outlined)),
            TextSection(description: widget.joy!.laugh),
            LeadingIconTextSection(
                description: widget.joy!.talk, iconUrl: iconUrl),
            const DividerSection(Icon(Icons.live_tv_outlined)),
            //YoutubePlayerIFrameSection(videoId: 'Mez7DnMOlgc', videoName: '不要怕！你要得人了 | 曾興才牧師 | 20240225 | 生命河 ROLCCmedia'),
            (useYoutubePlayerFlutterVersion && !kIsWeb)
                ? YoutubePlayerFlutterSection(
                    videoId: widget.joy!.videoId,
                    videoName: widget.joy!.videoName)
                : YoutubePlayerIFrameSection(
                    videoId: widget.joy!.videoId,
                    videoName: widget.joy!.videoName),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class DividerSection extends StatelessWidget {
  const DividerSection(this.icon);
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 20,
        child: icon,
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Image.asset(
          image,
          height: MediaQuery.of(context).size.width * (3 / 4),
          width: MediaQuery.of(context).size.width,
          //height: 320, width: 640,
          fit: BoxFit.scaleDown,
        ),
      ],
    );
  }
}

class TitleSection extends StatefulWidget {
  TitleSection({
    super.key,
    required this.name,
    required this.verse,
    required this.likes,
  });
  final String name;
  final String verse;
  int likes;

  @override
  State<TitleSection> createState() => _TitleSectionState();
}

class _TitleSectionState extends State<TitleSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 1),
            child: Text(
              // '「$verse」($name)',
              '${widget.verse}(${widget.name})',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextSection extends StatelessWidget {
  const TextSection({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding: const EdgeInsets.all(32),
      padding: const EdgeInsets.all(12),
      child: Text(
        description,
        softWrap: true,
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }
}

class LeadingIconTextSection extends StatelessWidget {
  const LeadingIconTextSection({
    super.key,
    required this.description,
    required this.iconUrl,
  });

  final String description;
  final String iconUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: <Widget>[
          Image.asset(iconUrl),
          Text(
            description,
            softWrap: true,
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}

/*
* YoutubePlayerIFrameSection uses [youtube_player_iframe](https://pub.dev/packages/youtube_player_iframe).
*/
class YoutubePlayerIFrameSection extends StatefulWidget {
  YoutubePlayerIFrameSection({required this.videoId, required this.videoName});
  final String videoId;
  final String videoName;

  @override
  State<YoutubePlayerIFrameSection> createState() =>
      _YoutubePlayerIFrameSectionState();
}

class _YoutubePlayerIFrameSectionState
    extends State<YoutubePlayerIFrameSection> {
  late ypi.YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ypi.YoutubePlayerController(
      params: const ypi.YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: true,
        loop: false,
      ),
    );

    _controller.setFullScreenListener(
      (isFullScreen) {
        // developer.log('${isFullScreen ? 'Entered' : 'Exited'} Fullscreen.');
        xlcdlog.fine('${isFullScreen ? 'Entered' : 'Exited'} Fullscreen.');
      },
    );

    //_controller.loadVideoById(videoId: widget.videoId); // Auto Play
    _controller.cueVideoById(videoId: widget.videoId); // Manual Play
  }

  @override
  void dispose() {
    try {
      _controller.close();
      super.dispose();
    } catch (e) {
      //xlcdlog.info('Caught exception: $e');
      xlcdlog.info('Caught exception...');
    } finally {
      //super.dispose();
    }
  }

  // final _controller = YoutubePlayerController(
  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'YoutubePlayerIFrameSection',
      'xlcdapp_screen_class': 'JoyDetailsScreenClass',
    });

    xlcdlog.info('Using YoutubePlayerIFrame.');

    return ypi.YoutubePlayerScaffold(
      controller: _controller,
      aspectRatio: 16 / 9,
      builder: (context, player) => Padding(
        padding:
            const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20, right: 20),
        child: Column(
          children: <Widget>[
            Text(
              '(${widget.videoName})',
              softWrap: true,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            player,
          ],
        ),
      ),
    );
  }
}

//
// YoutubePlayerFlutterSection uses [youtube_player_flutter](https://pub.dev/packages/youtube_player_flutter).
// Only works for Android and iOS. Web was failed. See README.md file for detailed information.
//
class YoutubePlayerFlutterSection extends StatefulWidget {
  const YoutubePlayerFlutterSection(
      {super.key, required this.videoId, required this.videoName});
  final String videoId;
  final String videoName;

  @override
  State<YoutubePlayerFlutterSection> createState() =>
      _YoutubePlayerFlutterSectionState();
}

class _YoutubePlayerFlutterSectionState
    extends State<YoutubePlayerFlutterSection> {
  late ypf.YoutubePlayerController _controller;
  bool isFullScreen = false;

//videoId = ypf.YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=BBAyRBTfsOU");

  @override
  void initState() {
    super.initState();
    _controller = ypf.YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const ypf.YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        //isLive: true,
      ),
    )..addListener(() {
        if (_controller.value.isFullScreen != isFullScreen) {
          setState(() {
            isFullScreen = _controller.value.isFullScreen;
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(name: 'screen_view', parameters: {
      'xlcdapp_screen': 'YoutubePlayerFlutterSection',
      'xlcdapp_screen_class': 'JoyDetailsScreenClass',
    });

    xlcdlog.info('Using YoutubePlayerFlutter.');

    return ypf.YoutubePlayerBuilder(
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        setState(() {
          isFullScreen = false;
        });
      },
      player: ypf.YoutubePlayer(
        controller: _controller,
        liveUIColor: Colors.amber,
        showVideoProgressIndicator: true,
        aspectRatio: 16 / 9,
      ),
      builder: (context, player) => Padding(
        padding:
            const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20, right: 20),
        child: Column(
          children: <Widget>[
            Text(
              '(${widget.videoName})',
              softWrap: true,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            player,
          ],
        ),
      ),
    );
  }
}
