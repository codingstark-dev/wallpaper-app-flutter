import 'package:auto_route/auto_route.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/helper/color.dart';
import 'package:wallpaper/provider/firebasedata.dart';
import 'package:wallpaper/router/router.gr.dart';
import 'package:wallpaper/service/locator.dart';
import 'package:wallpaper/widget/hometext.dart';
import 'package:wallpaper/widget/wallpaperoverlay.dart';

void main() {
  try {
    serviceLocator();
  } catch (e) {
    print(e.toString());
  }
  runApp(DevicePreview(
    enabled: kReleaseMode,
    builder: (context) => MaterialApp(
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider<AmoledFirebase>(
            create: (context) => AmoledFirebase(),
          ),
        ],
        child: ExtendedNavigator(
          router: Router(),
        ),
      ),
      // initialRoute: Routes.mainScreenPage,
      // onGenerateRoute: Router().onGenerateRoute,
      debugShowCheckedModeBanner: false,
    ),
  ));
}

class MainScreenPage extends StatefulWidget {
  const MainScreenPage({Key key}) : super(key: key);

  @override
  _MainScreenPageState createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    checkPermission();
    FirebaseDatabase.instance
        .reference()
        .child("newwallpaper/new")
        .once()
        .then((value) {
      return Provider.of<AmoledFirebase>(context, listen: false)
          .addWallpaper(value.value);
    });
    FirebaseDatabase firebaseInstance = FirebaseDatabase.instance;

    firebaseInstance.goOnline();
    firebaseInstance.setPersistenceEnabled(true);
    // firebaseInstance.setPersistenceCacheSizeBytes(1);
    var databaseRef =
        FirebaseDatabase.instance.reference().child("newwallpaper/new");
    databaseRef.keepSynced(true);
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
      print("object");
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
      Fluttertoast.showToast(
        msg: "Welcome Back!",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(scrollController.offset / 2 / 12);

    return Scaffold(
      backgroundColor: darkslategrayhs,
      appBar: PreferredSize(
          child: AppBar(
            elevation: 0,
            backgroundColor: darkslategrayhs,
            centerTitle: false,
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
            title: Image.asset(
              "assets/svg/iconsmenu2.png",
              height: 30,
              width: 30,
            ),
          ),
          preferredSize: Size(50, 55)),
      body: SafeArea(
        child: ListView(
          children: [
            // HomeText(
            //   text: "Categories",
            // ),
            // Category(),
            HomeText(
              text: "Trending",
            ),
            FutureBuilder<DataSnapshot>(
                future: FirebaseDatabase.instance
                    .reference()
                    .child("newwallpaper/new")
                    .once(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return WallpaperList(
                    dataSnapshot: snapshot.data,
                  );
                })
          ],
        ),
      ),
    );
  }
}

// void deleteWallpaper(
//   FirebaseDatabase linksCollection,
//   DeleteOperation deleteOperation, {
//   int index,
// }) {
//   deleteOperation.maybeWhen(
//       delete: () => linksCollection
//           .reference()
//           .child("newwallpaper/latest/$index")
//           .remove(),
//       orElse: () => print('No such operation'));
// }
