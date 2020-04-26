// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'wallpaper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$WallpaperTearOff {
  const _$WallpaperTearOff();

  _Wallpaper call(List<dynamic> wallpaperData) {
    return _Wallpaper(
      wallpaperData,
    );
  }
}

// ignore: unused_element
const $Wallpaper = _$WallpaperTearOff();

mixin _$Wallpaper {
  List<dynamic> get wallpaperData;

  $WallpaperCopyWith<Wallpaper> get copyWith;
}

abstract class $WallpaperCopyWith<$Res> {
  factory $WallpaperCopyWith(Wallpaper value, $Res Function(Wallpaper) then) =
      _$WallpaperCopyWithImpl<$Res>;
  $Res call({List<dynamic> wallpaperData});
}

class _$WallpaperCopyWithImpl<$Res> implements $WallpaperCopyWith<$Res> {
  _$WallpaperCopyWithImpl(this._value, this._then);

  final Wallpaper _value;
  // ignore: unused_field
  final $Res Function(Wallpaper) _then;

  @override
  $Res call({
    Object wallpaperData = freezed,
  }) {
    return _then(_value.copyWith(
      wallpaperData: wallpaperData == freezed
          ? _value.wallpaperData
          : wallpaperData as List<dynamic>,
    ));
  }
}

abstract class _$WallpaperCopyWith<$Res> implements $WallpaperCopyWith<$Res> {
  factory _$WallpaperCopyWith(
          _Wallpaper value, $Res Function(_Wallpaper) then) =
      __$WallpaperCopyWithImpl<$Res>;
  @override
  $Res call({List<dynamic> wallpaperData});
}

class __$WallpaperCopyWithImpl<$Res> extends _$WallpaperCopyWithImpl<$Res>
    implements _$WallpaperCopyWith<$Res> {
  __$WallpaperCopyWithImpl(_Wallpaper _value, $Res Function(_Wallpaper) _then)
      : super(_value, (v) => _then(v as _Wallpaper));

  @override
  _Wallpaper get _value => super._value as _Wallpaper;

  @override
  $Res call({
    Object wallpaperData = freezed,
  }) {
    return _then(_Wallpaper(
      wallpaperData == freezed
          ? _value.wallpaperData
          : wallpaperData as List<dynamic>,
    ));
  }
}

class _$_Wallpaper with DiagnosticableTreeMixin implements _Wallpaper {
  _$_Wallpaper(this.wallpaperData) : assert(wallpaperData != null);

  @override
  final List<dynamic> wallpaperData;

  bool _didtitle = false;
  List<dynamic> _title;

  @override
  List<dynamic> get title {
    if (_didtitle == false) {
      _didtitle = true;
      _title = wallpaperData.map((e) => e['title']).toList();
    }
    return _title;
  }

  bool _didauthor = false;
  List<dynamic> _author;

  @override
  List<dynamic> get author {
    if (_didauthor == false) {
      _didauthor = true;
      _author = wallpaperData.map((e) => e['author']).toList();
    }
    return _author;
  }

  bool _didpreview = false;
  List<dynamic> _preview;

  @override
  List<dynamic> get preview {
    if (_didpreview == false) {
      _didpreview = true;
      _preview = wallpaperData.map((e) => e['preview']).toList();
    }
    return _preview;
  }

  bool _didpermalink = false;
  List<dynamic> _permalink;

  @override
  List<dynamic> get permalink {
    if (_didpermalink == false) {
      _didpermalink = true;
      _permalink = wallpaperData.map((e) => e['permalink']).toList();
    }
    return _permalink;
  }

  bool _didimage = false;
  List<dynamic> _image;

  @override
  List<dynamic> get image {
    if (_didimage == false) {
      _didimage = true;
      _image = wallpaperData.map((e) => e['image']).toList();
    }
    return _image;
  }

  bool _didups = false;
  List<dynamic> _ups;

  @override
  List<dynamic> get ups {
    if (_didups == false) {
      _didups = true;
      _ups = wallpaperData.map((e) => e['ups']).toList();
    }
    return _ups;
  }

  bool _didcreatedUtc = false;
  List<dynamic> _createdUtc;

  @override
  List<dynamic> get createdUtc {
    if (_didcreatedUtc == false) {
      _didcreatedUtc = true;
      _createdUtc = wallpaperData.map((e) => e['created_utc']).toList();
    }
    return _createdUtc;
  }

  bool _didwallpaper = false;
  List<dynamic> _wallpaper;

  @override
  List<dynamic> get wallpaper {
    if (_didwallpaper == false) {
      _didwallpaper = true;
      _wallpaper = wallpaperData.map((e) => e['wallpaper']).toList();
    }
    return _wallpaper;
  }

  bool _didurl = false;
  List<dynamic> _url;

  @override
  List<dynamic> get url {
    if (_didurl == false) {
      _didurl = true;
      _url = wallpaperData.map((e) => e['image']).toList();
    }
    return _url;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Wallpaper(wallpaperData: $wallpaperData, title: $title, author: $author, preview: $preview, permalink: $permalink, image: $image, ups: $ups, createdUtc: $createdUtc, wallpaper: $wallpaper, url: $url)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Wallpaper'))
      ..add(DiagnosticsProperty('wallpaperData', wallpaperData))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('author', author))
      ..add(DiagnosticsProperty('preview', preview))
      ..add(DiagnosticsProperty('permalink', permalink))
      ..add(DiagnosticsProperty('image', image))
      ..add(DiagnosticsProperty('ups', ups))
      ..add(DiagnosticsProperty('createdUtc', createdUtc))
      ..add(DiagnosticsProperty('wallpaper', wallpaper))
      ..add(DiagnosticsProperty('url', url));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Wallpaper &&
            (identical(other.wallpaperData, wallpaperData) ||
                const DeepCollectionEquality()
                    .equals(other.wallpaperData, wallpaperData)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(wallpaperData);

  @override
  _$WallpaperCopyWith<_Wallpaper> get copyWith =>
      __$WallpaperCopyWithImpl<_Wallpaper>(this, _$identity);
}

abstract class _Wallpaper implements Wallpaper {
  factory _Wallpaper(List<dynamic> wallpaperData) = _$_Wallpaper;

  @override
  List<dynamic> get wallpaperData;
  @override
  _$WallpaperCopyWith<_Wallpaper> get copyWith;
}

class _$UnionTearOff {
  const _$UnionTearOff();

  Data call() {
    return const Data();
  }

  Addvalue add(List<dynamic> value) {
    return Addvalue(
      value,
    );
  }

  Delete delete(int index) {
    return Delete(
      index,
    );
  }
}

// ignore: unused_element
const $Union = _$UnionTearOff();

mixin _$Union {
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(), {
    @required Result add(List<dynamic> value),
    @required Result delete(int index),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(), {
    Result add(List<dynamic> value),
    Result delete(int index),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(Data value), {
    @required Result add(Addvalue value),
    @required Result delete(Delete value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(Data value), {
    Result add(Addvalue value),
    Result delete(Delete value),
    @required Result orElse(),
  });
}

abstract class $UnionCopyWith<$Res> {
  factory $UnionCopyWith(Union value, $Res Function(Union) then) =
      _$UnionCopyWithImpl<$Res>;
}

class _$UnionCopyWithImpl<$Res> implements $UnionCopyWith<$Res> {
  _$UnionCopyWithImpl(this._value, this._then);

  final Union _value;
  // ignore: unused_field
  final $Res Function(Union) _then;
}

abstract class $DataCopyWith<$Res> {
  factory $DataCopyWith(Data value, $Res Function(Data) then) =
      _$DataCopyWithImpl<$Res>;
}

class _$DataCopyWithImpl<$Res> extends _$UnionCopyWithImpl<$Res>
    implements $DataCopyWith<$Res> {
  _$DataCopyWithImpl(Data _value, $Res Function(Data) _then)
      : super(_value, (v) => _then(v as Data));

  @override
  Data get _value => super._value as Data;
}

class _$Data with DiagnosticableTreeMixin implements Data {
  const _$Data();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Union()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'Union'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Data);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(), {
    @required Result add(List<dynamic> value),
    @required Result delete(int index),
  }) {
    assert($default != null);
    assert(add != null);
    assert(delete != null);
    return $default();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(), {
    Result add(List<dynamic> value),
    Result delete(int index),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(Data value), {
    @required Result add(Addvalue value),
    @required Result delete(Delete value),
  }) {
    assert($default != null);
    assert(add != null);
    assert(delete != null);
    return $default(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(Data value), {
    Result add(Addvalue value),
    Result delete(Delete value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class Data implements Union {
  const factory Data() = _$Data;
}

abstract class $AddvalueCopyWith<$Res> {
  factory $AddvalueCopyWith(Addvalue value, $Res Function(Addvalue) then) =
      _$AddvalueCopyWithImpl<$Res>;
  $Res call({List<dynamic> value});
}

class _$AddvalueCopyWithImpl<$Res> extends _$UnionCopyWithImpl<$Res>
    implements $AddvalueCopyWith<$Res> {
  _$AddvalueCopyWithImpl(Addvalue _value, $Res Function(Addvalue) _then)
      : super(_value, (v) => _then(v as Addvalue));

  @override
  Addvalue get _value => super._value as Addvalue;

  @override
  $Res call({
    Object value = freezed,
  }) {
    return _then(Addvalue(
      value == freezed ? _value.value : value as List<dynamic>,
    ));
  }
}

class _$Addvalue with DiagnosticableTreeMixin implements Addvalue {
  const _$Addvalue(this.value) : assert(value != null);

  @override
  final List<dynamic> value;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Union.add(value: $value)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Union.add'))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Addvalue &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);

  @override
  $AddvalueCopyWith<Addvalue> get copyWith =>
      _$AddvalueCopyWithImpl<Addvalue>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(), {
    @required Result add(List<dynamic> value),
    @required Result delete(int index),
  }) {
    assert($default != null);
    assert(add != null);
    assert(delete != null);
    return add(value);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(), {
    Result add(List<dynamic> value),
    Result delete(int index),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (add != null) {
      return add(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(Data value), {
    @required Result add(Addvalue value),
    @required Result delete(Delete value),
  }) {
    assert($default != null);
    assert(add != null);
    assert(delete != null);
    return add(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(Data value), {
    Result add(Addvalue value),
    Result delete(Delete value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (add != null) {
      return add(this);
    }
    return orElse();
  }
}

abstract class Addvalue implements Union {
  const factory Addvalue(List<dynamic> value) = _$Addvalue;

  List<dynamic> get value;
  $AddvalueCopyWith<Addvalue> get copyWith;
}

abstract class $DeleteCopyWith<$Res> {
  factory $DeleteCopyWith(Delete value, $Res Function(Delete) then) =
      _$DeleteCopyWithImpl<$Res>;
  $Res call({int index});
}

class _$DeleteCopyWithImpl<$Res> extends _$UnionCopyWithImpl<$Res>
    implements $DeleteCopyWith<$Res> {
  _$DeleteCopyWithImpl(Delete _value, $Res Function(Delete) _then)
      : super(_value, (v) => _then(v as Delete));

  @override
  Delete get _value => super._value as Delete;

  @override
  $Res call({
    Object index = freezed,
  }) {
    return _then(Delete(
      index == freezed ? _value.index : index as int,
    ));
  }
}

class _$Delete with DiagnosticableTreeMixin implements Delete {
  const _$Delete(this.index) : assert(index != null);

  @override
  final int index;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Union.delete(index: $index)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Union.delete'))
      ..add(DiagnosticsProperty('index', index));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Delete &&
            (identical(other.index, index) ||
                const DeepCollectionEquality().equals(other.index, index)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(index);

  @override
  $DeleteCopyWith<Delete> get copyWith =>
      _$DeleteCopyWithImpl<Delete>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>(
    Result $default(), {
    @required Result add(List<dynamic> value),
    @required Result delete(int index),
  }) {
    assert($default != null);
    assert(add != null);
    assert(delete != null);
    return delete(index);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>(
    Result $default(), {
    Result add(List<dynamic> value),
    Result delete(int index),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (delete != null) {
      return delete(index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>(
    Result $default(Data value), {
    @required Result add(Addvalue value),
    @required Result delete(Delete value),
  }) {
    assert($default != null);
    assert(add != null);
    assert(delete != null);
    return delete(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>(
    Result $default(Data value), {
    Result add(Addvalue value),
    Result delete(Delete value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (delete != null) {
      return delete(this);
    }
    return orElse();
  }
}

abstract class Delete implements Union {
  const factory Delete(int index) = _$Delete;

  int get index;
  $DeleteCopyWith<Delete> get copyWith;
}
