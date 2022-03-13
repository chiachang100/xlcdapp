import 'package:flutter/material.dart';

// Source: "Flutter : Working with Raised Button" by Yuvraj Pandey
// https://medium.com/@yuvrajpandey24/working-with-raised-button-in-flutter-6f5c0f71aab3
// GitHub: https://github.com/yuvraj24/Fluttereo

class RollCallPartner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RollCallState();
  }
}

class RollCallState extends State<RollCallPartner> {
  int number = 0;

  void subtractNumbers() {
    setState(() {
      number = (number >= 1) ? (number - 1) : 0;
    });
  }

  void addNumbers() {
    setState(() {
      number = number + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("點名夥伴"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$number',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 160.0,
                fontFamily: 'Roboto',
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: subtractNumbers,
                  textColor: Colors.white,
                  color: Colors.red,
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.exposure_neg_1,
                    size: 50,
                  ),
                  shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
/*
                  child: Text(
                    "減少",
                    style: TextStyle(fontSize: 24),
                  ),
*/
                ),
                RaisedButton(
                  padding: const EdgeInsets.all(8.0),
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: addNumbers,
                  child: Icon(
                    Icons.exposure_plus_1,
                    size: 50,
                  ),
                  shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),

/*
                  child: Text(
                    "增加",
                    style: TextStyle(fontSize: 24),
                  ),
*/
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
