
import 'package:draw/draw.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/helper/list_s.dart';
import 'package:wallpaper/provider/firebasedata.dart';
import 'package:wallpaper/service/setwallpaper/wallpaperfun.dart';

GetIt sl = GetIt.instance;

void serviceLocator() async {
  sl.registerLazySingleton(() => GetReddit());
  sl.registerLazySingleton(() => AmoledFirebase());
  sl.registerLazySingleton(() => ListCollection());
  sl.registerLazySingleton(() => WallpaperFun());
}

class GetReddit {
  List datssa = [];
  Future<dynamic> redditData(BuildContext context, int i) async {
    var amoledFirebase = Provider.of<AmoledFirebase>(context, listen: false);
    Reddit reddit = await Reddit.createScriptInstance(
      clientId: 'W1XGqNQSKF2h4w',
      clientSecret: '32CM4A9gSaIGVJFTwCHtKjWt7Xg',
      userAgent:
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.113 Safari/537.36',
      username: "himanshu338",
      password: "6b6WNmT*qZQ@qvx", // Fake
    );

    SubredditRef currentUser = reddit.subreddit("Amoledbackgrounds");
    // Outputs: My name is DRAWApiOfficial
    Stream<UserContent> data =
        currentUser.top(limit: i, timeFilter: TimeFilter.month);
    return data.forEach((element) async {
      var data = await element.fetch();

      Submission submission = data[0]['listing'][0];
      if (submission.url.path.trim().contains("png") ||
          submission.url.path.trim().contains("jpeg") ||
          submission.url.path.trim().contains("jpg")) {
        // List<SubmissionPreview> s = submission.preview;
        //  print(s[3]);
        datssa.clear();
        datssa.add(submission.data);

        return amoledFirebase.addLazyList(datssa.toList());
      }
    });
  }
}
