// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:wallpaper/freezed/wallpaper.dart';

// class AmoledWallpaper with ChangeNotifier {
//   Wallpaper wallpaper;

//   Future<Wallpaper> getAmoledWallpaper() async {
//     Response result = await Dio().get(
//         "https://api.pushshift.io/reddit/search/submission/?subreddit=Amoledbackgrounds&size=100&mod_removed=false&user_removed=false",
//         queryParameters: {'User-agent': 'your bot 0.1'});
//     // NetworkAPI networkAPI = NetworkAPI(
//     //     "https://api.pushshift.io/reddit/search/submission/?subreddit=Amoledbackgrounds&size=100");
//     // dynamic apidata = await networkAPI.getData();
//     // print(json.encode(result.data['data']['children'][0]["data"]["preview"]
//     //         ['images'][0]['resolutions'][2]['url']
//     //     .toString()
//     //     .replaceAll("amp;", "")));
//     var json = result.data;
//     List data = [];
//     Map datas = json;
//     // print(datas);
//     datas.forEach((e, ee) async {
//       for (var element in ee) {
//         if (element['author'].toString() != "[deleted]") {
//           if (element["url"].toString().endsWith('.jpg') ||
//               element["url"].toString().endsWith('.jpeg') ||
//               element["url"].toString().endsWith('.png')) {
//             data.add(element);
//           }
//         }
//         // http.Response response = await http.head(element['url']);
//         // print(response.statusCode);

//         // print(value);

//         // data.add(element);
//         // print(value);
//         // return element;

//         // await Dio().head(element["thumbnail"].toString()).then((value) {
//         //   if (value.statusMessage.contains("ok")) {
//         //     data.add(element);
//         //     print(value);
//         //     return element;
//         //   }
//         // });
//         // print(response.toString());

//       }
//     });

//     print(data.length);
//     // for (var i = 0; i < datas.length; i++) {
//     // File file = File(datas[i]["url"].toString());
//     // String path = basename(file.path.toLowerCase());
//     // for (var dat in datas) {
//     // if (dat["url"].toString().endsWith('.jpg')) {
//     // var image = Image.network(datas[i]["url"].toString()).toString();
//     // try {
//     // var response = await Dio().get(dat["url"].toString());
//     // if (response.statusCode == 200) {

//     wallpaper = Wallpaper(data);
//     notifyListeners();
//     print(wallpaper);
//     return wallpaper;

//     //   }
//     // } catch (e) {
//     //   print(e.toString());
//     // }
//     // }
//     // }
//     // }
//   }
// }
