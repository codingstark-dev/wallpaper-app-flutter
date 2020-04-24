import 'package:flutter/cupertino.dart';
import 'package:wallpaper/freezed/wallpaper.dart';

class AmoledFirebase with ChangeNotifier {
  Wallpaper wallpaper;
  List firebasedb = [];

  addWallpaper(List data) {
    for (var i = 0; i < data.length; i++) {
      if (data[i] != null) {
        firebasedb.add(data[i]);
      }
    }

    wallpaper = Wallpaper(firebasedb);
    notifyListeners();
    return wallpaper;
  }

  removeList(index) {
    firebasedb.removeAt(index);
    crud("newwallpaper/hot", Addvalue(firebasedb));
    wallpaper = Wallpaper(firebasedb);
    notifyListeners();
    return wallpaper;
  }
}
