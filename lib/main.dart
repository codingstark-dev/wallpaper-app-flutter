import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
import 'package:draw/draw.dart' as Reddit;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    serviceLocator();
  } catch (e) {
    print(e.toString());
  } // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday
  // development.
  Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runZoned(() {
    runApp(
      MaterialApp(
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
    );
  });
}

class MainScreenPage extends StatefulWidget {
  const MainScreenPage({Key key}) : super(key: key);

  @override
  _MainScreenPageState createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  bool loading = false;
  final ScrollController scrollController = ScrollController();
  int increament = 10;
  int contentcount = 0;
  // List datssa = [];

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    sl.get<WallpaperFun>().checkPermission();
    // fetchDataFB();
    redditData(100).whenComplete(() {
      return loading = true;
    });

    // scrollController.addListener(() {
    //   double maxScroll = scrollController.position.maxScrollExtent;
    //   double currentScroll = scrollController.position.pixels;
    //   double delta = MediaQuery.of(context).size.height * 0.20;
    //   if (maxScroll - currentScroll <= delta) {
    //     getmoreData();
    //   }
    // });
    // scrollController.addListener(() {
    //   // var triggerFetchMoreSize =
    //   //     0.9 * scrollController.position.maxScrollExtent;

    //   // if (scrollController.position.pixels > triggerFetchMoreSize) {
    //   //
    //   // }

    //   // if (scrollController.position.pixels ==
    //   //     scrollController.position.maxScrollExtent) {
    //   //   getmoreData();
    //   // }
    // });
    // FirebaseDatabase firebaseInstance = FirebaseDatabase.instance;

    // firebaseInstance.goOnline();
    // firebaseInstance.setPersistenceEnabled(true);
    // // firebaseInstance.setPersistenceCacheSizeBytes(1);
    // var databaseRef =
    //     FirebaseDatabase.instance.reference().child("newwallpaper/new");
    // databaseRef.keepSynced(true);
  }

  List weekdata = [];
  List newestdata = [];
  Future<dynamic> redditData(int i) async {
    var amoledFirebase = Provider.of<AmoledFirebase>(context, listen: false);
    Reddit.Reddit reddit = await Reddit.Reddit.createScriptInstance(
      clientId: 'W1XGqNQSKF2h4w',
      clientSecret: '32CM4A9gSaIGVJFTwCHtKjWt7Xg',
      userAgent:
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.113 Safari/537.36',
      username: "himanshu338",
      password: "6b6WNmT*qZQ@qvx", // Fake
    );

    Reddit.SubredditRef currentUser = reddit.subreddit("Amoledbackgrounds");
    // Outputs: My name is DRAWApiOfficial
    Stream<Reddit.UserContent> week =
        currentUser.top(limit: i, timeFilter: Reddit.TimeFilter.week);
    Stream<Reddit.UserContent> newest = currentUser.newest(
      limit: i,
    );
    week.forEach((element) async {
      var data = await element.fetch();

      Reddit.Submission submission = data[0]['listing'][0];
      if (submission.url.path.trim().contains("png") ||
          submission.url.path.trim().contains("jpeg") ||
          submission.url.path.trim().contains("jpg") ||
          submission.over18 != true) {
        // List<SubmissionPreview> s = submission.preview;
        //  print(s[3]);
        weekdata.clear();
        weekdata.add(submission.data);
        // print(weekdata.toList());
        for (var i = 0; i < weekdata.length; i++) {
          amoledFirebase.addWallpaper(weekdata);
        }
        setState(() {});
        loading = true;
      }
    });
    newest.forEach((element) async {
      var data = await element.fetch();

      Reddit.Submission submission = data[0]['listing'][0];
      if (submission.url.path.trim().contains("png") ||
          submission.url.path.trim().contains("jpeg") ||
          submission.url.path.trim().contains("jpg") &&
              submission.over18 != true) {
        // List<SubmissionPreview> s = submission.preview;

        newestdata.clear();
        newestdata.add(submission.data);
        // print(newestdata.toList());
        for (var i = 0; i < newestdata.length; i++) {
          amoledFirebase.addLatestWallpaper(newestdata);
        }
        setState(() {});
        loading = true;
      }
    });
  }

  getmoreData() async {
    AmoledFirebase amoledFirebase =
        Provider.of<AmoledFirebase>(context, listen: false);
    print(amoledFirebase.itemCount);
    if (amoledFirebase.trending) {
      // for (int i = contentcount; i < contentcount + 10; i++) {
      //   amoledFirebase.addWallpaper(
      //       amoledFirebase.lazyList.getRange(contentcount, contentcount));
      // }

      contentcount = contentcount + 10;

      setState(() {});

      // if (amoledFirebase.wallpaper.preview.length > itemcounts) {
      //   sl.get<GetReddit>().redditData(context, itemcounts += 10);
      // }
      //  else {
      //   print("object");
      //   setState(() {
      //     amoledFirebase.addItemNumber(amoledFirebase.itemCount -= 1);
      //   });
      // }
    } else {
      // if (amoledFirebase.latestWallpaper.preview.length >=
      //     amoledFirebase.itemCount + 1) {
      //   setState(() {
      //     amoledFirebase.addItemNumber(amoledFirebase.itemCount += 10);
      //   });
      // }
    }
  }

  Future fetchDataFB() async {
    // bool loading = false;
    var amoledFirebase = Provider.of<AmoledFirebase>(context, listen: false);
    // FirebaseDatabase firebaseDatabase;
    await FirebaseDatabase.instance
        .reference()
        .child("newwallpaper/hot")
        .once()
        .then((value) {
      return amoledFirebase.addWallpaper(value.value);
    }).whenComplete(() => loading = true);

    await FirebaseDatabase.instance
        .reference()
        .child("newwallpaper/new")
        .once()
        .then((value) {
      return amoledFirebase.addLatestWallpaper(value.value);
    });
    amoledFirebase.updatesearchIcon(true);
    // amoledFirebase.addItemNumber(amoledFirebase.wallpaper.preview.length - 10);
  }

  @override
  Widget build(BuildContext context) {
    // print(scrollController.offset / 2 / 12);
    AmoledFirebase amoledFirebase =
        Provider.of<AmoledFirebase>(context, listen: true);

    return AppBars(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            AnimatedOpacity(
              curve: Curves.easeIn,
              onEnd: () {
                if (!amoledFirebase.searchField)
                  amoledFirebase.updatevisibilty(false);
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
                controller: scrollController,
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
                                  'No Search Result Found With This Keyword "${amoledFirebase.searchdbtext}"',
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
