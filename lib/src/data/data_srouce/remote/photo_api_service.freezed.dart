// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'photo_api_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PhotosPage _$PhotosPageFromJson(Map<String, dynamic> json) {
  return _PhotosPage.fromJson(json);
}

/// @nodoc
mixin _$PhotosPage {
  int get total => throw _privateConstructorUsedError;
  int get totalHits => throw _privateConstructorUsedError;
  @JsonKey(name: "hits")
  List<Photo> get photos => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PhotosPageCopyWith<PhotosPage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotosPageCopyWith<$Res> {
  factory $PhotosPageCopyWith(
          PhotosPage value, $Res Function(PhotosPage) then) =
      _$PhotosPageCopyWithImpl<$Res>;
  $Res call(
      {int total, int totalHits, @JsonKey(name: "hits") List<Photo> photos});
}

/// @nodoc
class _$PhotosPageCopyWithImpl<$Res> implements $PhotosPageCopyWith<$Res> {
  _$PhotosPageCopyWithImpl(this._value, this._then);

  final PhotosPage _value;
  // ignore: unused_field
  final $Res Function(PhotosPage) _then;

  @override
  $Res call({
    Object? total = freezed,
    Object? totalHits = freezed,
    Object? photos = freezed,
  }) {
    return _then(_value.copyWith(
      total: total == freezed
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      totalHits: totalHits == freezed
          ? _value.totalHits
          : totalHits // ignore: cast_nullable_to_non_nullable
              as int,
      photos: photos == freezed
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<Photo>,
    ));
  }
}

/// @nodoc
abstract class _$$_PhotosPageCopyWith<$Res>
    implements $PhotosPageCopyWith<$Res> {
  factory _$$_PhotosPageCopyWith(
          _$_PhotosPage value, $Res Function(_$_PhotosPage) then) =
      __$$_PhotosPageCopyWithImpl<$Res>;
  @override
  $Res call(
      {int total, int totalHits, @JsonKey(name: "hits") List<Photo> photos});
}

/// @nodoc
class __$$_PhotosPageCopyWithImpl<$Res> extends _$PhotosPageCopyWithImpl<$Res>
    implements _$$_PhotosPageCopyWith<$Res> {
  __$$_PhotosPageCopyWithImpl(
      _$_PhotosPage _value, $Res Function(_$_PhotosPage) _then)
      : super(_value, (v) => _then(v as _$_PhotosPage));

  @override
  _$_PhotosPage get _value => super._value as _$_PhotosPage;

  @override
  $Res call({
    Object? total = freezed,
    Object? totalHits = freezed,
    Object? photos = freezed,
  }) {
    return _then(_$_PhotosPage(
      total: total == freezed
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      totalHits: totalHits == freezed
          ? _value.totalHits
          : totalHits // ignore: cast_nullable_to_non_nullable
              as int,
      photos: photos == freezed
          ? _value._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<Photo>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PhotosPage with DiagnosticableTreeMixin implements _PhotosPage {
  const _$_PhotosPage(
      {required this.total,
      required this.totalHits,
      @JsonKey(name: "hits") required final List<Photo> photos})
      : _photos = photos;

  factory _$_PhotosPage.fromJson(Map<String, dynamic> json) =>
      _$$_PhotosPageFromJson(json);

  @override
  final int total;
  @override
  final int totalHits;
  final List<Photo> _photos;
  @override
  @JsonKey(name: "hits")
  List<Photo> get photos {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photos);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PhotosPage(total: $total, totalHits: $totalHits, photos: $photos)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PhotosPage'))
      ..add(DiagnosticsProperty('total', total))
      ..add(DiagnosticsProperty('totalHits', totalHits))
      ..add(DiagnosticsProperty('photos', photos));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PhotosPage &&
            const DeepCollectionEquality().equals(other.total, total) &&
            const DeepCollectionEquality().equals(other.totalHits, totalHits) &&
            const DeepCollectionEquality().equals(other._photos, _photos));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(total),
      const DeepCollectionEquality().hash(totalHits),
      const DeepCollectionEquality().hash(_photos));

  @JsonKey(ignore: true)
  @override
  _$$_PhotosPageCopyWith<_$_PhotosPage> get copyWith =>
      __$$_PhotosPageCopyWithImpl<_$_PhotosPage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PhotosPageToJson(this);
  }
}

abstract class _PhotosPage implements PhotosPage {
  const factory _PhotosPage(
          {required final int total,
          required final int totalHits,
          @JsonKey(name: "hits") required final List<Photo> photos}) =
      _$_PhotosPage;

  factory _PhotosPage.fromJson(Map<String, dynamic> json) =
      _$_PhotosPage.fromJson;

  @override
  int get total => throw _privateConstructorUsedError;
  @override
  int get totalHits => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "hits")
  List<Photo> get photos => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PhotosPageCopyWith<_$_PhotosPage> get copyWith =>
      throw _privateConstructorUsedError;
}
