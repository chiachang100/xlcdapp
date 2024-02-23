# xlcdapp

xlcdapp-笑裡藏道.

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
