import 'package:flutter/foundation.dart';
import 'package:wallpaper/freezed/wallpaper.dart';
import 'package:extended_image/extended_image.dart';

class AmoledFirebase with ChangeNotifier {
  Wallpaper wallpaper;
  List firebasedb = [];

  bool status = false;
  LoadState loadingval ;

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
    crud("newwallpaper/new", Addvalue(firebasedb));
    wallpaper = Wallpaper(firebasedb);
    return wallpaper;
  }

  bool updateboxstatus(bool val) {
    notifyListeners();
    return status = val;
  }

  LoadState updateloadingval(LoadState val) {
    return loadingval = val;
  }
}
