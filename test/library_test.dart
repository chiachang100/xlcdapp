// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:xlcdapp/src/data/library.dart';
import 'package:test/test.dart';

// category
// id       category
// ------   --------
// 1-13     '春'
// 14-26    '夏'
// 27-39    '秋'
// 40-52    '冬'

void main() {
  group('Library', () {
    test('addJoy', () {
      final library = Library();
      library.addJoy(
        id: 1,
        title: '愛的激勵',
        scriptureName: '哥林多後書 5:14',
        scriptureVerse: '原來基督的愛激勵我們，因我們想：一人既替眾人死，眾人就都死了；',
        prelude: '  我們都需要推動力來激勵我們作好人或行善事。...',
        laugh: '  老張在他生日時, ...',
        photoUrl: 'assets/photos/xlcdapp_photo_1.png',
        videoId: 'Mez7DnMOlgc',
        videoName: '不要怕！你要得人了 | 曾興才牧師 | 20240225 | 生命河 ROLCCmedia',
        talk: '  要珍惜別人善意的勸勉,...',
        likes: 10,
        type: 1,
        isNew: false,
        category: '春',
      );
      library.addJoy(
        id: 2,
        title: '勝過恐懼',
        scriptureName: '詩篇 23:4',
        scriptureVerse: '我雖然行過死蔭的幽谷，也不怕遭害，因為你與我同在，你的杖、你的竿都安慰我。',
        prelude: '  恐懼對我們並不陌生。...',
        laugh: '  時事雜誌的主持人芭芭拉.華特斯(Barbara Walters), ...',
        photoUrl: 'assets/photos/xlcdapp_photo_2.png',
        videoId: 'GkRrP2iBaKw',
        videoName: '不斷成長，進入豐盛 | 曾興才牧師 | 20240121 | 生命河 ROLCCmedia',
        talk: '  是的,恐懼會促使你做各樣的措施來保護自己。...',
        likes: 9,
        type: 1,
        isNew: false,
        category: '春',
      );
      library.addJoy(
        id: 3,
        title: '彼此饒恕',
        scriptureName: '歌羅西書 3:13',
        scriptureVerse: '倘若這人與那人有嫌隙，總要彼此包容，彼此饒恕；主怎樣饒恕了你們，你們也要怎樣饒恕人。',
        prelude: '  饒恕別人的過犯是一種美德,...',
        laugh: '  小美一直以來都不喜歡...',
        photoUrl: 'assets/photos/xlcdapp_photo_3.png',
        videoId: 'Ay5KpU3QS44',
        videoName: '聖靈，再一次充滿我們 | #曾興才牧師 | 20230611 | 生命河 ROLCCmedia',
        talk: '  饒恕乃是一個決定,...',
        likes: 8,
        type: 1,
        isNew: false,
        category: '春',
      );
      expect(library.allScriptures.length, 3);
      expect(library.allScriptures.first.joys.length, 1);
      expect(library.allJoys.length, 3);
      expect(library.allJoys.first.scripture.name, startsWith('哥林多'));
    });
  });
}
