import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:wallpaper/provider/firebasedata.dart';
import 'package:wallpaper/route/const_route.dart';
import 'package:wallpaper/screen/wallpaperdetail.dart';

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
            childAspectRatio: 1 / 1.5,
            crossAxisSpacing: 2,
            mainAxisSpacing: 1),
        padding: EdgeInsets.all(10),
        scrollDirection: Axis.vertical,
        itemCount: amoledFirebase.wallpaper.preview.length
        // widget.dataSnapshot.value.length
        ,
        // itemCount: data.wallpaper.url.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                // crud("newwallpaper/", Delete(index));
                // amoledFirebase..removeList(index);
                // amoledFirebase.removeList(index);
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (BuildContext context) => WallpaperDetail(
                              data: amoledFirebase.wallpaper.preview[index],
                              index: index,
                            )));
                print(index);
              },
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
                                child: Image.network(
                                  amoledFirebase.wallpaper.preview[index],
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.low,
                                  errorBuilder: (context, error, stackTrace) {
                                    amoledFirebase.removeList(index);
                                    return Center(
                                        child: Text(
                                            "😞 Sorry Author Removed Image"));
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;

                                    return Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Color(0xff1e2134),
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes
                                            : null,
                                      ),
                                    );
                                  },
                                )),
                            Container(
                              height: 30,
                              width: 200,
                              color: Color(0xffa9b7e2),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Positioned(
                            //   bottom: 220,
                            //   width: 210,
                            //   child: Container(
                            //     margin: EdgeInsets.all(15),
                            //     padding: EdgeInsets.all(3),
                            //     decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(10),
                            //         color: Color(0xffa9b7e2)),
                            //     child: Text(
                            //       "By ${amoledFirebase.wallpaper.author[index]}",
                            //       textAlign: TextAlign.center,
                            //       style: TextStyle(
                            //         color: Colors.black,
                            //         fontWeight: FontWeight.w400,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "data",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffa9b7e2)),
                    overflow: TextOverflow.clip,
                  )
                ],
              ),
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
