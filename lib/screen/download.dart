import 'dart:io' as io;

import 'package:auto_route/auto_route.dart';
import 'package:filesize/filesize.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/helper/color.dart';
import 'package:wallpaper/helper/list_s.dart';
import 'package:wallpaper/provider/firebasedata.dart';
import 'package:wallpaper/router/router.gr.dart';
import 'package:wallpaper/screen/wallpaperdetail.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:extended_image/extended_image.dart';
import 'package:wallpaper/service/locator.dart';

class DownloadPage extends StatefulWidget {
  DownloadPage({Key key}) : super(key: key);

  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  List<io.FileSystemEntity> file = [];
  String directory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filelist();
  }

  void filelist() async {
    directory =
        '${(await getExternalStorageDirectory()).path.replaceAll("Android/data/amoledwallpapers.foxywall/files", '')}refox';

    setState(() {
      file = io.Directory("$directory").listSync(
        recursive: true,
      );
      //use your folder name insted of resume.
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        color: darkslategrayhs,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.8,
                crossAxisSpacing: 2,
                mainAxisSpacing: 1),
            padding: EdgeInsets.all(10),
            scrollDirection: Axis.vertical,
            itemCount: file.length,
            // itemCount: amoledFirebase.wallpaper.preview.length
            // widget.dataSnapshot.value.length

            // itemCount: data.wallpaper.url.length,
            itemBuilder: (BuildContext context, int index) {
              // var date = new DateTime.fromMillisecondsSinceEpoch(double.parse(
              //             amoledFirebase.wallpaper.createdUtc[index].toString())
              //         .floor() *
              //     1000);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // print(lol);
                          // print(amoledFirebase.wallpaper.url[index]);
                          // crud("newwallpaper/", Delete(index));
                          // amoledFirebase..removeList(index);
                          // amoledFirebase.removeList(index);

                          // Navigator.push(
                          //     context,
                          //     CupertinoPageRoute(
                          //         builder: (BuildContext context) =>
                          //             ChangeNotifierProvider<AmoledFirebase>(
                          //               create: (context) => AmoledFirebase(),
                          //               child: WallpaperDetail(
                          //                 sizeofimage:
                          //                     "${amoledFirebase.wallpaper.imagewidth[index]} " +
                          //                         "x " +
                          //                         "${amoledFirebase.wallpaper.imageheight[index]}",
                          //                 author: amoledFirebase
                          //                     .wallpaper.author[index],
                          //                 ups: amoledFirebase.wallpaper.ups[index],
                          //                 url: amoledFirebase.wallpaper.url[index],
                          //                 index: index,
                          //                 title: amoledFirebase
                          //                     .wallpaper.title[index]
                          //                     .toString()
                          //                     .dbFilterTitle,
                          //               ),
                          //             )));
                          // // print(index);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Stack(
                            fit: StackFit.loose,
                            alignment: Alignment.bottomCenter,
                            children: [
                              Positioned.fill(
                                  child: Container(
                                      color: Colors.white,
                                      height: 400,
                                      width: 250,
                                      child: ExtendedImage.file(
                                        io.File(file[index].path),
                                        fit: BoxFit.cover,
                                        enableLoadState: true,
                                        loadStateChanged: (state) {
                                          print(state.extendedImageInfo);
                                        },
                                      ))),

                              //         //  Image.network(
                              //         //   amoledFirebase.wallpaper.preview[index],
                              //         //   fit: BoxFit.cover,
                              //         //   filterQuality: FilterQuality.low,
                              //         //   errorBuilder: (context, error, stackTrace) {
                              //         //     if (mounted) {
                              //         //       amoledFirebase.removeList(index);
                              //         //       return Center(
                              //         //           child: Text(
                              //         //               "😞 Sorry Author Removed Image"));
                              //         //     } else {
                              //         //       return null;
                              //         //     }
                              //         //   },
                              //         //   loadingBuilder:
                              //         //       (context, child, loadingProgress) {
                              //         //     if (loadingProgress == null) return child;
                              //         //     return SpinKitThreeBounce(
                              //         //       size: 14,
                              //         //       color: darkslategrayhs,
                              //         //     );
                              //         //     // return Center(
                              //         //     //   child: CircularProgressIndicator(
                              //         //     //     backgroundColor: darkslategrayhs,
                              //         //     //     value: loadingProgress
                              //         //     //                 .expectedTotalBytes !=
                              //         //     //             null
                              //         //     //         ? loadingProgress
                              //         //     //                 .cumulativeBytesLoaded /
                              //         //     //             loadingProgress
                              //         //     //                 .expectedTotalBytes
                              //         //     //         : null,
                              //         //     //   ),
                              //         //     // );
                              //         //   },
                              //         // )),

                              //         )),

                              // Positioned(
                              //   left: 10,
                              //   top: 10,
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(2.0),
                              //     child: Container(
                              //       decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(5),
                              //           color: gainsborohs.withOpacity(0.6),
                              //           border: Border.all(
                              //               width: 1, color: gainsborohs)),
                              //       child: Padding(
                              //         padding: const EdgeInsets.all(3.0),
                              //         child: Text(
                              //             "${amoledFirebase.wallpaper.imagewidth[index]} " +
                              //                 "x " +
                              //                 "${amoledFirebase.wallpaper.imageheight[index]}",
                              //             textAlign: TextAlign.left,
                              //             style: TextStyle(
                              //                 fontSize: 9,
                              //                 fontWeight: FontWeight.bold,
                              //                 color: Colors.white)),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Positioned(
                                bottom: 40,
                                left: 5,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Padding(
                                    //   padding: const EdgeInsets.all(2.0),
                                    //   child: Container(
                                    //     decoration: BoxDecoration(
                                    //         borderRadius: BorderRadius.circular(5),
                                    //         color: gainsborohs.withOpacity(0.6),
                                    //         border: Border.all(
                                    //             width: 1, color: gainsborohs)),
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.all(3.0),
                                    //       child: Text(
                                    //           "${amoledFirebase.wallpaper.imagewidth[index]} " +
                                    //               "x " +
                                    //               "${amoledFirebase.wallpaper.imageheight[index]}",
                                    //           textAlign: TextAlign.left,
                                    //           style: TextStyle(
                                    //               fontSize: 9,
                                    //               fontWeight: FontWeight.bold,
                                    //               color: Colors.white)),
                                    //     ),
                                    //   ),
                                    // ),

                                    // Container(
                                    //     padding: EdgeInsets.all(3),
                                    //     decoration: BoxDecoration(
                                    //         borderRadius: BorderRadius.circular(5),
                                    //         color: gainsborohs.withOpacity(0.6),
                                    //         border: Border.all(
                                    //             width: 1, color: gainsborohs)),
                                    //     child: Text(
                                    //         filesize(amoledFirebase
                                    //             .wallpaper.imagebytes[index]
                                    //             .toString()),
                                    //         textAlign: TextAlign.left,
                                    //         style: TextStyle(
                                    //             fontSize: 10,
                                    //             fontWeight: FontWeight.bold,
                                    //             color: Colors.white))),

                                    SizedBox(
                                      width: 6,
                                    ),
                                    // Container(
                                    //   // margin: EdgeInsets.all(15),
                                    //   padding: EdgeInsets.all(3),
                                    //   decoration: BoxDecoration(
                                    //     color: gainsborohs.withOpacity(0.6),
                                    //     border: Border.all(
                                    //         width: 1, color: gainsborohs),
                                    //     borderRadius: BorderRadius.circular(5),
                                    //   ),
                                    //   child: Row(
                                    //     crossAxisAlignment:
                                    //         CrossAxisAlignment.center,
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.start,
                                    //     children: <Widget>[
                                    //       Icon(
                                    //         FontAwesomeIcons.thumbsUp,
                                    //         size: 10,
                                    //         color: Colors.white,
                                    //       ),
                                    //       SizedBox(
                                    //         width: 5,
                                    //       ),
                                    //       // Text(
                                    //       //   amoledFirebase.wallpaper.ups[index]
                                    //       //       .toString(),
                                    //       //   textAlign: TextAlign.center,
                                    //       //   style: TextStyle(
                                    //       //     color: Colors.white,
                                    //       //     fontSize: 10,
                                    //       //     fontWeight: FontWeight.bold,
                                    //       //   ),
                                    //       // ),
                                    //     ],
                                    //   ),
                                    // ),
                                  
                                  ],
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  height: 33,
                                  width: 200,
                                  // color: gainsborohs,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        // Expanded(
                                        //   child: Text(
                                        //     amoledFirebase.wallpaper.title[index]
                                        //         .toString()
                                        //         .dbFilterTitle,
                                        //     style: TextStyle(
                                        //         fontSize: 14,
                                        //         fontWeight: FontWeight.w400),
                                        //     overflow: TextOverflow.clip,
                                        //     textAlign: TextAlign.center,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                         
                              // Positioned(
                              //   top: 215,
                              //   left: 110,
                              //   child: Container(
                              //     // margin: EdgeInsets.all(15),
                              //     padding: EdgeInsets.all(3),
                              //     decoration: BoxDecoration(
                              //       color: gainsborohs.withOpacity(0.6),
                              //       border:
                              //           Border.all(width: 1, color: gainsborohs),
                              //       borderRadius: BorderRadius.circular(5),
                              //     ),
                              //     child: Row(
                              //       crossAxisAlignment: CrossAxisAlignment.center,
                              //       mainAxisAlignment: MainAxisAlignment.start,
                              //       children: <Widget>[
                              //         Icon(
                              //           FontAwesomeIcons.arrowUp,
                              //           size: 10,
                              //           color: Colors.white,
                              //         ),
                              //         SizedBox(
                              //           width: 5,
                              //         ),
                              //         Text(
                              //           amoledFirebase.wallpaper.ups[index]
                              //               .toString(),
                              //           textAlign: TextAlign.center,
                              //           style: TextStyle(
                              //             color: Colors.white,
                              //             fontSize: 10,
                              //             fontWeight: FontWeight.bold,
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // Positioned(
                              //     top: 215,
                              //     left: 75,
                              //     child: Container(
                              //         padding: EdgeInsets.all(3),
                              //         decoration: BoxDecoration(
                              //             borderRadius: BorderRadius.circular(5),
                              //             color: gainsborohs.withOpacity(0.6),
                              //             border: Border.all(
                              //                 width: 1, color: gainsborohs)),
                              //         child: Text(
                              //             filesize(amoledFirebase
                              //                 .wallpaper.imagebytes[index]
                              //                 .toString()),
                              //             textAlign: TextAlign.left,
                              //             style: TextStyle(
                              //                 fontSize: 10,
                              //                 fontWeight: FontWeight.bold,
                              //                 color: Colors.white)))),
                              // Positioned(
                              //   top: 215,
                              //   right: 100,
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(5),
                              //         color: gainsborohs.withOpacity(0.6),
                              //         border:
                              //             Border.all(width: 1, color: gainsborohs)),
                              //     child: Padding(
                              //       padding: const EdgeInsets.all(3.0),
                              //       child: Text(
                              //           "${amoledFirebase.wallpaper.imagewidth[index]} " +
                              //               "x " +
                              //               "${amoledFirebase.wallpaper.imageheight[index]}",
                              //           textAlign: TextAlign.left,
                              //           style: TextStyle(
                              //               fontSize: 10,
                              //               fontWeight: FontWeight.bold,
                              //               color: Colors.white)),
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: <Widget>[
                        // Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Text(
                        //     "By ${amoledFirebase.wallpaper.author[index]}",
                        //     style: TextStyle(
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.w400,
                        //         color: gainsborohs),
                        //     overflow: TextOverflow.clip,
                        //   ),
                        // ),
                        // Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Text(
                        //     timeago.format(date),
                        //     style: TextStyle(
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.w400,
                        //         color: gainsborohs),
                        //     overflow: TextOverflow.clip,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
