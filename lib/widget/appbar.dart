import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
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
    AmoledFirebase amoledFirebase =
        Provider.of<AmoledFirebase>(context, listen: false);
    return Scaffold(
      backgroundColor: darkslategrayhs,
      drawer: Container(
          color: darkslategrayhs,
          width: 210,
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: darkslategrayhs,
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
                                      onTap: () async {
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
                                          case "Disclaimer":
                                            Navigator.of(context).pop();

                                            return showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    clipBehavior: Clip.hardEdge,
                                                    scrollable: true,
                                                    title: Text(
                                                      "Disclaimer",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    content: Text(
                                                        "All the wallpapers in this app are under common creative license and the credit goes to their respective owners. These images are not endorsed by any of the prospective owners, and the images are used simply for aesthetic purposes. No copyright infringement is intended, and any request to remove one of the images/logos/names will be honored. All the Images are obtained from reddit.com as well as our original work which are covered by the Creative Commons Zero license. That means all images are free for distribution and free for commercial use which also does not need any kind of attribution or credit. If there is an original work from us, we will mark it.The author of some works, we don't know the name, if you are the author of the work, you can contact us by email. "),
                                                    contentTextStyle: TextStyle(
                                                        color: gainsborohs,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    backgroundColor:
                                                        darkslategrayhs,
                                                    actions: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: MaterialButton(
                                                            color: gainsborohs,
                                                            textColor:
                                                                darkslategrayhs,
                                                            onPressed:
                                                                () async {
                                                              if (await canLaunch(
                                                                  'mailto:refoxdev@gmail.com')) {
                                                                await launch(
                                                                    "mailto:refoxdev@gmail.com");
                                                              } else {
                                                                throw 'Could not launch';
                                                              }
                                                            },
                                                            child: Text(
                                                                'Contact Us')),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: MaterialButton(
                                                            color: gainsborohs,
                                                            textColor:
                                                                darkslategrayhs,
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text('OK')),
                                                      ),
                                                    ],
                                                    titleTextStyle: TextStyle(
                                                        color: gainsborohs,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  );
                                                });

                                            break;
                                          case "Report Bug":
                                            if (await canLaunch(
                                                'mailto:refoxdev@gmail.com')) {
                                              await launch(
                                                  "mailto:refoxdev@gmail.com");
                                            } else {
                                              throw 'Could not launch';
                                            }
                                            Navigator.of(context).pop();
                                            break;
                                          case "Rate This App":
                                            final PackageInfo info =
                                                await PackageInfo
                                                    .fromPlatform();
                                            if (await canLaunch(
                                                'https://play.google.com/store/apps/details?id=${info.packageName}')) {
                                              await launch(
                                                  "https://play.google.com/store/apps/details?id=${info.packageName}");
                                            } else {
                                              throw 'Could not launch';
                                            }
                                            print(info.packageName);
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
                  "assets/svg/icons.png",
                  height: 50,
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
      case "Disclaimer":
        return list[2];
        break;
      case "Report Bug":
        return list[4];
        break;
      case "Rate This App":
        return list[3];
        break;
      default:
    }
  }
}
