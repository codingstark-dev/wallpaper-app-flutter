import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:wallpaper/helper/color.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pages = [
      PageViewModel(
          pageColor: gainsborohs,
          iconImageAssetPath:  'assets/svg/clock.png',
          bubble: Image.asset( 'assets/svg/clock.png'),
          body: Text(
            'We Update WallPaper Regularly, With Original Image And Quality',
          ),
          title: Text(
            'Wallpaper',
          ),
          titleTextStyle: GoogleFonts.pacifico( color:darkslategrayhs,fontSize: 30),
          bodyTextStyle: GoogleFonts.pacifico( color: darkslategrayhs),
          mainImage: Image.asset(
            'assets/svg/clock.png',
            height: 200.0,
            width: 200.0,
            alignment: Alignment.center,
          )),
      PageViewModel(
        pageColor: darkslategrayhs,
        iconImageAssetPath: 'assets/svg/clock.png',
        body: Text(
          'We  work  for  the  comfort ,  enjoy  your  stay  at  our  beautiful  hotels',
        ),
        title: Text('Hotels'),
        mainImage: Image.asset(
          'assets/hotel.png',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        ),
        titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      ),
    ];

    return IntroViewsFlutter(pages);
  }
}
