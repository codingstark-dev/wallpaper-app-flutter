import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/provider/firebasedata.dart';
import 'package:wallpaper/widget/category.dart';
import 'package:wallpaper/widget/hometext.dart';
import 'package:wallpaper/widget/wallpaperoverlay.dart';

void main() {
  runApp(MaterialApp(
    home: MultiProvider(providers: [
      ChangeNotifierProvider<AmoledFirebase>(
        create: (context) => AmoledFirebase(),
      ),
    ], child: MainScreenPage()),
    debugShowCheckedModeBanner: false,
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
    // TODO: implement initState
    super.initState();
    FirebaseDatabase.instance
        .reference()
        .child("newwallpaper/hot")
        .once()
        .then((value) => Provider.of<AmoledFirebase>(context, listen: false)
            .addWallpaper(value.value));
    FirebaseDatabase firebaseInstance = FirebaseDatabase.instance;

    firebaseInstance.goOnline();
    firebaseInstance.setPersistenceEnabled(true);
    // firebaseInstance.setPersistenceCacheSizeBytes(1);
    var databaseRef =
        FirebaseDatabase.instance.reference().child("newwallpaper/hot");
    databaseRef.keepSynced(true);
  }

  @override
  Widget build(BuildContext context) {
    // print(scrollController.offset / 2 / 12);

    return Scaffold(
      backgroundColor: Color(0xff1e2134),
      appBar: PreferredSize(
          child: AppBar(
            elevation: 0,
            backgroundColor: Color(0xff1e2134),
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
            HomeText(
              text: "Categories",
            ),
            Category(),
            HomeText(
              text: "Trending",
            ),
            FutureBuilder<DataSnapshot>(
                future: FirebaseDatabase.instance
                    .reference()
                    .child("newwallpaper/hot")
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
