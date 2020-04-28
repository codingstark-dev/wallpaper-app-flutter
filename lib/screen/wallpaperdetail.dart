import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/helper/color.dart';
import 'package:wallpaper/provider/firebasedata.dart';
import 'dart:io' as io;
import 'package:wallpaper_manager/wallpaper_manager.dart';

class WallpaperDetail extends StatefulWidget {
  WallpaperDetail({Key key, this.index, this.url, this.title})
      : super(key: key);
  final int index;
  final String url;
  final String title;
  @override
  _WallpaperDetailState createState() => _WallpaperDetailState();
}

class _WallpaperDetailState extends State<WallpaperDetail> {
  bool status = false;
  void changeStatusBar() {
    if (status) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    } else {
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    }
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        changeStatusBar();
        status = false;
      });
    } else
      return null;
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

  Future setwallpaper() async {
    dynamic result;
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String result2;
    var file = await DefaultCacheManager().getSingleFile(widget.url);
    // Platform messages may fail, so we use a try/catch PlatformException.
    result = await WallpaperManager.setWallpaperFromFile(
        file.path, WallpaperManager.HOME_SCREEN);
    result2 = await WallpaperManager.setWallpaperFromFile(
        file.path, WallpaperManager.LOCK_SCREEN);
    // print(file.path);
    // result = await Dio().download(file.path, "Download/");
    File _file = File(file.path);
    var basenam = basename(_file.path);
    saveFile(file, basenam.split(".")[1]);
  }

  Future<File> saveFile(File toBeSaved, ext) async {
    final filePath =
        '${(await getExternalStorageDirectory()).path.replaceAll("Android/data/amoledwallpapers.foxywall/files", '')}/refox/${widget.title}[refoxwall.com].$ext';
    print(filePath);
    return File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytes(toBeSaved.readAsBytesSync());
  }

  @override
  Widget build(BuildContext context) {
// SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//   statusBarColor: Colors.transparent,
// ));
    if (!mounted) return null;
    return ChangeNotifierProvider<AmoledFirebase>(
      create: (context) => AmoledFirebase(),
      child: Material(
        color: darkslategrayhs,
        child: Container(
          child: FittedBox(
            child: InkWell(onTap: () {
              // SystemChrome.setEnabledSystemUIOverlays(
              //     [SystemUiOverlay.bottom]);
              // createFolder();
              // setwallpaper();
              if (mounted) {
                setState(() {
                  status = !status;
                  changeStatusBar();
                  print(status);
                });
              } else
                return null;
            }, child: Consumer<AmoledFirebase>(
              builder: (BuildContext context, value, Widget child) {
                if (!mounted) return null;
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    TransitionToImage(
                      // loadFailedCallback: () {
                      //   print("error");
                      // },
                      // loadedCallback: () {
                      //   if (mounted) {
                      //     status = false;
                      //     changeStatusBar();
                      //   }
                      // },

                      image: AdvancedNetworkImage(
                        widget.url,
                        loadedCallback: () {
                          if (mounted) {
                            setState(() {});
                            status = false;
                            changeStatusBar();
                          }
                        },
                        // loadingProgress: (progress, data) {
                        //   if (progress == null) return child;
                        //   // print(progress * 100);
                        //   // print(filesize(loadingProgress.expectedTotalBytes));
                        //   print(filesize(data.buffer.asByteData().lengthInBytes));
                        //   print(widget.data);
                        //   return Text(
                        //     "data",
                        //     style: TextStyle(fontSize: 30),
                        //   );
                        //   // return Center(
                        //   //   child: Column(
                        //   //     children: <Widget>[
                        //   //       CircularProgressIndicator(
                        //   //         valueColor:
                        //   //             AlwaysStoppedAnimation<Color>(gainsborohs),
                        //   //         backgroundColor: darkslategrayhs,
                        //   //         value: progress * 100,
                        //   //       ),
                        //   //       SizedBox(
                        //   //         height: 12,
                        //   //       ),
                        //   //       Text(
                        //   //         "⚠️ Alert ! Loading Image size is ${filesize(progress)}",
                        //   //         style: TextStyle(
                        //   //             color: gainsborohs,
                        //   //             fontSize: 10,
                        //   //             fontWeight: FontWeight.bold),
                        //   //       )
                        //   //     ],
                        //   //   ),
                        //   // );
                        // },
                      ),
                      enableRefresh: true,
                      transitionType: TransitionType.fade,
                      loadingWidgetBuilder: (
                        BuildContext context,
                        double progress,
                        Uint8List imageData,
                      ) {
                        // print(filesize(imageData.lengthInBytes ?? 0));
                        return Padding(
                          padding: const EdgeInsets.all(150.0),
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          gainsborohs),
                                      backgroundColor: darkslategrayhs,
                                      value: (imageData != null) ? progress : 0,
                                    ),
                                    SizedBox(
                                      height: 10,
                                      width: 30,
                                      child: Text(
                                        filesize((imageData != null)
                                            ? imageData.lengthInBytes
                                            : 0),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: gainsborohs,
                                            fontSize: 5,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                                // SizedBox(
                                //   height: 12,
                                // ),
                                // Text(
                                //   "⚠️ Alert ! Loading Image size is ${filesize((imageData != null) ? imageData.buffer.asByteData().lengthInBytes : 0)}",
                                //   style: TextStyle(
                                //       color: gainsborohs,
                                //       fontSize: 10,
                                //       fontWeight: FontWeight.bold),
                                // )
                              ],
                            ),
                          ),
                        );
                      },
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      height: 550, width: 1000,
                      top: 1600,
                      // left: 0,
                      child: Visibility(
                        maintainState: true,
                        visible: !status,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: gainsborohs.withOpacity(0.4),
                            // border: Border.all(width: 1, color: gainsborohs)
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    "1802 x 1283",
                                    style: TextStyle(
                                        color: gainsborohs, fontSize: 40),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        width: 400,
                        height: 400,
                        top: 1600,
                        child: FloatingActionButton(
                          onPressed: () {},
                        )),
                  ],
                );
                // return Image.network(
                //   widget.data,
                //   fit: BoxFit.cover,
                //   filterQuality: FilterQuality.high,
                //   errorBuilder: (context, error, stackTrace) {
                //     // value.removeList(widget.index);
                //     if (!mounted) return Text("data");
                //     if (mounted) {
                //       return Padding(
                //         padding: const EdgeInsets.all(200.0),
                //          child: Center(
                //           child: Text(
                //             "😞 Sorry Image Not Available",
                //             style: TextStyle(color: gainsborohs),
                //           ),
                //         ),
                //       );
                //     } else
                //       return null;
                //   },
                //   loadingBuilder: (context, child, loadingProgress) {
                //     if (!mounted) return Text("data");
                //     if (mounted) {
                //       if (loadingProgress == null) return child;
                //       // print(filesize(loadingProgress.expectedTotalBytes));
                //       return Center(
                //         child: Padding(
                //           padding: const EdgeInsets.all(200.0),
                //           child: Column(
                //             children: <Widget>[
                //               CircularProgressIndicator(
                //                 valueColor:
                //                     AlwaysStoppedAnimation<Color>(gainsborohs),
                //                 backgroundColor: darkslategrayhs,
                //                 value: loadingProgress.expectedTotalBytes !=
                //                         null
                //                     ? loadingProgress.cumulativeBytesLoaded /
                //                         loadingProgress.expectedTotalBytes
                //                     : null,
                //               ),
                //               SizedBox(
                //                 height: 12,
                //               ),
                //               Text(
                //                 "⚠️ Alert ! Loading Image size is ${filesize(loadingProgress.expectedTotalBytes)}",
                //                 style: TextStyle(
                //                     color: gainsborohs,
                //                     fontSize: 10,
                //                     fontWeight: FontWeight.bold),
                //               )
                //             ],
                //           ),
                //         ),
                //       );
                //     } else
                //       return null;
                //   },
                // );
              },
            )),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
