// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Photo _$PhotoFromJson(Map<String, dynamic> json) {
  return _Photo.fromJson(json);
}

/// @nodoc
mixin _$Photo {
// meta
  @HiveField(0)
  int get id => throw _privateConstructorUsedError; // meta
  @HiveField(0)
  set id(int value) => throw _privateConstructorUsedError;
  @HiveField(1)
  String get tags => throw _privateConstructorUsedError;
  @HiveField(1)
  set tags(String value) => throw _privateConstructorUsedError;
  @HiveField(2)
  int get likes => throw _privateConstructorUsedError;
  @HiveField(2)
  set likes(int value) => throw _privateConstructorUsedError;
  @HiveField(3)
  int get views => throw _privateConstructorUsedError;
  @HiveField(3)
  set views(int value) => throw _privateConstructorUsedError; // photo links
  @HiveField(4)
  String get pageURL => throw _privateConstructorUsedError; // photo links
  @HiveField(4)
  set pageURL(String value) => throw _privateConstructorUsedError;
  @HiveField(5)
  String get previewURL => throw _privateConstructorUsedError;
  @HiveField(5)
  set previewURL(String value) => throw _privateConstructorUsedError;
  @HiveField(6)
  String get webformatURL => throw _privateConstructorUsedError;
  @HiveField(6)
  set webformatURL(String value) => throw _privateConstructorUsedError;
  @HiveField(7)
  String get largeImageURL => throw _privateConstructorUsedError;
  @HiveField(7)
  set largeImageURL(String value) =>
      throw _privateConstructorUsedError; // user data
  @HiveField(8)
  String get user => throw _privateConstructorUsedError; // user data
  @HiveField(8)
  set user(String value) => throw _privateConstructorUsedError;
  @HiveField(9)
  String get userImageURL => throw _privateConstructorUsedError;
  @HiveField(9)
  set userImageURL(String value) =>
      throw _privateConstructorUsedError; // local image
  @HiveField(10)
  List<int>? get imageDataList =>
      throw _privateConstructorUsedError; // local image
  @HiveField(10)
  set imageDataList(List<int>? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PhotoCopyWith<Photo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoCopyWith<$Res> {
  factory $PhotoCopyWith(Photo value, $Res Function(Photo) then) =
      _$PhotoCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) String tags,
      @HiveField(2) int likes,
      @HiveField(3) int views,
      @HiveField(4) String pageURL,
      @HiveField(5) String previewURL,
      @HiveField(6) String webformatURL,
      @HiveField(7) String largeImageURL,
      @HiveField(8) String user,
      @HiveField(9) String userImageURL,
      @HiveField(10) List<int>? imageDataList});
}

/// @nodoc
class _$PhotoCopyWithImpl<$Res> implements $PhotoCopyWith<$Res> {
  _$PhotoCopyWithImpl(this._value, this._then);

  final Photo _value;
  // ignore: unused_field
  final $Res Function(Photo) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? tags = freezed,
    Object? likes = freezed,
    Object? views = freezed,
    Object? pageURL = freezed,
    Object? previewURL = freezed,
    Object? webformatURL = freezed,
    Object? largeImageURL = freezed,
    Object? user = freezed,
    Object? userImageURL = freezed,
    Object? imageDataList = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String,
      likes: likes == freezed
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      views: views == freezed
          ? _value.views
          : views // ignore: cast_nullable_to_non_nullable
              as int,
      pageURL: pageURL == freezed
          ? _value.pageURL
          : pageURL // ignore: cast_nullable_to_non_nullable
              as String,
      previewURL: previewURL == freezed
          ? _value.previewURL
          : previewURL // ignore: cast_nullable_to_non_nullable
              as String,
      webformatURL: webformatURL == freezed
          ? _value.webformatURL
          : webformatURL // ignore: cast_nullable_to_non_nullable
              as String,
      largeImageURL: largeImageURL == freezed
          ? _value.largeImageURL
          : largeImageURL // ignore: cast_nullable_to_non_nullable
              as String,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String,
      userImageURL: userImageURL == freezed
          ? _value.userImageURL
          : userImageURL // ignore: cast_nullable_to_non_nullable
              as String,
      imageDataList: imageDataList == freezed
          ? _value.imageDataList
          : imageDataList // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
abstract class _$$_PhotoCopyWith<$Res> implements $PhotoCopyWith<$Res> {
  factory _$$_PhotoCopyWith(_$_Photo value, $Res Function(_$_Photo) then) =
      __$$_PhotoCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) String tags,
      @HiveField(2) int likes,
      @HiveField(3) int views,
      @HiveField(4) String pageURL,
      @HiveField(5) String previewURL,
      @HiveField(6) String webformatURL,
      @HiveField(7) String largeImageURL,
      @HiveField(8) String user,
      @HiveField(9) String userImageURL,
      @HiveField(10) List<int>? imageDataList});
}

/// @nodoc
class __$$_PhotoCopyWithImpl<$Res> extends _$PhotoCopyWithImpl<$Res>
    implements _$$_PhotoCopyWith<$Res> {
  __$$_PhotoCopyWithImpl(_$_Photo _value, $Res Function(_$_Photo) _then)
      : super(_value, (v) => _then(v as _$_Photo));

  @override
  _$_Photo get _value => super._value as _$_Photo;

  @override
  $Res call({
    Object? id = freezed,
    Object? tags = freezed,
    Object? likes = freezed,
    Object? views = freezed,
    Object? pageURL = freezed,
    Object? previewURL = freezed,
    Object? webformatURL = freezed,
    Object? largeImageURL = freezed,
    Object? user = freezed,
    Object? userImageURL = freezed,
    Object? imageDataList = freezed,
  }) {
    return _then(_$_Photo(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String,
      likes: likes == freezed
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      views: views == freezed
          ? _value.views
          : views // ignore: cast_nullable_to_non_nullable
              as int,
      pageURL: pageURL == freezed
          ? _value.pageURL
          : pageURL // ignore: cast_nullable_to_non_nullable
              as String,
      previewURL: previewURL == freezed
          ? _value.previewURL
          : previewURL // ignore: cast_nullable_to_non_nullable
              as String,
      webformatURL: webformatURL == freezed
          ? _value.webformatURL
          : webformatURL // ignore: cast_nullable_to_non_nullable
              as String,
      largeImageURL: largeImageURL == freezed
          ? _value.largeImageURL
          : largeImageURL // ignore: cast_nullable_to_non_nullable
              as String,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String,
      userImageURL: userImageURL == freezed
          ? _value.userImageURL
          : userImageURL // ignore: cast_nullable_to_non_nullable
              as String,
      imageDataList: imageDataList == freezed
          ? _value.imageDataList
          : imageDataList // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 1, adapterName: "PhotoAdapter")
class _$_Photo extends _Photo {
  _$_Photo(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.tags,
      @HiveField(2) required this.likes,
      @HiveField(3) required this.views,
      @HiveField(4) required this.pageURL,
      @HiveField(5) required this.previewURL,
      @HiveField(6) required this.webformatURL,
      @HiveField(7) required this.largeImageURL,
      @HiveField(8) required this.user,
      @HiveField(9) required this.userImageURL,
      @HiveField(10) this.imageDataList})
      : super._();

  factory _$_Photo.fromJson(Map<String, dynamic> json) =>
      _$$_PhotoFromJson(json);

// meta
  @override
  @HiveField(0)
  int id;
  @override
  @HiveField(1)
  String tags;
  @override
  @HiveField(2)
  int likes;
  @override
  @HiveField(3)
  int views;
// photo links
  @override
  @HiveField(4)
  String pageURL;
  @override
  @HiveField(5)
  String previewURL;
  @override
  @HiveField(6)
  String webformatURL;
  @override
  @HiveField(7)
  String largeImageURL;
// user data
  @override
  @HiveField(8)
  String user;
  @override
  @HiveField(9)
  String userImageURL;
// local image
  @override
  @HiveField(10)
  List<int>? imageDataList;

  @override
  String toString() {
    return 'Photo(id: $id, tags: $tags, likes: $likes, views: $views, pageURL: $pageURL, previewURL: $previewURL, webformatURL: $webformatURL, largeImageURL: $largeImageURL, user: $user, userImageURL: $userImageURL, imageDataList: $imageDataList)';
  }

  @JsonKey(ignore: true)
  @override
  _$$_PhotoCopyWith<_$_Photo> get copyWith =>
      __$$_PhotoCopyWithImpl<_$_Photo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PhotoToJson(this);
  }
}

abstract class _Photo extends Photo {
  factory _Photo(
      {@HiveField(0) required int id,
      @HiveField(1) required String tags,
      @HiveField(2) required int likes,
      @HiveField(3) required int views,
      @HiveField(4) required String pageURL,
      @HiveField(5) required String previewURL,
      @HiveField(6) required String webformatURL,
      @HiveField(7) required String largeImageURL,
      @HiveField(8) required String user,
      @HiveField(9) required String userImageURL,
      @HiveField(10) List<int>? imageDataList}) = _$_Photo;
  _Photo._() : super._();

  factory _Photo.fromJson(Map<String, dynamic> json) = _$_Photo.fromJson;

  @override // meta
  @HiveField(0)
  int get id => throw _privateConstructorUsedError;
  @override
  @HiveField(1)
  String get tags => throw _privateConstructorUsedError;
  @override
  @HiveField(2)
  int get likes => throw _privateConstructorUsedError;
  @override
  @HiveField(3)
  int get views => throw _privateConstructorUsedError;
  @override // photo links
  @HiveField(4)
  String get pageURL => throw _privateConstructorUsedError;
  @override
  @HiveField(5)
  String get previewURL => throw _privateConstructorUsedError;
  @override
  @HiveField(6)
  String get webformatURL => throw _privateConstructorUsedError;
  @override
  @HiveField(7)
  String get largeImageURL => throw _privateConstructorUsedError;
  @override // user data
  @HiveField(8)
  String get user => throw _privateConstructorUsedError;
  @override
  @HiveField(9)
  String get userImageURL => throw _privateConstructorUsedError;
  @override // local image
  @HiveField(10)
  List<int>? get imageDataList => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PhotoCopyWith<_$_Photo> get copyWith =>
      throw _privateConstructorUsedError;
}
