import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wallpaper/helper/color.dart';

class ListCollection {
  List draw = ["Home", "Download", "Disclaimer", "Rate This App", "Report Bug"];
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
      FontAwesomeIcons.exclamationCircle,
      color: gainsborohs,
    ),
    Icon(
      FontAwesomeIcons.star,
      color: gainsborohs,
    ),
    Icon(
      FontAwesomeIcons.bug,
      color: gainsborohs,
    ),
  ];
}
