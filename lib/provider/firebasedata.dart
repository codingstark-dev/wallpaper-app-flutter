import 'package:flutter/foundation.dart';
import 'package:wallpaper/freezed/wallpaper.dart';
import 'package:extended_image/extended_image.dart';

class AmoledFirebase with ChangeNotifier {
  Wallpaper wallpaper;
  SearchData searchData;
  List firebasedb = [];
  bool searchField = false;
  bool status = false;
  LoadState loadingval;
  bool isVisible = false;
  List searchdb = [];
  String searchdbtext = "";
  bool searchIcon = true;
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

  addsearch(List data) {
    for (var i = 0; i < data.length; i++) {
      if (data[i] != null) {
        searchdb.add(data[i]);
      }
    }
    searchData = SearchData(searchdb);
    notifyListeners();
    return searchData;
  }

  addStringSearchdb(data) {
    notifyListeners();
    return searchdbtext = data;
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
 bool updatesearchIcon(bool val) {
    notifyListeners();
    return searchIcon = val;
  }
  bool updatesearch(bool val) {
    notifyListeners();
    return searchField = val;
  }

  bool updatevisibilty(bool val) {
    notifyListeners();
    return isVisible = val;
  }

  LoadState updateloadingval(LoadState val) {
    return loadingval = val;
  }
}
