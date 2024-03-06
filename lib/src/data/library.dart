// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'scripture.dart';
import 'joy.dart';

final libraryInstance = Library()
  ..addJoy(
    title: '愛的激勵',
    scriptureName: '哥林多後書 5:14',
    scriptureVerse: '原來基督的愛激勵我們，因我們想：一人既替眾人死，眾人就都死了；',
    prelude: '我們都需要推動力來激勵我們作好人或行善事。...',
    laugh: '老張在他生日時, ...',
    photoUrl: 'assets/photos/xlcdapp_photo_1.JPG',
    talk: '要珍惜別人善意的勸勉,...',
    votes: 10,
    type: 1,
    isLike: true,
    isNew: true,
  )
  ..addJoy(
    title: '勝過恐懼',
    scriptureName: '詩篇 23:4',
    scriptureVerse: '我雖然行過死蔭的幽谷，也不怕遭害，因為你與我同在，你的杖、你的竿都安慰我。',
    prelude: '恐懼對我們並不陌生。...',
    laugh: '時事雜誌的主持人芭芭拉.華特斯(Barbara Walters), ...',
    photoUrl: 'assets/photos/xlcdapp_photo_2.JPG',
    talk: '是的,恐懼會促使你做各樣的措施來保護自己。...',
    votes: 9,
    type: 1,
    isLike: false,
    isNew: true,
  )
  ..addJoy(
    title: '彼此饒恕',
    scriptureName: '歌羅西書 3:13',
    scriptureVerse: '倘若這人與那人有嫌隙，總要彼此包容，彼此饒恕；主怎樣饒恕了你們，你們也要怎樣饒恕人。',
    prelude: '饒恕別人的過犯是一種美德,...',
    laugh: '小美一直以來都不喜歡...',
    photoUrl: 'assets/photos/xlcdapp_photo_3.JPG',
    talk: '饒恕乃是一個決定,...',
    votes: 8,
    type: 1,
    isLike: true,
    isNew: false,
  )
  ..addJoy(
    title: '先去掉眼中樑木',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '每一個人都有優點,也有缺點。...',
    laugh: '老王擔心他太太的聽覺有問題,可能需要帶耳機,他不知如何開口,就問他的醫生。...',
    photoUrl: 'assets/photos/xlcdapp_photo_4.JPG',
    talk: '當我們承認自己不是十分完美時,我們就會以不同的眼光去看待周圍的人。...',
    votes: 6,
    type: 1,
    isLike: true,
    isNew: false,
  )
  ..addJoy(
    title: '分享的喜樂',
    scriptureName: '路加福音 3:11',
    scriptureVerse: '約翰回答說：「有兩件衣裳的，就分給那沒有的，有食物的也當這樣行。」',
    prelude: '分享的喜樂是雙倍的喜樂。...',
    laugh: '有一天,有一位老先生買了一個漢堡,薯條和一杯飲料。...',
    photoUrl: 'assets/photos/xlcdapp_photo_5.JPG',
    talk: '若是人人都有一顆與他人分享好東西的心,這世界肯定會更加溫暖。...',
    votes: 1,
    type: 1,
    isLike: false,
    isNew: true,
  );

class Library {
  final List<Joy> allJoys = [];
  final List<Scripture> allScriptures = [];

  void addJoy({
    required String title,
    required String scriptureName,
    required String scriptureVerse,
    required String prelude,
    required String laugh,
    required String photoUrl,
    required String talk,
    required int votes,
    required int type,
    required bool isLike,
    required bool isNew,
  }) {
    var scripture = allScriptures.firstWhere(
      (scripture) => scripture.name == scriptureName,
      orElse: () {
        final value =
            Scripture(allScriptures.length, scriptureName, scriptureVerse);
        allScriptures.add(value);
        return value;
      },
    );
    var joy = Joy(
      allJoys.length,
      title,
      prelude,
      laugh,
      photoUrl,
      talk,
      votes,
      type,
      isLike,
      isNew,
      scripture,
    );

    scripture.joys.add(joy);
    allJoys.add(joy);
  }

  Joy getJoy(String id) {
    return allJoys[int.parse(id)];
  }

  List<Joy> get likeJoys => [
        ...allJoys.where((joy) => joy.isLike),
      ];

  List<Joy> get newJoys => [
        ...allJoys.where((joy) => joy.isNew),
      ];
}
