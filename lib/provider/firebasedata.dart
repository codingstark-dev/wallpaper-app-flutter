import 'package:flutter/foundation.dart';
import 'package:wallpaper/freezed/wallpaper.dart';
import 'package:extended_image/extended_image.dart';

class AmoledFirebase with ChangeNotifier {
  Wallpaper wallpaper;
  SearchData searchData;
  LatestWallpaper latestWallpaper;
  List firebasedb = [];
  List searchdb = [];
  List latestWallpaperdb = [];
  bool searchField = false;
  bool status = false;
  LoadState loadingval;
  bool isVisible = false;
  String value1 = "Trending";
  int itemCount = 10;
  String searchdbtext = "";
  bool searchIcon = true;
  bool trending = true;

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

  addItemNumber(int nu) {
    notifyListeners();
    return itemCount = nu;
  }

  addLatestWallpaper(List data) {
    for (var i = 0; i < data.length; i++) {
      if (data[i] != null) {
        latestWallpaperdb.add(data[i]);
      }
    }
    latestWallpaper = LatestWallpaper(latestWallpaperdb);
    notifyListeners();
    return latestWallpaper;
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

  addStringvalue1(data) {
    notifyListeners();
    return value1 = data;
  }

  addStringSearchdb(data) {
    notifyListeners();
    return searchdbtext = data;
  }

//Todo: MAke new
  removeHotList(index) {
    firebasedb.removeAt(index);
    crud("newwallpaper/hot", Addvalue(firebasedb));
    wallpaper = Wallpaper(firebasedb);
    return wallpaper;
  }

  removeNewList(index) {
    latestWallpaperdb.removeAt(index);
    crud("newwallpaper/new", Addvalue(latestWallpaperdb));
    latestWallpaper = LatestWallpaper(latestWallpaperdb);
    return latestWallpaper;
  }

  removeNewSearchList(index) {
    searchdb.removeAt(index);
    crud("newwallpaper/new", Addvalue(searchdb));
    searchData = SearchData(searchdb);
    return searchData;
  }

  removeHotSearchList(index) {
    searchdb.removeAt(index);
    crud("newwallpaper/hot", Addvalue(searchdb));
    searchData = SearchData(searchdb);
    return searchData;
  }

  bool updateboxstatus(bool val) {
    notifyListeners();
    return status = val;
  }

  bool updatetrending(bool val) {
    notifyListeners();
    return trending = val;
  }

  bool updatesearchIcon(bool val) {
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
