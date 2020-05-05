import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wallpaper/helper/color.dart';

class ListCollection {
  List draw = ["Home", "Download", "Privacy Policy", "Contact Us"];
  List list = [
    Icon(
      FontAwesomeIcons.home,
      color: gainsborohs,
    ),
    Icon(
      FontAwesomeIcons.download,
      color: gainsborohs,
    ),
    Icon(
      FontAwesomeIcons.exclamation,
      color: gainsborohs,
    ),
    Icon(
      FontAwesomeIcons.mailBulk,
      color: gainsborohs,
    ),
  ];
}
