import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../data.dart';

late final FirebaseApp app;
late final FirebaseAuth auth;

const bool turnonSignIn = true;
late JoyStore joystoreInstance;

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
