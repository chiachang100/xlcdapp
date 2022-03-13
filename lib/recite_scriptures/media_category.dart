import 'package:flutter/material.dart';

enum JoymmType { dev, prod }

enum XlcdMediaPlaylist {
  home,
  art,
  business,
  religion,
  media,
  education,
  family,
  government
}

List<Color> XlcdMediaColorList = [
  // 0. misc
  Colors.red,
  // A. art
  Colors.red,
  // B. business
  Colors.orange,
  // C. religion
  //Colors.yellow[600],
  //Colors.amber,
  Colors.yellow,
  // D. media
  Colors.green,
  // E. education
  Colors.blue,
  // F. family
  Colors.indigo,
  // G. government
  Colors.purple,
  // H. misc
  Colors.greenAccent,
  // I. apps
  Colors.grey,
];

List<IconData> XlcdMediaIconList = [
  // 0. misc
  Icons.favorite_border,
  // A. art
  Icons.filter_1,
  // B. business
  Icons.filter_2,
  // C. religion
  Icons.filter_3,
  // D. media
  Icons.filter_4,
  // E. education
  Icons.filter_5,
  // F. family
  Icons.filter_6,
  // G. government
  Icons.filter_7,
  // H. heart
  Icons.favorite_border,
  // I. apps
  Icons.apps,
];

// Old list
List<IconData> XlcdMediaIconListOld = [
  // 0. misc
  Icons.favorite_border,
  // 1. art
  Icons.ac_unit,
  // 2. business
  Icons.monetization_on,
  // 3. religion
  Icons.people,
  // 4. media
  Icons.video_library,
  // 5. education
  Icons.school,
  // 6. family
  Icons.home,
  // 7. government
  Icons.location_city,
  // 8. heart
  Icons.favorite_border,
  // 9. apps
  Icons.apps,
];
