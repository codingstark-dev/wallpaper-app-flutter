import 'dart:io' as io;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallpaper/helper/color.dart';
import 'package:extended_image/extended_image.dart';
import 'package:wallpaper/helper/list_s.dart';
import 'package:wallpaper/router/router.gr.dart';
import 'package:wallpaper/service/locator.dart';
import 'package:wallpaper/service/setwallpaper/wallpaperfun.dart';

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
    super.initState();
    filelist();
  }

  void filelist() async {
    directory =
        '${(await getExternalStorageDirectory()).path.replaceAll("Android/data/amoledwallpapers.foxywall/files", '')}refox';

    setState(() {
      List<io.FileSystemEntity> cc = io.Directory("$directory").listSync(
        recursive: true,
      );

      cc.forEach((e) {
        io.File _file = io.File(e.path);
        var basenam = basename(_file.path).trim();
        List ext = basenam.split(".");
        var i = (ext.length == 3) ? ext[2] : ext[3];
        if (i.contains('png') || i.contains('jpg') || i.contains('jpeg')) {
          // print(cc);
          return file.add(e);
        }
      });

      //use your folder name insted of resume.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkslategrayhs,
      drawer: Container(
          color: darkslategrayhs,
          width: 210,
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor:
                  darkslategrayhs, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
            ),
            child: Drawer(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 150,
                  ),
                  Expanded(
                      child: ListView(
                          children: sl
                              .get<ListCollection>()
                              .draw
                              .map((e) => Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        switch (e) {
                                          case "Home":
                                            Navigator.of(context).pop();
                                            break;
                                          case "Download":
                                            ExtendedNavigator.rootNavigator
                                                .pushNamed(Routes.downloadPage);
                                            break;
                                          case "Privacy Policy":
                                            Navigator.of(context).pop();
                                            break;
                                          case "Contact Us":
                                            Navigator.of(context).pop();
                                            break;

                                          default:
                                        }
                                      },
                                      child: ListTile(
                                        leading: Text("").iconchange(e),
                                        title: Text(
                                          e,
                                          style: TextStyle(
                                              color: gainsborohs,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList())),
                ],
              ),
            ),
          )),
      appBar: PreferredSize(
          child: Builder(
            builder: (BuildContext context) => AppBar(
                elevation: 0,
                backgroundColor: darkslategrayhs,
                centerTitle: true,
                automaticallyImplyLeading: false,
                actions: [
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/svg/iconsmenu3.png",
                        width: 30,
                        height: 35,
                      ),
                    ),
                  )
                ],
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    // borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      return Scaffold.of(context).openDrawer();
                    },
                    child: Image.asset(
                      "assets/svg/iconsmenu2.png",
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
                title: Text(
                  "ReFox WallPaper",
                  style: GoogleFonts.pacifico(color: gainsborohs),
                )),
          ),
          preferredSize: Size(50, 55)),
      body: SingleChildScrollView(
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Stack(
                            fit: StackFit.loose,
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                  color: Colors.white,
                                  height: 400,
                                  width: 250,
                                  child: ExtendedImage.file(
                                    io.File(file[index].path),
                                    fit: BoxFit.cover,
                                    enableLoadState: true,
                                  )),
                              Positioned(
                                  right: 10,
                                  bottom: 10,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: gainsborohs.withOpacity(0.6),
                                          border: Border.all(
                                              width: 1, color: gainsborohs)),
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: Material(
                                              color: Colors.transparent,
                                              child: IconButton(
                                                tooltip: "Delete Wallpaper",
                                                color: Colors.white,
                                                onPressed: () {
                                                  file[index]
                                                      .delete()
                                                      .whenComplete(() =>
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Wallpaper Deleted"));
                                                  setState(() {
                                                    file.removeAt(index);
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.delete_forever,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: Material(
                                              color: Colors.transparent,
                                              child: IconButton(
                                                tooltip: "Set Wallpaper",
                                                color: Colors.white,
                                                onPressed: () {
                                                  // Fluttertoast.showToast(
                                                  //     msg:
                                                  //         "Wait Wallpaper Applying");
                                                  sl
                                                      .get<WallpaperFun>()
                                                      .setwallpaperStorage(
                                                          file[index].path)
                                                      .whenComplete(() =>
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Wallpaper Applied"));
                                                },
                                                icon: Icon(
                                                  FontAwesomeIcons.paintRoller,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
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
      ),
    );
  }
}

extension Iconchanger on Widget {
  // ignore: missing_return
  iconchange(lol) {
    var list = sl.get<ListCollection>().list;
    switch (lol) {
      case "Home":
        return list[0];
        break;
      case "Download":
        return list[1];
        break;
      case "Privacy Policy":
        return list[2];
        break;
      case "Contact Us":
        return list[3];
        break;
      default:
    }
  }
}
