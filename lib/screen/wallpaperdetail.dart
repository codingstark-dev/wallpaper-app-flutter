import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WallpaperDetail extends StatefulWidget {
  WallpaperDetail({Key key, this.index, this.data}) : super(key: key);
  final int index;
  final String data;
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
    // TODO: implement initState
    super.initState();
    setState(() {});
    status = false;
    changeStatusBar();
  }

  @override
  Widget build(BuildContext context) {
// SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//   statusBarColor: Colors.transparent,
// ));
    return Material(
      child: Container(
        child: FittedBox(
          child: InkWell(
              onTap: () {
                // SystemChrome.setEnabledSystemUIOverlays(
                //     [SystemUiOverlay.bottom]);
                setState(() {
                  status = !status;
                  print(status);
                });
                changeStatusBar();
              },
              child: Image.network(widget.data)),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
