import 'package:auto_route/auto_route_annotations.dart';
import 'package:wallpaper/main.dart';
import 'package:wallpaper/screen/wallpaperdetail.dart';
import 'package:wallpaper/screen/download.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  MainScreenPage mainScreenPage;
  @CupertinoRoute()
  WallpaperDetail wallpaperDetail;
  DownloadPage downloadPage;
 
}
