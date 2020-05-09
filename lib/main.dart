import 'package:auto_route/auto_route.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/helper/color.dart';
import 'package:wallpaper/provider/firebasedata.dart';
import 'package:wallpaper/router/router.gr.dart';
import 'package:wallpaper/service/locator.dart';
import 'package:wallpaper/service/setwallpaper/wallpaperfun.dart';
import 'package:wallpaper/widget/appbar.dart';
import 'package:wallpaper/widget/hometext.dart';
import 'package:wallpaper/widget/latestwallpaper.dart';
import 'package:wallpaper/widget/searchField.dart';
import 'package:wallpaper/widget/searchwallpaper.dart';
import 'package:wallpaper/widget/wallpaperoverlay.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
      initialRoute: Routes.mainScreenPage,
      onGenerateRoute: Router().onGenerateRoute,
      debugShowCheckedModeBanner: false,
    ),
  ));
}

class MainScreenPage extends StatefulWidget {
  const MainScreenPage({Key key}) : super(key: key);

  @override
  _MainScreenPageState createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage>
    with TickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  bool loading = false;
  @override
  void initState() {
    super.initState();
    sl.get<WallpaperFun>().checkPermission();

    FirebaseDatabase.instance
        .reference()
        .child("newwallpaper/hot")
        .once()
        .then((value) {
      return Provider.of<AmoledFirebase>(context, listen: false)
          .addWallpaper(value.value);
    }).whenComplete(() => loading = true);

    FirebaseDatabase.instance
        .reference()
        .child("newwallpaper/new")
        .once()
        .then((value) {
      return Provider.of<AmoledFirebase>(context, listen: false)
          .addLatestWallpaper(value.value);
    });
    Provider.of<AmoledFirebase>(context, listen: false).updatesearchIcon(true);
    // FirebaseDatabase firebaseInstance = FirebaseDatabase.instance;

    // firebaseInstance.goOnline();
    // firebaseInstance.setPersistenceEnabled(true);
    // // firebaseInstance.setPersistenceCacheSizeBytes(1);
    // var databaseRef =
    //     FirebaseDatabase.instance.reference().child("newwallpaper/new");
    // databaseRef.keepSynced(true);
  }

  @override
  Widget build(BuildContext context) {
    // print(scrollController.offset / 2 / 12);
    AmoledFirebase amoledFirebase = Provider.of<AmoledFirebase>(context);

    return AppBars(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            AnimatedOpacity(
              curve: Curves.easeIn,
              onEnd: () {
                if (!amoledFirebase.searchField)
                  setState(() {
                    amoledFirebase.updatevisibilty(false);
                  });
              },
              opacity: amoledFirebase.searchField ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              child: Visibility(
                visible: amoledFirebase.isVisible,
                child: SearchField(),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  // HomeText(
                  //   text: "Categories",
                  // ),
                  // Category(),

                  HomeText(
                    text: amoledFirebase.trending ? "Trending" : "Latest",
                  ),
                  Builder(
                    builder: (BuildContext context) {
                      if (!loading)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      if (amoledFirebase.trending) {
                        if (amoledFirebase.searchdbtext == "") {
                          return WallpaperList();
                        } else if (amoledFirebase.searchdb.isNotEmpty) {
                          return SearchWallpaper();
                        } else {
                          return Align(
                            alignment: Alignment.center,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(2, 40, 2, 2),
                                child: Text(
                                  'No Result Found With This Keyword "${amoledFirebase.searchdbtext}"',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.rancho(
                                      color: gainsborohs, fontSize: 20),
                                ),
                              ),
                            ),
                          );
                        }
                      } else {
                        if (amoledFirebase.searchdbtext == "") {
                          return LatestWallpapers();
                        } else if (amoledFirebase.searchdb.isNotEmpty) {
                          return SearchWallpaper();
                        } else {
                          return Align(
                            alignment: Alignment.center,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(2, 40, 2, 2),
                                child: Text(
                                  'No Result Found With This Keyword "${amoledFirebase.searchdbtext}"',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.rancho(
                                      color: gainsborohs, fontSize: 20),
                                ),
                              ),
                            ),
                          );
                        }
                      }
                    },
                  )
                ],
              ),
            ),
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
