import 'package:auto_route/auto_route.dart';
import 'package:filesize/filesize.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:wallpaper/helper/color.dart';
import 'package:wallpaper/provider/firebasedata.dart';
import 'package:wallpaper/router/router.gr.dart';
import 'package:wallpaper/screen/wallpaperdetail.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:extended_image/extended_image.dart';

class WallpaperList extends StatefulWidget {
  const WallpaperList({
    Key key,
    @required this.dataSnapshot,
  }) : super(key: key);

  final DataSnapshot dataSnapshot;

  @override
  _WallpaperListState createState() => _WallpaperListState();
}

class _WallpaperListState extends State<WallpaperList> {
  @override
  Widget build(BuildContext context) {
    AmoledFirebase amoledFirebase = Provider.of<AmoledFirebase>(context);

    return SizedBox(
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
        itemCount: amoledFirebase.wallpaper.preview.length
        // widget.dataSnapshot.value.length
        ,
        // itemCount: data.wallpaper.url.length,
        itemBuilder: (BuildContext context, int index) {
          var date = new DateTime.fromMillisecondsSinceEpoch(double.parse(
                      amoledFirebase.wallpaper.createdUtc[index].toString())
                  .floor() *
              1000);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      List lol = amoledFirebase.wallpaper.url[index]
                          .toString()
                          .split(".");
                      // print(lol);
                      // print(amoledFirebase.wallpaper.url[index]);
                      // crud("newwallpaper/", Delete(index));
                      // amoledFirebase..removeList(index);
                      // amoledFirebase.removeList(index);
                      ExtendedNavigator.rootNavigator.pushNamed(
                          Routes.wallpaperDetail,
                          arguments: WallpaperDetailArguments(
                              imageextenstion: lol[3],
                              imagebytes: filesize(amoledFirebase
                                  .wallpaper.imagebytes[index]
                                  .toString()),
                              index: index,
                              url: amoledFirebase.wallpaper.url[index],
                              title: amoledFirebase.wallpaper.title[index]
                                  .toString()
                                  .dbFilterTitle,
                              author: amoledFirebase.wallpaper.author[index],
                              ups: amoledFirebase.wallpaper.ups[index],
                              date: timeago.format(date).toString(),
                              sizeofimage:
                                  "${amoledFirebase.wallpaper.imagewidth[index]} " +
                                      "x " +
                                      "${amoledFirebase.wallpaper.imageheight[index]}"));

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
                                  child: ExtendedImage.network(
                                    amoledFirebase.wallpaper.preview[index],
                                    fit: BoxFit.cover,
                                  )

                                  //  Image.network(
                                  //   amoledFirebase.wallpaper.preview[index],
                                  //   fit: BoxFit.cover,
                                  //   filterQuality: FilterQuality.low,
                                  //   errorBuilder: (context, error, stackTrace) {
                                  //     if (mounted) {
                                  //       amoledFirebase.removeList(index);
                                  //       return Center(
                                  //           child: Text(
                                  //               "😞 Sorry Author Removed Image"));
                                  //     } else {
                                  //       return null;
                                  //     }
                                  //   },
                                  //   loadingBuilder:
                                  //       (context, child, loadingProgress) {
                                  //     if (loadingProgress == null) return child;
                                  //     return SpinKitThreeBounce(
                                  //       size: 14,
                                  //       color: darkslategrayhs,
                                  //     );
                                  //     // return Center(
                                  //     //   child: CircularProgressIndicator(
                                  //     //     backgroundColor: darkslategrayhs,
                                  //     //     value: loadingProgress
                                  //     //                 .expectedTotalBytes !=
                                  //     //             null
                                  //     //         ? loadingProgress
                                  //     //                 .cumulativeBytesLoaded /
                                  //     //             loadingProgress
                                  //     //                 .expectedTotalBytes
                                  //     //         : null,
                                  //     //   ),
                                  //     // );
                                  //   },
                                  // )),

                                  )),
                          Positioned(
                            left: 10,
                            top: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: gainsborohs.withOpacity(0.6),
                                    border: Border.all(
                                        width: 1, color: gainsborohs)),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                      "${amoledFirebase.wallpaper.imagewidth[index]} " +
                                          "x " +
                                          "${amoledFirebase.wallpaper.imageheight[index]}",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 40,
                            left: 5,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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

                                Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: gainsborohs.withOpacity(0.6),
                                        border: Border.all(
                                            width: 1, color: gainsborohs)),
                                    child: Text(
                                        filesize(amoledFirebase
                                            .wallpaper.imagebytes[index]
                                            .toString()),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white))),
                                SizedBox(
                                  width: 6,
                                ),
                                Container(
                                  // margin: EdgeInsets.all(15),
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: gainsborohs.withOpacity(0.6),
                                    border: Border.all(
                                        width: 1, color: gainsborohs),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.thumbsUp,
                                        size: 10,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        amoledFirebase.wallpaper.ups[index]
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            child: Container(
                              height: 33,
                              width: 200,
                              color: gainsborohs,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        amoledFirebase.wallpaper.title[index]
                                            .toString()
                                            .dbFilterTitle,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "By ${amoledFirebase.wallpaper.author[index]}",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: gainsborohs),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        timeago.format(date),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: gainsborohs),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

extension StringExtensions on String {
  String get dbFilterTitle {
    if (null != this) {
      int index11 = this.indexOf("[");
      int index12 = this.indexOf("]");
      int index22 = this.indexOf("(");
      int index23 = this.indexOf(")");

      if (this.contains("(") && this.contains(")") && this.contains("[")) {
        dynamic list = this.replaceRange(index22, index23 + 1, "");
        int list2 = list.indexOf("[");
        int list3 = list.indexOf("]");
        int list4 = list.indexOf(")");
        int list5 = list.indexOf("(");
        if (list.toString().contains("[") && list.toString().contains(")")) {
          return list.toString().replaceRange(list2, list4 + 1, "");
        } else if (list.toString().contains("[") &&
            list.toString().contains("]")) {
          return list.toString().replaceRange(list2, list3 + 1, "");
        } else if (list.toString().contains("(") &&
            list.toString().contains(")")) {
          return list.toString().replaceRange(list5, list4 + 1, "");
        } else {
          return list;
        }
      } else if (this.contains("[")) {
        return this.replaceRange((index11 != -1) ? index11 : index22,
            (index12 != -1) ? index12 + 1 : index23 + 1, "");
      } else if (this.contains("(") && this.contains(")")) {
        return this.replaceRange((index22 != -1) ? index22 : index11,
            (index23 != -1) ? index23 + 1 : index12 + 1, "");
      } else if (this.contains("(")) {
        return this
            .replaceRange(index22, index23, "")
            .replaceRange(index11, index23, "");
      }
    }
    return null;
  }

  String get removeUnderscore {
    if (null != this) {
      dynamic value = this.split("/")[5];
      dynamic underscore = value.toString().replaceAll("_", " ");
      return underscore;
    }
    return null;
  }

  Future get statuscode async {
    if (this != null) {
      http.Response response = await http.head(this);
      return response.statusCode;
    }
  }
}
