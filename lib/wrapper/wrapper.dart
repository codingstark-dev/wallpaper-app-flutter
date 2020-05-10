import 'package:flutter/material.dart';
import 'package:wallpaper/helper/color.dart';
import 'package:wallpaper/main.dart';
import 'package:wallpaper/screen/introscreen.dart';
import 'package:wallpaper/service/locator.dart';
import 'package:wallpaper/service/setwallpaper/wallpaperfun.dart';

class Wrapper extends StatefulWidget {
  Wrapper({Key key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool loadingscreen;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sl.get<WallpaperFun>().allreadyVisitingBool().then((value) => setState(() {
          loadingscreen = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (loadingscreen == true) {
      return MainScreenPage();
    } else if (loadingscreen == false) {
      return IntroScreen();
    } else {
      return Container(
        color: darkslategrayhs,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
