import 'package:flutter/material.dart';
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
          // iconImageAssetPath: 'assets/air-hostess.png',
          bubble: Image.asset('assets/air-hostess.png'),
          body: Text(
            'Haselfree  booking  of  flight  tickets  with  full  refund  on  cancelation',
          ),
          title: Text(
            'Flights',
          ),
          titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
          bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
          mainImage: Image.asset(
            'assets/airplane.png',
            height: 285.0,
            width: 285.0,
            alignment: Alignment.center,
          )),
      PageViewModel(
        pageColor: darkslategrayhs,
        iconImageAssetPath: 'assets/waiter.png',
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
