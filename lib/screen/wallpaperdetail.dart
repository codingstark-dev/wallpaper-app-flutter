import 'dart:async';
import 'dart:ui';
import 'package:extended_image/extended_image.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/helper/color.dart';
import 'package:wallpaper/provider/firebasedata.dart';
import 'package:wallpaper/service/locator.dart';
import 'package:wallpaper/service/setwallpaper/wallpaperfun.dart';

class WallpaperDetail extends StatefulWidget {
  WallpaperDetail(
      {Key key,
      @required this.index,
      @required this.url,
      @required this.title,
      @required this.author,
      @required this.ups,
      @required this.sizeofimage,
      @required this.date,
      @required this.imagebytes,
      @required this.imageextenstion})
      : super(key: key);

  final String author;
  final String date;
  final String imagebytes;
  final String imageextenstion;
  final int index;
  final String sizeofimage;
  final String title;
  final int ups;
  final String url;

  @override
  _WallpaperDetailState createState() => _WallpaperDetailState();
}

class _WallpaperDetailState extends State<WallpaperDetail> {
  bool detailbox = true;
  bool loadingBool = false;
  bool status = false;
  StreamController streamController = StreamController();

  @override
  void dispose() {
    super.dispose();

    streamController.close();

    // sl.get<AmoledFirebase>().updateboxstatus(false);
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      streamController.stream.listen((event) async {
        if (event == LoadState.loading) {
          setState(() {
            sl.get<AmoledFirebase>().updateboxstatus(false);
          });
        } else if (event == LoadState.completed) {
          setState(() {
            sl.get<AmoledFirebase>().updateboxstatus(true);
          });
        } else if (event == LoadState.failed) {
          setState(() {
            sl.get<AmoledFirebase>().updateboxstatus(false);
          });
        }
      });
      setState(() {
        // streamController.stream.listen((event) async {
        //   if (event == LoadState.loading) {
        //     sl.get<AmoledFirebase>().updateboxstatus(false);
        //   } else if (event == LoadState.completed) {
        //     setState(() {
        //       sl.get<AmoledFirebase>().updateboxstatus(true);
        //     });
        //   } else if (event == LoadState.failed) {
        //     sl.get<AmoledFirebase>().updateboxstatus(false);
        //   }
        // });

        changeStatusBar();
        status = false;
        // detailbox = true;
      });
      sl.get<WallpaperFun>().createFolder();
    } else
      return null;
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   setState(() {
  //     if (event == LoadState.loading) {
  //       sl.get<AmoledFirebase>().updateboxstatus(false);
  //     } else if (sl.get<AmoledFirebase>().loadingval == LoadState.completed) {
  //       sl.get<AmoledFirebase>().updateboxstatus(true);
  //     } else if (sl.get<AmoledFirebase>().loadingval == LoadState.failed) {
  //       sl.get<AmoledFirebase>().updateboxstatus(false);
  //     }
  //   });
  //   sl.get<AmoledFirebase>().notifyListeners();
  // }

  void changeStatusBar() {
    if (status) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    } else {
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    }
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
    // setState(() {
    //   if (sl.get<AmoledFirebase>().loadingval == LoadState.loading) {
    //     sl.get<AmoledFirebase>().updateboxstatus(false);
    //   } else if (sl.get<AmoledFirebase>().loadingval == LoadState.completed) {
    //     sl.get<AmoledFirebase>().updateboxstatus(true);
    //   } else if (sl.get<AmoledFirebase>().loadingval == LoadState.failed) {
    //     sl.get<AmoledFirebase>().updateboxstatus(false);
    //   }
    // });

    var screensize = MediaQuery.of(context).size;

    // void _showModalSheet() {
    //   showModalBottomSheet(
    //       backgroundColor: Colors.transparent,
    //       context: context,
    //       builder: (builder) {
    //         return Container(
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(15),
    //                 topRight: Radius.circular(15)),
    //           ),
    //           child: Text('Hello From Modal Bottom Sheet'),
    //           padding: EdgeInsets.all(40.0),
    //         );
    //       });
    // }

    return (loadingBool == true)
        ? Material(
            color: darkslategrayhs,
            child: Center(
                child: Text(
              "Be Patient Wallpaper Applying...",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: gainsborohs),
            )))
        : Material(
            color: darkslategrayhs,
            child: Container(
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
                        child: ExtendedImage.network(widget.url,
                            headers: {
                              "User-Agent":
                                  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36"
                            },
                            filterQuality: FilterQuality.high,
                            retries: 30,timeLimit: Duration(seconds: 30),
                            enableSlideOutPage: true,
                            // enableMemoryCache: true,
                            handleLoadingProgress: true,
                            cache: false,
                            fit: BoxFit.cover,
                            enableLoadState: true, loadStateChanged: (state) {
                          streamController.add(state.extendedImageLoadState);
                          // print(state.extendedImageLoadState);
                          // print(
                          //     state.extendedImageLoadState == LoadState.completed);
                          if (state.extendedImageLoadState ==
                              LoadState.failed) {
                            return Center(
                              child: Container(
                                  child: Text(
                                "Failed To Load Image, Check Your Internet Connection",
                                style: TextStyle(color: gainsborohs,fontWeight: FontWeight.bold,)
                              )),
                            );
                          } else {
                            if (state.loadingProgress?.expectedTotalBytes ==
                                null) return null;

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
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
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
                          }
                        }),
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
                        PositionedDirectional(
                          bottom: 30,
                          child: SafeArea(
                            bottom: true,
                            child: Visibility(
                              visible: !status,
                              child: Center(
                                child: Container(
                                  height: 140,
                                  width: screensize.width * 0.90,
                                  // padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: gainsborohs.withOpacity(0.4),
                                    // border: Border.all(width: 1, color: gainsborohs)
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 8,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      15.0, 15, 0, 5),
                                              child: Text(
                                                widget.title,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 3, 0, 5),
                                              child: SizedBox(
                                                  height: 45,
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: IconButton(
                                                      tooltip: "Save Wallpaper",
                                                      enableFeedback: true,
                                                      iconSize: 25,
                                                      color: Colors.white,
                                                      onPressed: () async {
                                                        await sl
                                                            .get<WallpaperFun>()
                                                            .checkPermission();

                                                        await sl
                                                            .get<WallpaperFun>()
                                                            .saveFile(
                                                                widget.url,
                                                                widget.title)
                                                            .whenComplete(() =>
                                                                Fluttertoast
                                                                    .showToast(
                                                                        msg:
                                                                            "Downloaded, Check Your Gallery."))
                                                            .catchError(
                                                                (onError) {
                                                          return Fluttertoast
                                                              .showToast(
                                                                  msg:
                                                                      "Something Went Wrong $onError");
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons.file_download,
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 3, 0, 5),
                                              child: SizedBox(
                                                  height: 45,
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: IconButton(
                                                      tooltip: "Set Wallpaper",
                                                      enableFeedback: true,
                                                      iconSize: 25,
                                                      color: Colors.white,
                                                      onPressed: () async {
                                                        setState(() {
                                                          loadingBool = true;
                                                        });
                                                        await Fluttertoast
                                                            .showToast(
                                                                msg:
                                                                    "Please Wait Wallpaper Applying");

                                                        await sl
                                                            .get<WallpaperFun>()
                                                            .setwallpaper(
                                                                widget.url)
                                                            .whenComplete(
                                                                () async {
                                                          setState(() {
                                                            loadingBool = false;
                                                          });
                                                          await Fluttertoast
                                                              .showToast(
                                                                  msg:
                                                                      "Wallpaper Applied");
                                                        }).catchError((onError) =>
                                                                Fluttertoast
                                                                    .showToast(
                                                                        msg:
                                                                            "Something Went Wrong $onError"));
                                                      },
                                                      icon: Icon(
                                                        FontAwesomeIcons
                                                            .paintRoller,
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10.0, 0, 0, 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    // height: 20,
                                                    // width: 100,
                                                    padding: EdgeInsets.all(2),
                                                    // margin: EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: gainsborohs
                                                            .withOpacity(0.4),
                                                        border: Border.all(
                                                            width: 1,
                                                            color:
                                                                gainsborohs)),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .fileImage,
                                                          size: 16,
                                                          color: Colors.white,
                                                        ),
                                                        Text(
                                                          widget.sizeofimage,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  "By ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Container(
                                                  // height: 20,
                                                  // width: 100,
                                                  padding: EdgeInsets.all(2),
                                                  // margin: EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: gainsborohs
                                                          .withOpacity(0.4),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: gainsborohs)),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .userCircle,
                                                        size: 16,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                        widget.author,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5.0, 7, 5, 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Icon(
                                                    FontAwesomeIcons.thumbsUp,
                                                    size: 15,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    widget.ups.toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // height: 20,
                                              // width: 100,
                                              padding: EdgeInsets.all(2),
                                              // margin: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: gainsborohs
                                                      .withOpacity(0.4),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: gainsborohs)),
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    FontAwesomeIcons
                                                        .fileArchive,
                                                    size: 14,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    widget.imagebytes,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // height: 20,
                                              // width: 100,
                                              padding: EdgeInsets.all(2),
                                              // margin: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: gainsborohs
                                                      .withOpacity(0.4),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: gainsborohs)),
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    FontAwesomeIcons.fileAlt,
                                                    size: 14,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    "." +
                                                        widget.imageextenstion
                                                            .toUpperCase(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // height: 20,
                                              // width: 100,
                                              padding: EdgeInsets.all(2),
                                              // margin: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: gainsborohs
                                                      .withOpacity(0.4),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: gainsborohs)),
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    FontAwesomeIcons.history,
                                                    size: 14,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    widget.date,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      // // Positioned(
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
