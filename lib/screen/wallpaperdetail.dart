import 'dart:typed_data';

import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/helper/color.dart';
import 'package:wallpaper/provider/firebasedata.dart';

class WallpaperDetail extends StatefulWidget {
  WallpaperDetail({Key key, this.index, this.data}) : super(key: key);
  final int index;
  final String data;
  @override
  _WallpaperDetailState createState() => _WallpaperDetailState();
}

class _WallpaperDetailState extends State<WallpaperDetail> {
  bool status = false;
  DefaultCacheManager manager = new DefaultCacheManager();

  void changeStatusBar() {
    if (status) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    } else {
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if (mounted) {
      super.initState();

      setState(() {});
      status = false;
      changeStatusBar();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
              if (mounted) {
                setState(() {
                  status = !status;
                  print(status);
                });
                changeStatusBar();
              } else
                return null;
            }, child: Consumer<AmoledFirebase>(
              builder: (BuildContext context, value, Widget child) {
                if (!mounted) return null;
                return Image(
                    image: AdvancedNetworkImage(
                  widget.data,
                  loadingProgress: (progress, data) {
                    if (progress == null) return child;
                    // print(progress * 100);
                    // print(filesize(loadingProgress.expectedTotalBytes));
                    print(Uint8List.fromList(data));
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(200.0),
                        child: Column(
                          children: <Widget>[
                            CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(gainsborohs),
                              backgroundColor: darkslategrayhs,
                              value: progress * 100,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              "⚠️ Alert ! Loading Image size is ${filesize(progress)}",
                              style: TextStyle(
                                  color: gainsborohs,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ));
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
                //         child: Center(
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
