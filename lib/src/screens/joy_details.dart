// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/link.dart';
//import 'package:web/helpers.dart';
import 'package:flutter/services.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../data.dart';
import 'scripture_details.dart';

class JoyDetailsScreen extends StatelessWidget {
  final Joy? joy;

  const JoyDetailsScreen({
    super.key,
    this.joy,
  });

  final String iconUrl = 'assets/icons/xlcdapp-leading-icon.png';

  @override
  Widget build(BuildContext context) {
    if (joy == null) {
      return const Scaffold(
        body: Center(
          child: Text('No joy found.'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(joy!.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImageSection(image: joy!.photoUrl),
            TitleSection(
              name: joy!.scripture.name,
              verse: joy!.scripture.verse,
              likes: joy!.likes,
            ),
            const DividerSection(Icon(Icons.star_border_rounded)),
            TextSection(description: joy!.prelude),
            const DividerSection(Icon(Icons.star_border_rounded)),
            TextSection(description: joy!.laugh),
            LeadingIconTextSection(description: joy!.talk, iconUrl: iconUrl),
            const DividerSection(Icon(Icons.star_border_rounded)),
            //YoutubePlayerIFrameSection(videoId: 'Mez7DnMOlgc', videoName: '不要怕！你要得人了 | 曾興才牧師 | 20240225 | 生命河 ROLCCmedia'),
            YoutubePlayerIFrameSection(
                videoId: joy!.videoId, videoName: joy!.videoName),
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
          height: 320,
          width: 640,
          fit: BoxFit.fill,
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
  bool _favorite = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
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
          ),
          ActionChip(
            avatar: const Icon(Icons.thumb_up_outlined),
            label: Text('${widget.likes}'),
            onPressed: () {
              setState(() {
                if (!_favorite) {
                  _favorite = true;
                  widget.likes++;
                }
              });
            },
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
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: true,
        loop: false,
      ),
    );

    _controller.setFullScreenListener(
      (isFullScreen) {
        log('${isFullScreen ? 'Entered' : 'Exited'} Fullscreen.');
      },
    );

    //_controller.loadVideoById(videoId: widget.videoId); // Auto Play
    _controller.cueVideoById(videoId: widget.videoId); // Manual Play
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  // final _controller = YoutubePlayerController(
  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
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

/* 
//
// YoutubePlayerSection uses [youtube_player_flutter](https://pub.dev/packages/youtube_player_flutter). 
// Only works for Android and iOS. Web was failed. See README.md file for detailed information.
//
class YoutubePlayerSection extends StatefulWidget {
  const YoutubePlayerSection({super.key, required this.videoId});
  final String videoId;

  @override
  State<YoutubePlayerSection> createState() => _YoutubePlayerSectionState();
}

class _YoutubePlayerSectionState extends State<YoutubePlayerSection> {
  late YoutubePlayerController _controller;
  bool isFullScreen = false;

//videoId = YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=BBAyRBTfsOU");

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
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
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        setState(() {
          isFullScreen = false;
        });
      },
      player: YoutubePlayer(
        controller: _controller,
        liveUIColor: Colors.amber,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            player,
          ],
        ),
      ),
    );
  }
}
 */
