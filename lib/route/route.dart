import 'package:flutter/material.dart';
import 'package:wallpaper/main.dart';
import 'package:wallpaper/route/const_route.dart';
import 'package:wallpaper/screen/wallpaperdetail.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case WallpaperDetailPage:
      return MaterialPageRoute(builder: (context) => WallpaperDetail());
    case HomePage:
      return MaterialPageRoute(builder: (context) => MainScreenPage());
    default:
      return MaterialPageRoute(builder: (context) => MainScreenPage());
  }
}
