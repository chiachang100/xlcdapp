// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'scripture.dart';
import 'joy.dart';

final int topList = 10;

class Library {
  final List<Joy> allJoys = [];
  final List<Scripture> allScriptures = [];

  void addJoy({
    required int itemId,
    required String title,
    required String scriptureName,
    required String scriptureVerse,
    required String prelude,
    required String laugh,
    required String photoUrl,
    required String videoId,
    required String videoName,
    required String talk,
    required int likes,
    required int type,
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
      itemId,
      title,
      prelude,
      laugh,
      photoUrl,
      videoId,
      videoName,
      talk,
      likes,
      type,
      isNew,
      scripture,
    );

    scripture.joys.add(joy);
    allJoys.add(joy);
  }

  Joy getJoy(String id) {
    return allJoys[int.parse(id)];
  }

  List<Joy> getTopList(List<Joy> allJoys, int filter) {
    //allJoys.sort((a, b) => a.likes.compareTo(b.likes)); // ascending
    allJoys.sort((a, b) => b.likes.compareTo(a.likes)); // descending
    return allJoys.take(filter).toList();
  }

  // List<Joy> get likeJoys => [
  //       ...allJoys.where((joy) => (joy.likes > 0)),
  //     ];

  List<Joy> get likeJoys => [
        ...getTopList(allJoys, topList).where((joy) => (joy.likes > 0)),
      ];

  List<Joy> get newJoys => [
        ...allJoys.where((joy) => joy.isNew),
      ];
}

final libraryInstance = Library()
  ..addJoy(
    itemId: 1,
    title: '愛的激勵',
    scriptureName: '哥林多後書 5:14',
    scriptureVerse: '原來基督的愛激勵我們，因我們想：一人既替眾人死，眾人就都死了；',
    prelude: '  我們都需要推動力來激勵我們作好人或行善事。基本上有兩種推動力,即正面和負面的推動力。'
        '有一些人需要正面的推動力，有一些人或動物卻需要負面的推動力，他們才會被激發去做他們該做的事。',
    laugh: '  老張在他生日時，收到好朋友送給他一隻會說話的鸚鵡，但這隻鸚鵡的態度很差，滿口都是髒話，不是罵人的話，就是一些粗話。'
        '老張很努力地改變牠的態度，不斷地和牠說些有禮貌的話，放輕柔的音樂給牠聽，反正他想到能夠做的事部做了，但都沒什麼用。'
        '\n\n  於是老張對鸚鵡開始吼叫起來，牠也吼了回去，他又用力搖晃鸚鵡，結果只會讓牠更生氣，而且變得更粗魯。'
        '終於在忍無可忍的憤怒之下，他把鸚鵡送進了冷凍櫃中，聽到牠粗聲大叫，到處亂踢，還尖叫了起來，卻立刻就安靜下來，一分半鐘之內，他沒有再聽到半點聲音。'
        '\n\n  老張被嚇著了，說：「糟糕，我害死了牠！」便馬上打開冷凍櫃的門。'
        '\n\n  只見鸚鵡冷靜地走出來，踏上老張伸出來的手背，說道：「相信我粗魯的言談和行為必定冒犯了您，我會努力改進我的行為，我真的很抱歉，希望您能夠原諒我。」'
        '\n\n  老張對鸚鵡態度的轉變很是驚訝!正想要問這樣戲劇性的變化是什麼原因，牠又接著說道:「我可以問一下，裡面那隻被扒光毛的鳥做錯了什麼事嗎?」',
    photoUrl: 'assets/photos/xlcdapp_photo_1.png',
    videoId: 'Mez7DnMOlgc',
    videoName: '不要怕！你要得人了 | 曾興才牧師 | 20240225 | 生命河 ROLCCmedia',
    talk: '  要珍惜別人善意的勸勉，尤其是出於愛的勸告。出於愛的推動力是可以幫助我們，在艱難的環境中持續做正確的事情。'
        '\n\n  使徒保羅因為明白和經歷基督耶穌的愛，使他在諸多的逼迫和困難中，忠心心完成耶穌給他的託付。'
        '他說原來基督的愛就好像一股力量在背後不停地推著他，因為我們知道耶穌既然為眾人死了，眾人就都死了。'
        '祂為我們眾人死，叫我們這些還活著的人不再為自己活，乃是為替我們死而復活的主而活。'
        '\n\n  愛是最強而有力的推動力。',
    likes: 20,
    type: 1,
    isNew: false,
  )
  ..addJoy(
    itemId: 2,
    title: '勝過恐懼',
    scriptureName: '詩篇 23:4',
    scriptureVerse: '我雖然行過死蔭的幽谷，也不怕遭害，因為你與我同在，你的杖、你的竿都安慰我。',
    prelude:
        '  恐懼對我們並不陌生。生活在不斷變的世界裡，常常會遇到「突然的事情」叫我們措手不及，若不留心，很容易會落入恐懼的深淵裡。因此，為了生存，我們會想盡辦法來保護自己。',
    laugh:
        '  時事雜誌的主持人芭芭拉•華特斯（Barbara Watters），在阿富汗戰爭爆發前，到一個叫卡布（Kabul）的地方，做了一個有關兩性角色的主題故事。'
        '她發現當地的婦女都有一個習慣，走路的時候總是以慢五倍的速度跟在丈夫後面。她不明白為什麼。'
        '\n\n  最近她又回到卡布，發現那裡的女人仍然是這樣跟在丈夫背後。雖然塔利班（Taliban）政權已經被推翻，但是這些婦女們仍然樂於遵從這個傳統。'
        '主持人華特斯小姐在訪問其中一名婦女時，在好奇心的驅使下就問：「妳們為什麼樂於堅守這個曾經一度極力要推翻的傳統呢？」'
        '\n\n  那個女人目不轉睛地望著華特小姐，然後毫不猶豫地回答說：「因為有地雷！」',
    photoUrl: 'assets/photos/xlcdapp_photo_2.png',
    videoId: 'GkRrP2iBaKw',
    videoName: '不斷成長，進入豐盛 | 曾興才牧師 | 20240121 | 生命河 ROLCCmedia',
    talk: '  是的，恐懼會促使你做各樣的措施來保護自已。但有時候，沒有任何預備能夠幫助你面對它。'
        '你渴望在千變萬化的人情世故中找到永不搖動的錨，找到真正的平安。'
        '\n\n  詩人大衛提醒我們說：唯有緊緊抓住永不改變的真神上帝，哪怕是走過死蔭幽谷，你也可以不怕，因為知道上帝永遠與你同在，'
        '祂的杖可以幫助你從錯誤的道路上回轉過來，祂的竿會指引你走正路。'
        '有耶和華上帝與你同在，你可以不再恐懼，可以享受出人意外的平安。'
        '\n\n  今天，嘗試把你心中的恐懼藉著禱告，告訴上帝。',
    likes: 19,
    type: 1,
    isNew: false,
  )
  ..addJoy(
    itemId: 3,
    title: '彼此饒恕',
    scriptureName: '歌羅西書 3:13',
    scriptureVerse: '倘若這人與那人有嫌隙，總要彼此包容，彼此饒恕；主怎樣饒恕了你們，你們也要怎樣饒恕人。',
    prelude:
        '  饒恕別人的過犯是一種美德，也是上帝要我們做的一件事。但是，我們往往會因為別人的傷害，無論是有意或無意的，耿耿於懷，久久都不能放下。連一個小學生也不例外。',
    laugh: '  小美一直以來都不喜歡五年級班的國文老師，她在等待機會向老師表達她心中的不滿。'
        '有一天，國文老師在上文課時，指定一個作文題目〈三十年後的我〉。以下是美的作文：'
        '\n\n  「今天的天氣不錯，我開著老公在結婚週年送我的勞斯萊斯，手指上帶著他剛買給我的三克拉大鑽戒，'
        '脖子上也掛著上個月生日才送給我的紅寶石項鍊，帶著我的一對可愛雙胞胎到大安森林公園去玩。'
        '我們走在鳥語花香的園區理，到處都是人們羨慕的眼光。'
        '\n\n  突然間，路邊衝出一個渾身惡臭、滿臉污穢，看來好無家可歸的老太太，垂著頭低聲地向我討東西，差點嚇我的一對寶貝。'
        '驚嚇之餘，我再仔細一看，『天啊！竟然是我國小五年級的國文老師！』」',
    photoUrl: 'assets/photos/xlcdapp_photo_3.png',
    videoId: 'Ay5KpU3QS44',
    videoName: '聖靈，再一次充滿我們 | #曾興才牧師 | 20230611 | 生命河 ROLCCmedia',
    talk: '  饒怨乃是一個決定，不能夠憑感覺。因為受傷害的感覺會使我們的思想混亂不清。'
        '當我們越去思想別人對我們的傷害，我們就越陷越深，叫我們跌入苦毒與怨恨的深淵裡。其實，那傷害你的人可能早已經把你忘得一乾二淨。'
        '當你茶飯不思的時候，他/她可能在大吃大喝；當你深夜卻無法入眠時，他/她可能早已呼呼大睡。'
        '難怪有人說：「一個不饒恕別人的人，好像一個人喝了毒藥，卻盼望別人死。」'
        '\n\n  但是當我們決定順服上帝的話去饒恕人時，我們就傷害中得醫治，得自由，重新領受上帝赦罪的恩典。'
        '\n\n  為何不作一個聰明人，選擇饒恕那傷害你的人？',
    likes: 18,
    type: 1,
    isNew: false,
  )
  ..addJoy(
    itemId: 4,
    title: '先去掉眼中樑木',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  每一個人都有優點，也有缺點。許多人際關係上的衝突，通常是出自人的自我中心，就是只看到別人的短處，而不知自己的缺點；'
        '總是覺得別人有問題，自己是完美的。',
    laugh: '  老王擔心他太太的聽覺有問題，可能需要帶耳機，他不知如何開口，就問他的醫生。'
        '\n\n  醫生告訴他一個簡單的測驗，「你可以這樣做，站離開她四十呎，用平常談話的聲音和她說話，看她是否聽見你，若聽不見，距離三十呎，然後二十呎，一直到她聽見為止。」'
        '\n\n  當天晚上，老王坐在客廳，太太在廚房做飯，他想，「我大約離她四十呎，看看她有何反應！」'
        '\n\n  然後他就用平常說話的聲音問太太說：「親愛的，今天晚上吃什麽呀？」'
        '\n\n  沒有回應。老王就走靠近廚房近一點，約三十呎，問太太說：「親愛的，今天晚上吃什麽呀？」'
        '\n\n  仍然沒有回應。他就走到飯廳，離開太太約有二十呎，又問：「親愛的，今天晚上吃什麼呀？」'
        '\n\n  還是沒有回應。因此，他就走到廚房門口，離開太太約有十呎，問：「親愛的，今天晚上吃什麽呀？」'
        '\n\n  又是沒反應。老王就走到太太的背後，問說：「親愛的，今天晚上吃什麼呀？」'
        '\n\n  太太回答說：「老公，這是第五次了，宮保雞丁！」',
    photoUrl: 'assets/photos/xlcdapp_photo_4.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '  當我們承認自己不是十分完美時，我們就會以不同的眼光去看待周圍的人。一個成功的人知道自己的優點和缺點，'
        '他/她會去發掘和欣賞別人的優點，及以別人的優點來補足自己的缺點，以自己的優點去幫補別人的缺點。'
        '更重要的是，他/她也懂得發揮自己的優點，並讓它成為自己的優勢。'
        '\n\n  今天就嘗試去發掘及欣賞你身邊人的優點吧！記得要具體地告訴他/她，你所發掘的優點。',
    likes: 17,
    type: 1,
    isNew: false,
  )
  ..addJoy(
    itemId: 5,
    title: '分享的喜樂',
    scriptureName: '路加福音 3:11',
    scriptureVerse: '約翰回答說：「有兩件衣裳的，就分給那沒有的，有食物的也當這樣行。」',
    prelude: '  分享的喜樂是雙倍的喜樂。能夠與別人分享好的東西，不但是一種美德，也是一種祝福，因為這表示你有，你才會與別人分享。',
    laugh: '  有一天，有一位老先生買了一個漢堡、薯條和一杯飲料。坐下以後，就把漢堡小心地切成一半，一半給太太，'
        '然後小心地把薯條分成兩堆，一堆放在太太面前。之後，他喝了一口飲料，太太也喝了一口，就把它放在中間。'
        '\n\n  當他開始吃他的漢堡時，周圍的人看了都在竊竊私語，顯然地，他們都在想，「這麽可憐的老夫妻，只能夠買一個套餐兩個人分著吃。」'
        '\n\n  當老先生開始吃他的薯條時，一位青年人來到他們桌前，很有禮貌地說，他想為他們多買一個套餐。'
        '\n\n  老先生說，他們不需要，因為他們習慣分享每一件東西。'
        '\n\n  靠近他們桌子的人，發現老太太一口都還沒吃，她坐在那裡，看著她的丈夫吃，偶而自己喝一口飲料。'
        '\n\n  再一次，那位青年人又走過來，要求允許他為他們買一個套餐。'
        '\n\n  這一次，老太太說：「不必了，謝謝你，我們習慣了分享每一件東西。」'
        '\n\n  終於老先生吃完了，他就用紙巾擦乾淨自己的險。那位青年人又走到老太太面前，看她什麼都還沒吃，就問她說：「您還在等什麼呀？」'
        '\n\n  老太太不慌不忙地回答說：「我在等他的假牙！」',
    photoUrl: 'assets/photos/xlcdapp_photo_5.png',
    videoId: 'sUuT3a-ibbs',
    videoName: '那九個在哪裡呢？ | 曾興才牧師 | 20231112 | 生命河 ROLCCmedia',
    talk: '  若是人人都有一顆與他人分享好東西的心， 這世界肯定會更加溫暖、可愛。'
        '其實，與他人分享好東西不是我們天生就會做的事，乃是一個需要被教導和學習的美德。'
        '一旦我們開始與他人分享好東西時，我們會驚然發現--得到的快樂是遠遠超出我們所付出的。'
        '\n\n  分享可以從日常生活中的一件小事開始，可以從你身邊的家人或朋友開始。請問有什麼好東西你可以和他人分享呢？',
    likes: 16,
    type: 1,
    isNew: false,
  )
  ..addJoy(
    itemId: 6,
    title: '選擇報告好消息',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  選擇報告好消息 ，。...',
    laugh: '    選擇報告好消息 ，。..'
        '\n\n    選擇報告好消息 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_6.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    選擇報告好消息 ，。..',
    likes: 8,
    type: 1,
    isNew: false,
  )
  ..addJoy(
    itemId: 7,
    title: '慷慨樂施',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  慷慨樂施 ，。...',
    laugh: '    慷慨樂施 ，。..'
        '\n\n    慷慨樂施 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_7.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    慷慨樂施 ，。..',
    likes: 7,
    type: 1,
    isNew: false,
  )
  ..addJoy(
    itemId: 8,
    title: '男女有別',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  男女有別 ，。...',
    laugh: '    男女有別 ，。..'
        '\n\n    男女有別 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_8.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    男女有別 ，。..',
    likes: 6,
    type: 1,
    isNew: false,
  )
  ..addJoy(
    itemId: 9,
    title: '停止相咬相吞',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  停止相咬相吞 ，。...',
    laugh: '    停止相咬相吞 ，。..'
        '\n\n    停止相咬相吞 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_9.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    停止相咬相吞 ，。..',
    likes: 5,
    type: 1,
    isNew: false,
  )
  ..addJoy(
    itemId: 10,
    title: '不要只顧自己',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  不要只顧自己 ，。...',
    laugh: '    不要只顧自己 ，。..'
        '\n\n    不要只顧自己 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_10.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    不要只顧自己 ，。..',
    likes: 4,
    type: 1,
    isNew: false,
  )
  ..addJoy(
    itemId: 11,
    title: '活出你的最高點',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  活出你的最高點 ，。...',
    laugh: '    活出你的最高點 ，。..'
        '\n\n    活出你的最高點 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_11.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    活出你的最高點 ，。..',
    likes: 3,
    type: 1,
    isNew: false,
  )
  ..addJoy(
    itemId: 12,
    title: '肯付代價',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  肯付代價 ，。...',
    laugh: '    肯付代價 ，。..'
        '\n\n    肯付代價 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_12.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    肯付代價 ，。..',
    likes: 2,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 13,
    title: '要做新事',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  要做新事 ，。...',
    laugh: '    要做新事 ，。..'
        '\n\n    要做新事 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_13.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    選擇報告好消息 ，。..',
    likes: 1,
    type: 1,
    isNew: false,
  )
  ..addJoy(
    itemId: 14,
    title: '要作智慧人',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  要作智慧人 ，。...',
    laugh: '    要作智慧人 ，。..'
        '\n\n    要作智慧人 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_14.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    要作智慧人 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 15,
    title: '上帝榮耀的豐富',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  上帝榮耀的豐富 ，。...',
    laugh: '    上帝榮耀的豐富 ，。..'
        '\n\n    上帝榮耀的豐富 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_15.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    上帝榮耀的豐富 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 52,
    title: '與你同得福音的好處',
    scriptureName: '哥林多前書 9:23',
    scriptureVerse: '凡我所行的，都是為福音的緣故，為要與人同得這福音的好處。',
    prelude:
        '  與別人認同是建立良好人際關係的方法之一。有些人會想盡方法去和別人認同，為的是要討好對方；有些人卻是真心的要與別人認同，為的是得到對方的接納。',
    laugh: '    有一個土著部落，每次集會活動時，大家都必須赤身裸體地在一起。'
        '雖然受到了很多人的白眼和辱罵，但他們卻從沒有因此改變過自己的族規。'
        '\n\n    有一次，他們這個部落傳染起瘟疫，許多人都病倒了，部落裡的醫生全都束手無策，最後他們決定到鄰近的部落去請一位有名的醫生。'
        '那位醫生知道他們奇怪的族規，覺得去到那地方會非常難為情，但他又拒絕不了他們三番兩次的邀請，又感到還是救人比面子重要，便答應了。'
        '\n\n    終於到了歡迎醫生到來的那一天，部落的人想，好不容易把醫生請來，為了尊重他起見，咱們就破例一次吧。'
        '所以那一天大家都穿上衣服，打上了領帶，聚集在他們的會堂裡。'
        '\n\n    鐘聲響過之後，醫生走了進來，大家一下子都愣住了。只見年紀老邁，白髮蒼蒼的醫生背著重重的醫療包，身上卻一絲不掛！',
    photoUrl: 'assets/photos/xlcdapp_photo_52.png',
    videoId: 'WLssNhv886A',
    videoName: '同心領受命定的福 | 曾興才牧師 | 20180922 | 生命河 ROLCCmedia',
    talk: '    使徒保羅是主耶穌最偉大的門徒之一。他為了傳福音，就是好消息，受盡了逼迫、災難和痛苦，他也願意放下身段和他所接觸的人認同。'
        '因此，他說：「向軟弱的人，我就作軟弱的人，為要得軟弱的人。向什麼樣的人，我就作什麼樣的人。無論如何，總要救些人。'
        '凡我所行的，都是為福音的缘故，為要與人同得這福音的好處。」（哥林多前書九章22~23 節）'
        '\n\n  為什麼保羅如此用心的要與人同得這福音的好處呢？因為福音對你太重要了！'
        '\n\n  那什麼是福音呢？福音就是上帝非常愛你和世上的人，愛到祂願意差遣他的獨生兒子耶穌基督，來到世上，為你我的罪釘死在十字架上，第三天從死裡復活，把永生的生命賜給你和我。'
        '只要你願意相信接受耶穌基督作為你生命的主，你就可以享受豐盛的生命，永生的生命。'
        '\n\n  我們每一個人都必須作相信接受主耶穌的決定。如果你願意的話，可以作以下的禱告，把你心中的決定告訴主耶穌：'
        '\n\n  「親愛的天父上帝，我感謝祢這麼愛我，把祢獨生的兒子主耶穌賜給我，為我的罪釘死在十字架上，第三天從死裡復活。'
        '我現在願意相信並接受主耶穌作我個人的救主，赦免我的罪，賜我豐盛、永生的生命。'
        '我願意一生跟隨祢，敬拜祢，我如此禱告，乃是奉靠主耶穌基督的名求，阿們！」'
        '\n\n  恭喜你！按照天父上帝的應許，你現在就成為祂的兒女了：「凡接待祂（主耶穌）的，就是信祂（主耶穌）名的人，祂就賜他們權柄作上帝的兒女。」（約翰福音一章12節）',
    likes: 0,
    type: 1,
    isNew: true,
  );

  /* 
  ..addJoy(
    itemId: 16,
    title: '起初的愛心',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  起初的愛心 ，。...',
    laugh: '    起初的愛心 ，。..'
        '\n\n    起初的愛心 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_16.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    起初的愛心 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 17,
    title: '要像小孩子',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  要像小孩子 ，。...',
    laugh: '    要像小孩子 ，。..'
        '\n\n    要像小孩子 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_17.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    要像小孩子 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 18,
    title: '應當一無掛慮',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  應當一無掛慮 ，。...',
    laugh: '    應當一無掛慮 ，。..'
        '\n\n    應當一無掛慮 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_18.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    應當一無掛慮 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 19,
    title: '不要以惡報惡',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  不要以惡報惡 ，。...',
    laugh: '    不要以惡報惡 ，。..'
        '\n\n    不要以惡報惡 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_19.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    不要以惡報惡 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 20,
    title: '要孝敬父母',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  要孝敬父母 ，。...',
    laugh: '    要孝敬父母 ，。..'
        '\n\n    要孝敬父母 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_20.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    要孝敬父母 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 21,
    title: '靈巧像蛇、馴良像鴿子',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  靈巧像蛇、馴良像鴿子 ，。...',
    laugh: '    靈巧像蛇、馴良像鴿子 ，。..'
        '\n\n    靈巧像蛇、馴良像鴿子 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_21.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    靈巧像蛇、馴良像鴿子 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 22,
    title: '隱藏的事會顯出來',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  隱藏的事會顯出來 ，。...',
    laugh: '    隱藏的事會顯出來 ，。..'
        '\n\n    隱藏的事會顯出來 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_22.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    隱藏的事會顯出來 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 23,
    title: '勇敢改變自己',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  勇敢改變自己 ，。...',
    laugh: '    勇敢改變自己 ，。..'
        '\n\n    勇敢改變自己 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_23.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    勇敢改變自己 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 24,
    title: '要凡事謝恩',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  要凡事謝恩 ，。...',
    laugh: '    要凡事謝恩 ，。..'
        '\n\n    要凡事謝恩 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_24.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    要凡事謝恩 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 25,
    title: '愛人不可虛假',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  愛人不可虛假 ，。...',
    laugh: '    愛人不可虛假 ，。..'
        '\n\n    愛人不可虛假 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_25.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    愛人不可虛假 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 26,
    title: '不要以外貌看人',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  不要以外貌看人 ，。...',
    laugh: '    不要以外貌看人 ，。..'
        '\n\n    不要以外貌看人 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_26.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    不要以外貌看人 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 27,
    title: '喜樂的心是良藥',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  喜樂的心是良藥 ，。...',
    laugh: '    喜樂的心是良藥 ，。..'
        '\n\n    喜樂的心是良藥 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_27.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    喜樂的心是良藥 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 28,
    title: '專注的能力',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  專注的能力 ，。...',
    laugh: '    專注的能力 ，。..'
        '\n\n    專注的能力 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_28.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    專注的能力 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 29,
    title: '成功的秘訣',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  成功的秘訣 ，。...',
    laugh: '    成功的秘訣 ，。..'
        '\n\n    成功的秘訣 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_29.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    成功的秘訣 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 30,
    title: '用愛心說誠實話',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  用愛心說誠實話 ，。...',
    laugh: '    用愛心說誠實話 ，。..'
        '\n\n    用愛心說誠實話 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_30.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    用愛心說誠實話 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
..addJoy(
    itemId: 31,
    title: '為我造清潔的心',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  為我造清潔的心 ，。...',
    laugh: '    為我造清潔的心 ，。..'
        '\n\n    為我造清潔的心 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_31.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    為我造清潔的心 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 32,
    title: '有衣有食就當知足',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  有衣有食就當知足 ，。...',
    laugh: '    有衣有食就當知足 ，。..'
        '\n\n    有衣有食就當知足 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_32.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    有衣有食就當知足 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 33,
    title: '永生是上帝的恩賜',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  永生是上帝的恩賜 ，。...',
    laugh: '    永生是上帝的恩賜 ，。..'
        '\n\n    永生是上帝的恩賜 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_33.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    永生是上帝的恩賜 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 34,
    title: '作一個内裡誠責的人',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  作一個内裡誠責的人 ，。...',
    laugh: '    作一個内裡誠責的人 ，。..'
        '\n\n    作一個内裡誠責的人 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_34.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    作一個内裡誠責的人 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 35,
    title: '管教是愛',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  管教是愛 ，。...',
    laugh: '    管教是愛 ，。..'
        '\n\n    管教是愛 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_35.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    管教是愛 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 36,
    title: '你可以勝過試探',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  你可以勝過試探 ，。...',
    laugh: '    你可以勝過試探 ，。..'
        '\n\n    你可以勝過試探 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_36.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    你可以勝過試探 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 37,
    title: '要愛你的妻子',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  要愛你的妻子 ，。...',
    laugh: '    要愛你的妻子 ，。..'
        '\n\n    要愛你的妻子 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_37.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    要愛你的妻子 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 38,
    title: '要殷勤、不可懶惰',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  要殷勤、不可懶惰 ，。...',
    laugh: '    要殷勤、不可懶惰 ，。..'
        '\n\n    要殷勤、不可懶惰 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_38.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    要殷勤、不可懶惰 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 39,
    title: '真正的平安',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  真正的平安 ，。...',
    laugh: '    真正的平安 ，。..'
        '\n\n    真正的平安 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_39.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    真正的平安 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 40,
    title: '要教養孩子',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  要教養孩子 ，。...',
    laugh: '    要教養孩子 ，。..'
        '\n\n    要教養孩子 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_40.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    要教養孩子 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 41,
    title: '不要作糊塗人',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  不要作糊塗人 ，。...',
    laugh: '    不要作糊塗人 ，。..'
        '\n\n    不要作糊塗人 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_41.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    不要作糊塗人 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 42,
    title: '與智慧人同行',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  與智慧人同行 ，。...',
    laugh: '    與智慧人同行 ，。..'
        '\n\n    與智慧人同行 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_42.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    與智慧人同行 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 43,
    title: '不要惹兒女的氣',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  不要惹兒女的氣 ，。...',
    laugh: '    不要惹兒女的氣 ，。..'
        '\n\n    不要惹兒女的氣 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_43.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    不要惹兒女的氣 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 44,
    title: '不可安求',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  不可安求 ，。...',
    laugh: '    不可安求 ，。..'
        '\n\n    不可安求 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_44.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    不可安求 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 45,
    title: '得力在乎平靜安穩',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  得力在乎平靜安穩 ，。...',
    laugh: '    得力在乎平靜安穩 ，。..'
        '\n\n    得力在乎平靜安穩 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_45.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    得力在乎平靜安穩 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 46,
    title: '要培養內在美',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  要培養內在美 ，。...',
    laugh: '    要培養內在美 ，。..'
        '\n\n    要培養內在美 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_46.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    要培養內在美 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 47,
    title: '得著妻子的人有福了',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  得著妻子的人有福了 ，。...',
    laugh: '    得著妻子的人有福了 ，。..'
        '\n\n    得著妻子的人有福了 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_47.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    得著妻子的人有福了 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 48,
    title: '自卑的必升為高',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  自卑的必升為高 ，。...',
    laugh: '    自卑的必升為高 ，。..'
        '\n\n    自卑的必升為高 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_48.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    自卑的必升為高 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 49,
    title: '不可離棄智慧',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  不可離棄智慧 ，。...',
    laugh: '    不可離棄智慧 ，。..'
        '\n\n    不可離棄智慧 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_49.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    不可離棄智慧 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 50,
    title: '真實的彼此相愛',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  真實的彼此相愛 ，。...',
    laugh: '    真實的彼此相愛 ，。..'
        '\n\n    真實的彼此相愛 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_50.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    真實的彼此相愛 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
  )
  ..addJoy(
    itemId: 51,
    title: '要彼此順服',
    scriptureName: '馬太福音 7:4',
    scriptureVerse: '你自己眼中有梁木，怎能對你弟兄說『容我去掉你眼中的刺』呢？',
    prelude: '  要彼此順服 ，。...',
    laugh: '    要彼此順服 ，。..'
        '\n\n    要彼此順服 ，。..',
    photoUrl: 'assets/photos/xlcdapp_photo_51.png',
    videoId: 'gUxlZ4S_meE',
    videoName: '你要我為你做什麼 | 曾興才牧師 | 20220109 | 生命河 ROLCCmedia',
    talk: '    要彼此順服 ，。..',
    likes: 0,
    type: 1,
    isNew: true,
);

 */