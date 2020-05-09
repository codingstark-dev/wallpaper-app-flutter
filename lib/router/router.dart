import 'package:auto_route/auto_route_annotations.dart';
import 'package:wallpaper/main.dart';
import 'package:wallpaper/screen/wallpaperdetail.dart';
import 'package:wallpaper/screen/download.dart';
import 'package:wallpaper/wrapper/wrapper.dart';

@CupertinoAutoRouter()
class $Router {
  @initial
  Wrapper wrapper;
  @CupertinoRoute()
  MainScreenPage mainScreenPage;
  WallpaperDetail wallpaperDetail;
  DownloadPage downloadPage;
}
