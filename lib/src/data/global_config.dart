import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../data.dart';

const bool turnonSignIn = true;
const bool useYoutubePlayerFlutterVersion = true;

late final FirebaseApp app;
late final FirebaseAuth auth;
late JoyStore joystoreInstance;

// late String joysCurrentLocale;
var joysCurrentLocale = LOCALE_ZH_TW;
const LOCALE_ZH_CN = 'zh_CN';
const LOCALE_ZH_TW = 'zh_TW';

// late String joystoreName;
var joystoreName = JOYSTORE_NAME_ZH_TW;
const JOYSTORE_NAME_DEFAULT = 'joys';
const JOYSTORE_NAME_ZH_CN = 'joys_zh_cn';
const JOYSTORE_NAME_ZH_TW = 'joys_zh_tw';

// 紅、橙、黃、綠、藍、靛、紫
List<Color> circleAvatarBgColor = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.indigoAccent,
  Colors.deepPurpleAccent,
];

List<String> rankingEmoji = [
  '0️⃣',
  '1️⃣',
  '2️⃣',
  '3️⃣',
  '4️⃣',
  '5️⃣',
  '6️⃣',
  '7️⃣',
  '8️⃣',
  '9️⃣',
  '🔟',
];
