import 'package:firebase_database/firebase_database.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'wallpaper.freezed.dart';

@freezed
abstract class Wallpaper with _$Wallpaper {
  factory Wallpaper(List<dynamic> wallpaperData) = _Wallpaper;

  @late
  List<dynamic> get title => wallpaperData.map((e) => e['title']).toList();

  @late
  List<dynamic> get author => wallpaperData.map((e) => e['author']).toList();
  @late
  List<dynamic> get preview => wallpaperData.map((e) => e['preview']).toList();
  @late
  List<dynamic> get permalink =>
      wallpaperData.map((e) => e['permalink']).toList();
  @late
  List<dynamic> get image => wallpaperData.map((e) => e['image']).toList();
  @late
  List<dynamic> get ups => wallpaperData.map((e) => e['ups']).toList();
  @late
  List<dynamic> get createdUtc =>
      wallpaperData.map((e) => e['created_utc']).toList();
  // @late
  // List<dynamic> get wallpaper =>
  //     wallpaperData.map((e) => e['wallpaper']).toList();
  @late
  List<dynamic> get url => wallpaperData.map((e) => e['image']).toList();
  @late
  List<dynamic> get imagebytes =>
      wallpaperData.map((e) => e['imagebytes']).toList();
  @late
  List<dynamic> get imagewidth =>
      wallpaperData.map((e) => e['imagesize'][0]).toList();
  @late
  List<dynamic> get imageheight =>
      wallpaperData.map((e) => e['imagesize'][1]).toList();
}

// @freezed
// abstract class DeleteOperation with _$DeleteOperation {
//   const factory DeleteOperation.delete() = Delete;
// }

@freezed
abstract class Union with _$Union {
  const factory Union() = Data;
  const factory Union.add(List value) = Addvalue;
  const factory Union.delete(int index) = Delete;
}

void crud(
  String child,
  Union crud,
) {
  crud.maybeWhen(() => print("object"),
      add: (value) =>
          FirebaseDatabase.instance.reference().child("$child").set(value),
      delete: (index) =>
          FirebaseDatabase.instance.reference().child("$child$index").remove(),
      orElse: () => print('No such operation'));
}
