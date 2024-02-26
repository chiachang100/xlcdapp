import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(
                      Icons.favorite_sharp,
                      color: Colors.pink,
                    ),
                    title: Text('主的喜樂是我的力量'),
                    subtitle: Text('「你們不要憂愁，因靠耶和華而得的喜樂是你們的力量。」(尼希米記 8:10)'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {},
                        child: const Text('View Details'),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(
                      Icons.face_rounded,
                      color: Colors.pink,
                    ),
                    title: Text('要常常喜樂'),
                    subtitle: Text(
                        '「要常常喜樂，不住地禱告，凡事謝恩，因為這是神在基督耶穌裡向你們所定的旨意。」(帖撒羅尼迦前書 5:16-18)'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {},
                        child: const Text('View Details'),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(
                      Icons.favorite,
                      color: Colors.pink,
                    ),
                    title: Text('喜樂的心'),
                    subtitle: Text('「喜樂的心乃是良藥，憂傷的靈使骨枯乾。」(箴言 17:22)'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {},
                        child: const Text('View Details'),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}







//           shadowColor: Colors.transparent,
//           margin: const EdgeInsets.all(8.0),
//           child: SizedBox.expand(
//             child: Column(
//               children: [
//                 Text(
//                   '主的喜樂是我的力量',
//                 ),
//                 Text(
//                   '你們不要憂愁，因靠耶和華而得的喜樂是你們的力量。(尼希米記8:10)',
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
