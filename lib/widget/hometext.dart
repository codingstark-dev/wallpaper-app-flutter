import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper/helper/color.dart';

class HomeText extends StatelessWidget {
  const HomeText({Key key, @required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Text(text,
            style: GoogleFonts.pacifico(
                fontSize: 20,
                letterSpacing: 2,
                color: gainsborohs,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
