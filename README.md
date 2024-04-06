# xlcdapp

xlcdapp-笑裡藏道.

## References
- [靈糧書房購買"笑裡藏道"書籍](https://www.rolcc.net/opencart/index.php?route=product/product&product_id=358)
- [笑裡藏道書籍作者曾興才牧師講道視頻@YouTube](https://www.youtube.com/results?search_query=%22%E6%9B%BE%E8%88%88%E6%89%8D%E7%89%A7%E5%B8%AB%22)
- [笑裡藏道](https://xlcdapp.web.app/)
- [Flutter orientation lock: portrait only](https://greymag.medium.com/flutter-orientation-lock-portrait-only-c98910ebd769)
- [Flutter website](https://flutter.dev/)
- [Flutter samples](https://flutter.github.io/samples/#)
  - [Flutter samples: Navigation and Routing](https://flutter.github.io/samples/navigation_and_routing.html)
  - [How to add a YouTube video to your Flutter app? by 
Walnut Software](https://walnutistanbul.medium.com/how-to-add-a-youtube-video-to-your-flutter-app-40c0125414ba)

---
### Flutter Packages
#### YouTube Player packages: youtube_player_flutter, flutter_inappwebview, and youtube_player_iframe
- [youtube_player_flutter](youtube_player_flutter)
  - `flutter pub add youtube_player_flutter`
  - `youtube_player_flutter` depends on `flutter_inappwebview`
    - [flutter_inappwebview](https://pub.dev/packages/flutter_inappwebview)
      - `flutter pub add flutter_inappwebview`
    - [flutter_inappwebview: Getting Started](https://inappwebview.dev/docs/intro/)
  - NOTE:
    - For Android & iOS: it seems to work fine.
    - For Web: it didn't work. The follow errors were thrown:
```
"Error: UnimplementedError: addJavaScriptHandler is not implemented on the current platform."
...
```
- [youtube_player_iframe](https://pub.dev/packages/youtube_player_iframe)
  - [Depends on webview_flutter (Android & iOS)](https://pub.dev/packages/webview_flutter)
- [Material Icons](https://fonts.google.com/icons)
- [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)
  - After adding your settings to pubspec.yaml, run the following command in the terminal:
    - `dart run flutter_native_splash:create`
    - OR: `flutter pub run flutter_native_splash:create`

- IMPORTANT NOTES:
  - For Web: use `youtube_player_iframe`.
  - For Android and iOS: use `youtube_player_flutter` and  `flutter_inappwebview`.
  
---
## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


---
## Add Firebase to your Flutter app
- Source: [Add Firebase to your Flutter app](https://firebase.google.com/docs/flutter/setup?platform=android#available-plugins)

### Prequisites
- Install IDE.
- Set up a device or emulator.
- Install FLuter.
- [Install the Firebase CLI](https://firebase.google.com/docs/cli#setup_update_cli).
- Sign into Firebase.
### Step 1: Install the required command line tools
- `firebase login`
- Insall the FlutterFire CLI
  - `dart pub global activate flutterfire_cli`
### Step 2: Configure your apps to use Firebase
- `flutterfire configure -i com.joyolord.xlcdapp -a com.joyolord.xlcdapp`
  - Select the platforms (iOS, Android, Web) in your Flutter app.
  - Create a Firebase configuration file
    - `lib/firebase_options.dart`
### Step 3: Initialize Firebase in your app
- From your Flutter project, install the core plugin:
  - `flutter pub add firebase_core`
- From your Flutter project, ensure your Flutter app's Firebase configuration is up-to-date
  - `flutterfire configure -i com.joyolord.app.xlcdapp -a com.joyolord.app.xlcdapp`
```
✔ Which platforms should your configuration support (use arrow keys & space to select)? · android, ios, web
i Firebase android app com.joyolord.xlcdapp registered.
i Firebase ios app com.joyolord.xlcdapp registered.
i Firebase web app xlcdapp (web) registered.

Firebase configuration file lib\firebase_options.dart generated successfully with the following Firebase apps:

Platform  Firebase App Id
web       1:613422672008:web:b2ccf3a963676d8a25573d
android   1:613422672008:android:35cf1831d54b20fc25573d
ios       1:613422672008:ios:7c5735d8ef3e17a325573d
```
- In your `lib/main.dart` file, import Firebase core plugin and the configuration file you generated earlier:
```
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
```
- Also in your lib/main.dart file, initialize Firebase using teh **DefaultFirebaseOptions** object
```
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```
- Rebuild your Flutter application
  - `flutter pub get`
  - Web: `flutter run -d chrome`
  - Web: `flutter run -d chrome --web-hostname=192.168.1.100 --web-port=80`
  - Android Emulator: `flutter run -d emulator-5554`
  - iOS Simulator: `flutter run -d [TBS]`

### Step 4: Add Firebase plugins
- From your Flutter project directory, run the following commands:
  - `flutter pub add firebase_analytics`
  - `flutter pub add firebase_auth`
  - `flutter pub add cloud_firestore`
- From your Flutter project, ensure your Flutter app's Firebase configuration is up-to-date
  - `flutterfire configure -i com.joyolord.app.xlcdapp -a com.joyolord.app.xlcdapp`
- Rebuild your Flutter application
  - `flutter pub get`
  - Web: `flutter run -d chrome`
  - Android Emulator: `flutter run -d emulator-5554`
  - iOS Simulator: `flutter run -d [TBS]`

### Step 5: Add Firebase Hosting
- Source: [Firebase CLI reference](https://firebase.google.com/docs/cli)
- Install Node.js using NVM (Node Version Manager))
  - Linux/MacOS: [Node Version Manager](https://github.com/nvm-sh/nvm)
  - Windows: [nvm-windows](https://github.com/coreybutler/nvm-windows).
- Install Firebase tools
  - `npm install -g firebase-tools`
- Log into Firebase
  - `firebase login`
- [Use the CLI with CI systems](https://firebase.google.com/docs/cli#cli-ci-systems)
  - `firebase login:ci`
- Listing your Firebase projects
  - `firebase projects:list`
- Initialize a Firebase project
  - Run the following command from within your app's directory:
  - `firebase init`
  - It will create `firebase.json` config file.
- Use project aliases
  - `firebase use`
  - `firebase use xlcdapp (<PROJECT_ID|ALIAS>)`
- Serve and test your Firebase project locally
  - `flutter build -v web --release`
  - `firebase serve --only hosting`
- Test from other local devices
  - `firebase serve --host 0.0.0.0  --only hosting` // accepts requests to any host
- Deploy to a Firebase project
  - `firebase deploy`
  - OR `firebase deploy --only hosting`

---

## Add Firebase packages for iOS
- Firebase iOS SDK
  - Using [Swift Package Manager](https://github.com/firebase/firebase-ios-sdk/blob/main/SwiftPackageManager.md).
  - Installing from Xcode
  - Add a package by selecting File → Add Packages… in Xcode’s menu bar.
  - Search for the Firebase Apple SDK using the repo's URL:
    - `https://github.com/firebase/firebase-ios-sdk.git`
  - Next, set the Dependency Rule to be Up to Next Major Version.
    - Then, select Add Package.
    - Choose the Firebase products that you want installed in your app.
    - If you've installed FirebaseAnalytics, add the `-ObjC` option to Other Linker Flags in the Build Settings tab.
- Flutterfire iOS SDK
  - Follow the instructions describe in the **Firebase iOS SDK** section with the follow repo's URL:
    - `https://github.com/firebase/flutterfire.git`

---
## Useful Tools
- `flutter clean`
- `flutter test`
- `flutter build -v web --release`
- Serve and test your Firebase project locally
  - `firebase serve --only hosting`
- To deploy to your site to firebase hosting:
  - `firebase deploy --only hosting`
- Update `firebase tool`
  - `npm install -g firebase-tools`

## Setup firebaseServiceAccount on GitHub
- Follow the following instructions to setup `firebaseServiceAccount` on GitHub for `.github/workflow/firebase-hosting-merge.yml`:
- [Firebase Hosting with GitHub Actions. Prachit Suhas Patil](https://dev.to/pprachit09/firebase-hosting-with-github-actions-55ka)
```
        firebaseServiceAccount: '${{ secrets.FIREBASE_SERVICE_ACCOUNT_XLCDAPP }}'
```

---
## Youtube Player plugins

- Use `youtube_player_flutter`
- `flutter pub add youtube_player_flutter`

- Use `youtube_player_iframe`
- `flutter pub add youtube_player_iframe`

---
## Local Firebase Emulator
- [Get Started with Firebase Authentication on Flutter](https://firebase.google.com/docs/auth/flutter/start)

- Start Emulator
  - `firebase emulators:start`

---
## Troubleshooting
### Troubleshooting on iOS
- Error: `Module 'flutter_inappwebview_ios' not found`
  - `flutter clean`
  - `flutter pub get`
- Error: `Error (Xcode): redefinition of module 'Firebase'`
```
Error (Xcode): redefinition of module 'Firebase'
/Users/chiachang/src/git/chiachang100/xlcdapp/ios/Pods/Firebase/CoreOnly/Sources/module.modulemap:0:7
```
  - `vi /Users/chiachang/src/git/chiachang100/xlcdapp/ios/Pods/Firebase/CoreOnly/Sources/module.modulemap`
  - Replace `module Firebase` with `module FirebaseCoreOnly`
```
module FirebaseCoreOnly {
  export *
  header "Firebase.h"
}
```

---
Copyright (c) 2024 Chia Chang. The MIT License (MIT). 

---
