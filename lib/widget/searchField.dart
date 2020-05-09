import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/helper/color.dart';
import 'package:wallpaper/provider/firebasedata.dart';

class SearchField extends StatefulWidget {
  SearchField({Key key}) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    AmoledFirebase amoledFirebase = Provider.of<AmoledFirebase>(context);

    return Container(
        child: SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
            controller: textEditingController,
            onChanged: (value) {
              if (amoledFirebase.trending) {
                var data = amoledFirebase.firebasedb
                    .where((element) => element['title']
                        .toString()
                        .toLowerCase()
                        .contains(value))
                    .toList();
                setState(() {
                  amoledFirebase.searchdb.clear();
                  amoledFirebase.addsearch(data);
                  amoledFirebase.addStringSearchdb(value);
                });
              } else {
                var data = amoledFirebase.latestWallpaperdb
                    .where((element) => element['title']
                        .toString()
                        .toLowerCase()
                        .contains(value))
                    .toList();
                setState(() {
                  amoledFirebase.searchdb.clear();
                  amoledFirebase.addsearch(data);
                  amoledFirebase.addStringSearchdb(value);
                });
              }
            },
            style: TextStyle(color: gainsborohs),
            cursorColor: gainsborohs,
            decoration: InputDecoration(
                hintText: "Search Wallpaper..",
                hintStyle:
                    TextStyle(color: gainsborohs, fontWeight: FontWeight.w400),
                suffixIcon: IconButton(
                  color: gainsborohs,
                  icon: (amoledFirebase.searchdbtext == "")
                      ? Container()
                      : Icon(FontAwesomeIcons.timesCircle),
                  onPressed: () {
                    setState(() {
                      textEditingController.clear();
                      amoledFirebase.addStringSearchdb("");
                    });
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: gainsborohs),
                ),
                focusColor: Colors.white,
                fillColor: Colors.white,
                hoverColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: gainsborohs),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: gainsborohs),
                ))),
      ),
    ));
  }
}
