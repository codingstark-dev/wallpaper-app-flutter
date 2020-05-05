import 'package:get_it/get_it.dart';
import 'package:wallpaper/helper/list_s.dart';
import 'package:wallpaper/provider/firebasedata.dart';

GetIt sl = GetIt.instance;

void serviceLocator() async {
  sl.registerLazySingleton(() => AmoledFirebase());
  sl.registerLazySingleton(() => ListCollection());
}
