// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';

// import 'package:wallpaper/helper/color.dart';
// import 'package:wallpaper/helper/list_s.dart';
// import 'package:wallpaper/main.dart';
// import 'package:wallpaper/router/router.gr.dart';
// import 'package:wallpaper/service/locator.dart';

// class ApppBar extends StatefulWidget {
//   const ApppBar({
//     Key key,
//     @required this.widget,
//     @required this.body,
//   }) : super(key: key);
//   final MainScreenPage widget;
//   final Widget body;

//   @override
//   _ApppBarState createState() => _ApppBarState();
// }

// class _ApppBarState extends State<ApppBar> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: darkslategrayhs,
//       drawer: Container(
//           color: darkslategrayhs,
//           width: 210,
//           child: Theme(
//             data: Theme.of(context).copyWith(
//               // Set the transparency here
//               canvasColor:
//                   darkslategrayhs, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
//             ),
//             child: Drawer(
//               child: Column(
//                 children: <Widget>[
//                   SizedBox(
//                     height: 150,
//                   ),
//                   Expanded(
//                       child: ListView(
//                           children: sl
//                               .get<ListCollection>()
//                               .draw
//                               .map((e) => Material(
//                                     color: Colors.transparent,
//                                     child: InkWell(
//                                       onTap: () {
//                                         ExtendedNavigator.rootNavigator
//                                             .pushNamed(Routes.downloadPage);
//                                       },
//                                       child: ListTile(
//                                         leading: widget.body,
//                                         title: Text(
//                                           e,
//                                           style: TextStyle(
//                                               color: gainsborohs,
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                     ),
//                                   ))
//                               .toList())),
//                 ],
//               ),
//             ),
//           )),
//       appBar: PreferredSize(
//           child: Builder(
//             builder: (BuildContext context) => AppBar(
//               elevation: 0,
//               backgroundColor: darkslategrayhs,
//               centerTitle: false,
//               automaticallyImplyLeading: false,
//               actions: [
//                 InkWell(
//                   borderRadius: BorderRadius.circular(100),
//                   onTap: () {},
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Image.asset(
//                       "assets/svg/iconsmenu3.png",
//                       width: 30,
//                       height: 35,
//                     ),
//                   ),
//                 )
//               ],
//               title: InkWell(
//                 // borderRadius: BorderRadius.circular(100),
//                 onTap: () {
//                   return Scaffold.of(context).openDrawer();
//                 },
//                 child: Image.asset(
//                   "assets/svg/iconsmenu2.png",
//                   height: 30,
//                   width: 30,
//                 ),
//               ),
//             ),
//           ),
//           preferredSize: Size(50, 55)),
//       body: widget.body,
//     );
//   }
// }
