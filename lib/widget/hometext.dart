import 'package:flutter/material.dart';

class HomeText extends StatelessWidget {
  const HomeText({Key key, @required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Text(text,
            style: TextStyle(
                fontFamily: 'googlefont',
                fontSize: 20,letterSpacing: 2,
                color: Color(0xffd4d9e3),
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
