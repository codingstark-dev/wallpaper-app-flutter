import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:wallpaper/helper/color.dart';
import 'package:wallpaper/router/router.gr.dart';
import 'package:wallpaper/service/locator.dart';
import 'package:wallpaper/service/setwallpaper/wallpaperfun.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pages = [
      PageViewModel(
          pageColor: gainsborohs,
          iconImageAssetPath: 'assets/svg/clock.png',
          bubble: Image.asset('assets/svg/clock.png'),
          body: Text(
            'We Update WallPaper Regularly, With Original Image And Quality',
          ),
          title: Text(
            'Wallpaper!',
          ),
          titleTextStyle:
              GoogleFonts.robotoMono(color: darkslategrayhs, fontSize: 30),
          bodyTextStyle: GoogleFonts.robotoMono(color: darkslategrayhs),
          mainImage: Image.asset(
            'assets/svg/clock.png',
            height: 200.0,
            width: 200.0,
            alignment: Alignment.center,
          )),
      PageViewModel(
        pageColor: darkslategrayhs,
        iconImageAssetPath: 'assets/svg/ads.png',
        body: Text(
          'This App Does Not Contain Any Single Ads! So Enjoy This App..',
        ),
        title: Text('Ads?'),
        mainImage: Image.asset(
          'assets/svg/ads.png',
          height: 200.0,
          width: 200.0,
          alignment: Alignment.center,
        ),
        titleTextStyle:
            GoogleFonts.robotoMono(color: Colors.white, fontSize: 30),
        bodyTextStyle: GoogleFonts.robotoMono(color: Colors.white),
      ),
    ];

    return IntroViewsFlutter(
      pages,
      background: gainsborohs,
      onTapDoneButton: () {
        sl
            .get<WallpaperFun>()
            .setVisitingBool()
            .whenComplete(() => print("Done"));
        ExtendedNavigator.of(context)
            .pushReplacementNamed(Routes.mainScreenPage);
      },
    );
  }
}
