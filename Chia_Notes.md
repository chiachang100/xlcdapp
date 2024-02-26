# Chia's Notes

## Firebase Local Emulator Suite
- [Install and Configure Local Emulator Suite](https://firebase.google.com/docs/emulator-suite/install_and_configure)

- `firebase init emulators`
  - `firebase.json`
  - `.firebaserc`

- Specifying Java options
  - `export JAVA_TOOL_OPTIONS="-Xmx4g"`

- Start up emulators
  - `firebase emulators:start --import c:\ws\fb_emulators --export-on-exit`
  - `firebase emulators:exec scriptpath`

```
=== Project Setup

First, let's associate this project directory with a Firebase project.
You can create multiple project aliases by running firebase use --add,
but for now we'll just set up a default project.

i  Using project xlcdapp (xlcdapp)

=== Emulators Setup
=== Emulators Setup
? Which Firebase emulators do you want to set up? Press Space to select emulators, then Enter to confirm your choices.
Authentication Emulator, Firestore Emulator, Database Emulator, Hosting Emulator
i  Port for auth already configured: 9099
i  Port for firestore already configured: 8080
i  Port for database already configured: 9000
i  Port for hosting already configured: 5000
i  Emulator UI already enabled with port: (automatic)
? Would you like to download the emulators now? Yes
```

## Updating to NavigationBar
- [Updating BottomNavigationBar to NavigationBar](https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html)
```
Updating to NavigationBar
The NavigationBar widget's visuals are a little bit different, see the Material 3 spec at m3.material.io/components/navigation-bar/overview for more details.

The NavigationBar widget's API is also slightly different. To update from BottomNavigationBar to NavigationBar, you will need to make the following changes.

Instead of using BottomNavigationBar.items, which takes a list of BottomNavigationBarItems, use NavigationBar.destinations, which takes a list of widgets. Usually, you use a list of NavigationDestination widgets. Just like BottomNavigationBarItems, NavigationDestinations have a label and icon field.

Instead of using BottomNavigationBar.onTap, use NavigationBar.onDestinationSelected, which is also a callback that is called when the user taps on a navigation bar item.

Instead of using BottomNavigationBar.currentIndex, use NavigationBar.selectedIndex, which is also an integer that represents the index of the selected destination.

You may also need to make changes to the styling of the NavigationBar, see the properties in the NavigationBar constructor for more details.
```

---
```
  getData() async {
    var db = FirebaseFirestore.instance;
    var categoryList = [];
    await db.collection('categories').doc(value).get().then((DocumentSnapshot doc) {
      var listSubCol = doc["categoryCollection"];
      listSubCol.forEach((id) {
        db.collection('categories').doc(value).collection(id).get().then((snapshot) {
          snapshot.docs.forEach((element) {
            categoryList.add(element.data());
          });
        });
        return categoryList;
      });
    });
    return categoryList;
  }
  ```

---
```
══╡ EXCEPTION CAUGHT BY WIDGETS LIBRARY ╞═══════════════════════════════════════════════════════════
The following TypeErrorImpl was thrown building StreamBuilder<QuerySnapshot<Object?>>(dirty, state:
_StreamBuilderBaseState<QuerySnapshot<Object?>, AsyncSnapshot<QuerySnapshot<Object?>>>#0b658):
Expected a value of type 'List<DocumentSnapshot<Object?>>', but got one of type '_JsonQuerySnapshot'

The relevant error-causing widget was:
  StreamBuilder<QuerySnapshot<Object?>>
  StreamBuilder:file:///c:/src/git/chiachang100/xlcdapp/lib/media_list/recommended_media.dart:399:18

```

---
