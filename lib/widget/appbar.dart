import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/helper/color.dart';
import 'package:wallpaper/helper/list_s.dart';
import 'package:wallpaper/provider/firebasedata.dart';
import 'package:wallpaper/router/router.gr.dart';
import 'package:wallpaper/service/locator.dart';

class AppBars extends StatefulWidget {
  AppBars({Key key, @required this.body}) : super(key: key);
  final Widget body;
  @override
  _AppBarsState createState() => _AppBarsState();
}

class _AppBarsState extends State<AppBars> {
  @override
  Widget build(BuildContext context) {
    AmoledFirebase amoledFirebase = Provider.of<AmoledFirebase>(context);
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
                    height: 40,
                  ),
                  SizedBox(
                    height: 150,
                    child: Image.asset(
                      "assets/svg/fox1.png",
                      fit: BoxFit.cover,
                    ),
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
                                         
                                            ExtendedNavigator.rootNavigator
                                                .pushReplacementNamed(
                                                    Routes.mainScreenPage);
                                            break;
                                          case "Download":
                                            ExtendedNavigator.rootNavigator
                                                .pushNamed(Routes.downloadPage);
                                            amoledFirebase
                                                .updatesearchIcon(false);

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
                  (amoledFirebase.searchIcon == true)
                      ? InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            (amoledFirebase.searchField == true)
                                ? amoledFirebase.updatesearch(false)
                                : amoledFirebase.updatesearch(true);
                            amoledFirebase.updatevisibilty(true);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: (amoledFirebase.searchField == false)
                                ? Image.asset(
                                    "assets/svg/iconsmenu3.png",
                                    width: 30,
                                    height: 35,
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.cancel,
                                      color: gainsborohs,
                                    ),
                                  ),
                          ),
                        )
                      : SizedBox(
                          width: 32,
                          height: 35,
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
                title: Image.asset(
                  "assets/svg/icons.png", height: 50,
                )),
          ),
          preferredSize: Size(50, 55)),
      body: widget.body,
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
