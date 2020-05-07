import 'package:get_it/get_it.dart';
import 'package:wallpaper/helper/list_s.dart';
import 'package:wallpaper/provider/firebasedata.dart';
import 'package:wallpaper/service/setwallpaper/wallpaperfun.dart';

GetIt sl = GetIt.instance;

void serviceLocator() async {
  sl.registerLazySingleton(() => AmoledFirebase());
  sl.registerLazySingleton(() => ListCollection());
  sl.registerLazySingleton(() => WallpaperFun());
}
