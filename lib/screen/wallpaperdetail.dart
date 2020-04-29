import 'dart:io';
import 'dart:ui';
import 'package:extended_image/extended_image.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/helper/color.dart';
import 'package:wallpaper/provider/firebasedata.dart';
import 'package:wallpaper/service/locator.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class WallpaperDetail extends StatefulWidget {
  WallpaperDetail({Key key, this.index, this.url, this.title})
      : super(key: key);

  final int index;
  final String title;
  final String url;

  @override
  _WallpaperDetailState createState() => _WallpaperDetailState();
}

class _WallpaperDetailState extends State<WallpaperDetail> {
  bool detailbox = true;
  bool status = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        // if (sl.call<AmoledFirebase>().loadingval.floor() == 100 ||
        //     sl.call<AmoledFirebase>().loadingval.floor() == 99 ||
        //     sl.call<AmoledFirebase>().loadingval.floor() == 98) {
        //   sl.get<AmoledFirebase>().updateboxstatus(true);
        //   if (sl.call<AmoledFirebase>().loadingval.floor() == 100) {
        //     sl.get<AmoledFirebase>().updateboxstatus(true);
        //   } else {
        //     sl.get<AmoledFirebase>().updateboxstatus(false);
        //   }
        // }

        sl.get<AmoledFirebase>().updateboxstatus(true);
        changeStatusBar();
        status = false;
        // detailbox = true;
      });
    } else
      return null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    sl.get<AmoledFirebase>().updateboxstatus(false);
    // sl.get<AmoledFirebase>().updateloadingval(0);
  }

  void changeStatusBar() {
    if (status) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    } else {
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
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
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   systemNavigationBarColor: gainsborohs.withOpacity(0.2),
    //   systemNavigationBarIconBrightness: Brightness.light,
    // ));
    AmoledFirebase amoled = Provider.of<AmoledFirebase>(context, listen: true);
    if (!mounted) return null;

   
      print(sl.get<AmoledFirebase>().loadingval.toString());
  

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: InkWell(
            onTap: () {
              // SystemChrome.setEnabledSystemUIOverlays(
              //     [SystemUiOverlay.bottom]);
              // createFolder();
              // setwallpaper();
              if (mounted) {
                setState(() {
                  amoled.updateboxstatus(false);
                  status = !status;
                  changeStatusBar();
                  print(amoled.status);
                });
              } else
                return null;
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned.fill(
                    child: Material(
                  color: darkslategrayhs,
                  child: ExtendedImage.network(
                    widget.url,
                    filterQuality: FilterQuality.high,
                    handleLoadingProgress: true,
                    fit: BoxFit.cover,
                    enableLoadState: true,
                    loadStateChanged: (state) {
                      switch (state.extendedImageLoadState) {
                        case LoadState.loading:
                          amoled.updateloadingval(LoadState.loading.toString());
                          break;
                        case LoadState.completed:
                          amoled.updateloadingval(LoadState.completed.toString());
                          break;
                        case LoadState.failed:
                          amoled.updateloadingval(LoadState.failed.toString());
                          break;
                        default:
                      }

                      // print(
                      //     state.extendedImageLoadState == LoadState.completed);
                      if (state.loadingProgress?.expectedTotalBytes == null)
                        return null;

                      return Center(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 75,
                                    width: 75,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          gainsborohs),
                                      backgroundColor: darkslategrayhs,
                                      value: state.loadingProgress
                                                  ?.expectedTotalBytes !=
                                              null
                                          ? state.loadingProgress
                                                  .cumulativeBytesLoaded /
                                              state?.loadingProgress
                                                  ?.expectedTotalBytes
                                          : null,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      filesize((state.loadingProgress
                                                  .cumulativeBytesLoaded !=
                                              null)
                                          ? state.loadingProgress
                                              .cumulativeBytesLoaded
                                          : 0),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: gainsborohs,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ))

                // Positioned.fill(
                //   child: TransitionToImage(
                //     // loadFailedCallback: () {
                //     //   print("error");
                //     // },
                //     // loadedCallback: () {
                //     //   if (mounted) {
                //     //     status = false;
                //     //     changeStatusBar();
                //     //   }
                //     // },

                //     image: AdvancedNetworkImage(
                //       widget.url,

                //       loadedCallback: () async {
                //         if (mounted) {
                //           await Future.delayed(Duration(seconds: 1))
                //               .whenComplete(() => detailbox = true);
                //           setState(() {
                //             sl.get<AmoledFirebase>().updateboxstatus(true);
                //             status = false;
                //             detailbox = false;
                //             changeStatusBar();
                //           });
                //         }
                //       },
                //       // loadingProgress: (progress, data) {
                //       //   if (progress == null) return child;
                //       //   // print(progress * 100);
                //       //   // print(filesize(loadingProgress.expectedTotalBytes));
                //       //   print(filesize(data.buffer.asByteData().lengthInBytes));
                //       //   print(widget.data);
                //       //   return Text(
                //       //     "data",
                //       //     style: TextStyle(fontSize: 30),
                //       //   );
                //       //   // return Center(
                //       //   //   child: Column(
                //       //   //     children: <Widget>[
                //       //   //       CircularProgressIndicator(
                //       //   //         valueColor:
                //       //   //             AlwaysStoppedAnimation<Color>(gainsborohs),
                //       //   //         backgroundColor: darkslategrayhs,
                //       //   //         value: progress * 100,
                //       //   //       ),
                //       //   //       SizedBox(
                //       //   //         height: 12,
                //       //   //       ),
                //       //   //       Text(
                //       //   //         "⚠️ Alert ! Loading Image size is ${filesize(progress)}",
                //       //   //         style: TextStyle(
                //       //   //             color: gainsborohs,
                //       //   //             fontSize: 10,
                //       //   //             fontWeight: FontWeight.bold),
                //       //   //       )
                //       //   //     ],
                //       //   //   ),
                //       //   // );
                //       // },
                //     ),
                //     enableRefresh: true,
                //     transitionType: TransitionType.slide,
                //     loadingWidgetBuilder: (
                //       BuildContext context,
                //       double progress,
                //       Uint8List imageData,
                //     ) {
                //       sl.get<AmoledFirebase>().updateboxstatus(false);

                //       // add your code here.

                //       sl.get<AmoledFirebase>().updateloadingval(progress * 100);

                //       // print(filesize(imageData.lengthInBytes ?? 0));
                //       // print(progress * 100);
                //       return Material(
                //         color: darkslategrayhs,
                //         child: Container(
                //           width: 1000,
                //           child: Center(
                //             child: Column(
                //               mainAxisSize: MainAxisSize.max,
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: <Widget>[
                //                 Expanded(
                //                   flex: 10,
                //                   child: Stack(
                //                     alignment: Alignment.center,
                //                     children: [
                //                       Container(
                //                         height: 75,
                //                         width: 75,
                //                         child: CircularProgressIndicator(
                //                           valueColor:
                //                               AlwaysStoppedAnimation<Color>(
                //                                   gainsborohs),
                //                           backgroundColor: darkslategrayhs,
                //                           value: (imageData != null)
                //                               ? progress
                //                               : 0,
                //                         ),
                //                       ),
                //                       Container(
                //                         child: Text(
                //                           filesize((imageData != null)
                //                               ? imageData.lengthInBytes
                //                               : 0),
                //                           textAlign: TextAlign.center,
                //                           style: TextStyle(
                //                               color: gainsborohs,
                //                               fontSize: 12,
                //                               fontWeight: FontWeight.bold),
                //                         ),
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //                 // SizedBox(
                //                 //   height: 12,
                //                 // ),
                //                 // Text(
                //                 //   "⚠️ Alert ! Loading Image size is ${filesize((imageData != null) ? imageData.buffer.asByteData().lengthInBytes : 0)}",
                //                 //   style: TextStyle(
                //                 //       color: gainsborohs,
                //                 //       fontSize: 10,
                //                 //       fontWeight: FontWeight.bold),
                //                 // )
                //               ],
                //             ),
                //           ),
                //         ),
                //       );
                //     },
                //     fit: BoxFit.cover,
                //   ),
                // ),

                ,
                if (sl.call<AmoledFirebase>().status == false)
                  SizedBox(
                    height: 0,
                    width: 0,
                  )
                else if (sl.call<AmoledFirebase>().status == true)
                  Positioned(
                    top: 520,
                    child: Visibility(
                      visible: !status,
                      child: Center(
                        child: Container(
                          height: 200,
                          width: 350,
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
                                        color: gainsborohs, fontSize: 15),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  SizedBox(
                                    height: 30,
                                    child: RaisedButton.icon(
                                      icon: Icon(Icons.ac_unit),
                                      label: Text("data"),
                                      onPressed: () {},
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    child: RaisedButton.icon(
                                      icon: Icon(Icons.ac_unit),
                                      label: Text("data"),
                                      onPressed: () {},
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    child: RaisedButton.icon(
                                      icon: Icon(Icons.ac_unit),
                                      label: Text("data"),
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                // Positioned(
                //     width: 400,
                //     height: 400,
                //     top: 560,
                //     child: FloatingActionButton(
                //       onPressed: () {},
                //     )),
              ],
            )
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

            ),
      ),
    );
  }
}
