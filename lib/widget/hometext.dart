import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/helper/color.dart';
import 'package:wallpaper/provider/firebasedata.dart';

class HomeText extends StatefulWidget {
  const HomeText({Key key, @required this.text}) : super(key: key);
  final String text;

  @override
  _HomeTextState createState() => _HomeTextState();
}

class _HomeTextState extends State<HomeText> {
  @override
  Widget build(BuildContext context) {
    AmoledFirebase amoledFirebase = Provider.of<AmoledFirebase>(context);

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(widget.text,
                style: GoogleFonts.pacifico(
                    fontSize: 20,
                    letterSpacing: 2,
                    color: gainsborohs,
                    fontWeight: FontWeight.bold)),
            DropdownButton(
              underline: Container(),
              dropdownColor: darkslategrayhs,
              style: TextStyle(color: gainsborohs),
              value: amoledFirebase.value1,
              iconEnabledColor: gainsborohs,
              items: <String>["Trending", "Latest"]
                  .map<DropdownMenuItem<String>>((e) {
                return DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: TextStyle(
                          color: gainsborohs, fontWeight: FontWeight.bold),
                    ));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  amoledFirebase.addStringvalue1(value);
                  switch (value) {
                    case "Trending":
                      amoledFirebase.updatetrending(true);
                      break;
                    case "Latest":
                      amoledFirebase.updatetrending(false);
                      break;
                    default:
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
