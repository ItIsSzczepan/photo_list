// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Failure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String message, dynamic errorObject) $default, {
    required TResult Function() outOfRange,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(String message, dynamic errorObject)? $default, {
    TResult Function()? outOfRange,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String message, dynamic errorObject)? $default, {
    TResult Function()? outOfRange,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Failure value) $default, {
    required TResult Function(OutOfRangeFailure value) outOfRange,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_Failure value)? $default, {
    TResult Function(OutOfRangeFailure value)? outOfRange,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Failure value)? $default, {
    TResult Function(OutOfRangeFailure value)? outOfRange,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res>;
}

/// @nodoc
class _$FailureCopyWithImpl<$Res> implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  final Failure _value;
  // ignore: unused_field
  final $Res Function(Failure) _then;
}

/// @nodoc
abstract class _$$_FailureCopyWith<$Res> {
  factory _$$_FailureCopyWith(
          _$_Failure value, $Res Function(_$_Failure) then) =
      __$$_FailureCopyWithImpl<$Res>;
  $Res call({String message, dynamic errorObject});
}

/// @nodoc
class __$$_FailureCopyWithImpl<$Res> extends _$FailureCopyWithImpl<$Res>
    implements _$$_FailureCopyWith<$Res> {
  __$$_FailureCopyWithImpl(_$_Failure _value, $Res Function(_$_Failure) _then)
      : super(_value, (v) => _then(v as _$_Failure));

  @override
  _$_Failure get _value => super._value as _$_Failure;

  @override
  $Res call({
    Object? message = freezed,
    Object? errorObject = freezed,
  }) {
    return _then(_$_Failure(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      errorObject: errorObject == freezed
          ? _value.errorObject
          : errorObject // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$_Failure extends _Failure {
  const _$_Failure(this.message, {this.errorObject}) : super._();

  @override
  final String message;
  @override
  final dynamic errorObject;

  @override
  String toString() {
    return 'Failure(message: $message, errorObject: $errorObject)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Failure &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality()
                .equals(other.errorObject, errorObject));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(errorObject));

  @JsonKey(ignore: true)
  @override
  _$$_FailureCopyWith<_$_Failure> get copyWith =>
      __$$_FailureCopyWithImpl<_$_Failure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String message, dynamic errorObject) $default, {
    required TResult Function() outOfRange,
  }) {
    return $default(message, errorObject);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(String message, dynamic errorObject)? $default, {
    TResult Function()? outOfRange,
  }) {
    return $default?.call(message, errorObject);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String message, dynamic errorObject)? $default, {
    TResult Function()? outOfRange,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(message, errorObject);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Failure value) $default, {
    required TResult Function(OutOfRangeFailure value) outOfRange,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_Failure value)? $default, {
    TResult Function(OutOfRangeFailure value)? outOfRange,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Failure value)? $default, {
    TResult Function(OutOfRangeFailure value)? outOfRange,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _Failure extends Failure {
  const factory _Failure(final String message, {final dynamic errorObject}) =
      _$_Failure;
  const _Failure._() : super._();

  String get message => throw _privateConstructorUsedError;
  dynamic get errorObject => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_FailureCopyWith<_$_Failure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OutOfRangeFailureCopyWith<$Res> {
  factory _$$OutOfRangeFailureCopyWith(
          _$OutOfRangeFailure value, $Res Function(_$OutOfRangeFailure) then) =
      __$$OutOfRangeFailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OutOfRangeFailureCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res>
    implements _$$OutOfRangeFailureCopyWith<$Res> {
  __$$OutOfRangeFailureCopyWithImpl(
      _$OutOfRangeFailure _value, $Res Function(_$OutOfRangeFailure) _then)
      : super(_value, (v) => _then(v as _$OutOfRangeFailure));

  @override
  _$OutOfRangeFailure get _value => super._value as _$OutOfRangeFailure;
}

/// @nodoc

class _$OutOfRangeFailure extends OutOfRangeFailure {
  const _$OutOfRangeFailure() : super._();

  @override
  String toString() {
    return 'Failure.outOfRange()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OutOfRangeFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String message, dynamic errorObject) $default, {
    required TResult Function() outOfRange,
  }) {
    return outOfRange();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(String message, dynamic errorObject)? $default, {
    TResult Function()? outOfRange,
  }) {
    return outOfRange?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String message, dynamic errorObject)? $default, {
    TResult Function()? outOfRange,
    required TResult orElse(),
  }) {
    if (outOfRange != null) {
      return outOfRange();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Failure value) $default, {
    required TResult Function(OutOfRangeFailure value) outOfRange,
  }) {
    return outOfRange(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_Failure value)? $default, {
    TResult Function(OutOfRangeFailure value)? outOfRange,
  }) {
    return outOfRange?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Failure value)? $default, {
    TResult Function(OutOfRangeFailure value)? outOfRange,
    required TResult orElse(),
  }) {
    if (outOfRange != null) {
      return outOfRange(this);
    }
    return orElse();
  }
}

abstract class OutOfRangeFailure extends Failure {
  const factory OutOfRangeFailure() = _$OutOfRangeFailure;
  const OutOfRangeFailure._() : super._();
}
