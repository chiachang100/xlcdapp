# xlcdapp

A new Flutter project.

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
- `flutterfire configure`
- `flutterfire configure -i com.joyolord.joyolordapp -a com.joyolord.joyolordapp`
  - Select the platforms (iOS, Android, Web) in your Flutter app.
  - Create a Firebase configuration file
    - `lib/firebase_options.dart`
### Step 3: Initialize Firebase in your app
- From your Flutter project, install the core plugin:
  - `flutter pub add firebase_core`
- From your Flutter project, ensure your Flutter app's Firebase configuration is up-to-date
  - `flutterfire configure -i com.joyolord.app.xlcdapp -a com.joyolord.app.xlcdapp`
- In your lib/main.dart file, import Firebase core plugin and the configuration file you generated earlier:
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
  - `flutter run`

### Step 4: Add Firebase plugins
- From your Flutter project directory, run the following commands:
  - `flutter pub add firebase_analytics`
  - `flutter pub add firebase_auth`
- From your Flutter project, ensure your Flutter app's Firebase configuration is up-to-date
  - `flutterfire configure -i com.joyolord.app.xlcdapp -a com.joyolord.app.xlcdapp`
- Rebuild your Flutter application
  - `flutter run`

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

---