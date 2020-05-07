// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:wallpaper/main.dart';
import 'package:wallpaper/screen/wallpaperdetail.dart';
import 'package:wallpaper/screen/download.dart';

abstract class Routes {
  static const mainScreenPage = '/';
  static const wallpaperDetail = '/wallpaper-detail';
  static const downloadPage = '/download-page';
}

class Router extends RouterBase {
  //This will probably be removed in future versions
  //you should call ExtendedNavigator.ofRouter<Router>() directly
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.mainScreenPage:
        if (hasInvalidArgs<MainScreenPageArguments>(args)) {
          return misTypedArgsRoute<MainScreenPageArguments>(args);
        }
        final typedArgs =
            args as MainScreenPageArguments ?? MainScreenPageArguments();
        return CupertinoPageRoute<dynamic>(
          builder: (context) => MainScreenPage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.wallpaperDetail:
        if (hasInvalidArgs<WallpaperDetailArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<WallpaperDetailArguments>(args);
        }
        final typedArgs = args as WallpaperDetailArguments;
        return CupertinoPageRoute<dynamic>(
          builder: (context) => WallpaperDetail(
              key: typedArgs.key,
              index: typedArgs.index,
              url: typedArgs.url,
              title: typedArgs.title,
              author: typedArgs.author,
              ups: typedArgs.ups,
              sizeofimage: typedArgs.sizeofimage,
              date: typedArgs.date,
              imagebytes: typedArgs.imagebytes,
              imageextenstion: typedArgs.imageextenstion),
          settings: settings,
        );
      case Routes.downloadPage:
        if (hasInvalidArgs<DownloadPageArguments>(args)) {
          return misTypedArgsRoute<DownloadPageArguments>(args);
        }
        final typedArgs =
            args as DownloadPageArguments ?? DownloadPageArguments();
        return CupertinoPageRoute<dynamic>(
          builder: (context) => DownloadPage(key: typedArgs.key),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//MainScreenPage arguments holder class
class MainScreenPageArguments {
  final Key key;
  MainScreenPageArguments({this.key});
}

//WallpaperDetail arguments holder class
class WallpaperDetailArguments {
  final Key key;
  final int index;
  final String url;
  final String title;
  final String author;
  final int ups;
  final String sizeofimage;
  final String date;
  final String imagebytes;
  final String imageextenstion;
  WallpaperDetailArguments(
      {this.key,
      @required this.index,
      @required this.url,
      @required this.title,
      @required this.author,
      @required this.ups,
      @required this.sizeofimage,
      @required this.date,
      @required this.imagebytes,
      @required this.imageextenstion});
}

//DownloadPage arguments holder class
class DownloadPageArguments {
  final Key key;
  DownloadPageArguments({this.key});
}
