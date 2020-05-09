import 'package:flutter/material.dart';
import 'package:wallpaper/main.dart';
import 'package:wallpaper/screen/introscreen.dart';
import 'package:wallpaper/service/locator.dart';
import 'package:wallpaper/service/setwallpaper/wallpaperfun.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);
  Future<bool> get getbool async {
    bool navigate = await sl.get<WallpaperFun>().allreadyVisitingBool();
    return navigate;
  }

  @override
  Widget build(BuildContext context) {
    if (getbool == true) {
      return MainScreenPage();
    } else {    
      return IntroScreen();
    }
  }
}
