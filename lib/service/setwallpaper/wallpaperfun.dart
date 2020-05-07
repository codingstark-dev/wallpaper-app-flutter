import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class WallpaperFun {
  Future setwallpaper(String url) async {
    // ignore: unused_local_variable
    String platformVersion;
    // setState(() {
    //   loadingBool = true;
    // });

    try {
      platformVersion = await WallpaperManager.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    var file = await DefaultCacheManager().getSingleFile(url);
    // Platform messages may fail, so we use a try/catch PlatformException.

    await WallpaperManager.setWallpaperFromFile(
        file.path, WallpaperManager.HOME_SCREEN);
    // .catchError((onError) =>
    //     Fluttertoast.showToast(msg: "Something Went Wrong $onError"));
    await WallpaperManager.setWallpaperFromFile(
        file.path, WallpaperManager.LOCK_SCREEN);
    // print(file.path);
    // result = await Dio().download(file.path, "Download/");
    // File _file = File(file.path);
    // var basenam = basename(_file.path);
    // saveFile(file, basenam.split(".")[1]);
  }

  Future setwallpaperStorage(path) async {
    // ignore: unused_local_variable
    String platformVersion;
    // setState(() {
    //   loadingBool = true;
    // });

    try {
      platformVersion = await WallpaperManager.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // var file = await DefaultCacheManager().getSingleFile(url);
    // Platform messages may fail, so we use a try/catch PlatformException.

    await WallpaperManager.setWallpaperFromFile(
        path, WallpaperManager.HOME_SCREEN);
    // .catchError((onError) =>
    //     Fluttertoast.showToast(msg: "Something Went Wrong $onError"));
    await WallpaperManager.setWallpaperFromFile(
        path, WallpaperManager.LOCK_SCREEN);
    // print(file.path);
    // result = await Dio().download(file.path, "Download/");
    // File _file = File(file.path);
    // var basenam = basename(_file.path);
    // saveFile(file, basenam.split(".")[1]);
  }

  Future<File> saveFile(String url, title) async {
    var file = await DefaultCacheManager()
        .getSingleFile(url); // File _file = File(file.path);
    File _file = File(file.path);
    var basenam = basename(_file.path);
    var ext = basenam.split(".")[1];
    final filePath =
        '${(await getExternalStorageDirectory()).path.replaceAll("Android/data/amoledwallpapers.foxywall/files", '')}refox/$title[refoxwall.com].$ext';
    print(filePath);
    return File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytes(file.readAsBytesSync());
  }

  Future checkPermission() async {
    Permission status = Permission.storage;
    if (await status.isUndetermined) {
      Fluttertoast.showToast(
          msg: "Please Allow Storage Permission For Set Wallpaper");
      status.request().then((value) {
        if (value.isDenied) {
          Fluttertoast.showToast(
              msg: "Please Allow Storage Permission For Set Wallpaper");
          status.request();
        } else if (value.isGranted) {
          Fluttertoast.showToast(msg: "Welcome To Refox Wallpaper App");
        }
      });
    } else if (await status.isDenied) {
      Fluttertoast.showToast(
          msg: "Please Allow Storage Permission For Set Wallpaper");
      status.request().then((value) {
        if (value.isDenied) {
          Fluttertoast.showToast(
              msg: "Please Allow Storage Permission For Set Wallpaper");
          status.request();
        } else if (value.isGranted) {
          Fluttertoast.showToast(msg: "Welcome To Refox Wallpaper App");
        }
      });
    } else if (await status.isPermanentlyDenied) {
      Fluttertoast.showToast(
          msg:
              "Go to Setting app manager and allow storage permission to access wallpapers");
      status.request().then((value) {
        if (value.isDenied) {
          Fluttertoast.showToast(
              msg: "Please Allow Storage Permission For Set Wallpaper");
          status.request();
        } else if (value.isGranted) {
          Fluttertoast.showToast(msg: "Welcome To Refox Wallpaper App");
        }
      });
    } else if (await status.isRestricted) {
      Fluttertoast.showToast(
          msg:
              "Go to Setting app manager and allow storage permission to access wallpapers");
      status.request().then((value) {
        if (value.isDenied) {
          Fluttertoast.showToast(
              msg: "Please Allow Storage Permission For Set Wallpaper");
          status.request();
        } else if (value.isGranted) {
          Fluttertoast.showToast(msg: "Welcome To Refox Wallpaper App");
        }
      });
    } else if (await status.isGranted) {
      // Fluttertoast.showToast(
      //   msg: "Welcome Back!",
      // );
    }
  }

  void createFolder() async {
    Directory baseDir = await getExternalStorageDirectory(); //only for Android
    // Directory baseDir = await getApplicationDocumentsDirectory(); //works for both iOS and Android
    String dirToBeCreated = "refox";
    String finalDir = join(
        baseDir.path
            .replaceAll("Android/data/amoledwallpapers.foxywall/files", ''),
        dirToBeCreated);
    var dir = Directory(finalDir);
    bool dirExists = await dir.exists();
    if (!dirExists) {
      dir.create(recursive: true
          /*recursive=true*/); //pass recursive as true if directory is recursive
    }
    //Now you can use this directory for saving file, etc.
    //In case you are using external storage, make sure you have storage permissio
  }
}
