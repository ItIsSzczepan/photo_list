// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'connectivity_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ConnectivityState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(ConnectivityResult status) $default, {
    required TResult Function() initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(ConnectivityResult status)? $default, {
    TResult Function()? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(ConnectivityResult status)? $default, {
    TResult Function()? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ConnnectivityState value) $default, {
    required TResult Function(_ConnectivityStateInitial value) initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_ConnnectivityState value)? $default, {
    TResult Function(_ConnectivityStateInitial value)? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ConnnectivityState value)? $default, {
    TResult Function(_ConnectivityStateInitial value)? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectivityStateCopyWith<$Res> {
  factory $ConnectivityStateCopyWith(
          ConnectivityState value, $Res Function(ConnectivityState) then) =
      _$ConnectivityStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ConnectivityStateCopyWithImpl<$Res>
    implements $ConnectivityStateCopyWith<$Res> {
  _$ConnectivityStateCopyWithImpl(this._value, this._then);

  final ConnectivityState _value;
  // ignore: unused_field
  final $Res Function(ConnectivityState) _then;
}

/// @nodoc
abstract class _$$_ConnnectivityStateCopyWith<$Res> {
  factory _$$_ConnnectivityStateCopyWith(_$_ConnnectivityState value,
          $Res Function(_$_ConnnectivityState) then) =
      __$$_ConnnectivityStateCopyWithImpl<$Res>;
  $Res call({ConnectivityResult status});
}

/// @nodoc
class __$$_ConnnectivityStateCopyWithImpl<$Res>
    extends _$ConnectivityStateCopyWithImpl<$Res>
    implements _$$_ConnnectivityStateCopyWith<$Res> {
  __$$_ConnnectivityStateCopyWithImpl(
      _$_ConnnectivityState _value, $Res Function(_$_ConnnectivityState) _then)
      : super(_value, (v) => _then(v as _$_ConnnectivityState));

  @override
  _$_ConnnectivityState get _value => super._value as _$_ConnnectivityState;

  @override
  $Res call({
    Object? status = freezed,
  }) {
    return _then(_$_ConnnectivityState(
      status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ConnectivityResult,
    ));
  }
}

/// @nodoc

class _$_ConnnectivityState extends _ConnnectivityState {
  _$_ConnnectivityState(this.status) : super._();

  @override
  final ConnectivityResult status;

  @override
  String toString() {
    return 'ConnectivityState(status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConnnectivityState &&
            const DeepCollectionEquality().equals(other.status, status));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(status));

  @JsonKey(ignore: true)
  @override
  _$$_ConnnectivityStateCopyWith<_$_ConnnectivityState> get copyWith =>
      __$$_ConnnectivityStateCopyWithImpl<_$_ConnnectivityState>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(ConnectivityResult status) $default, {
    required TResult Function() initial,
  }) {
    return $default(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(ConnectivityResult status)? $default, {
    TResult Function()? initial,
  }) {
    return $default?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(ConnectivityResult status)? $default, {
    TResult Function()? initial,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ConnnectivityState value) $default, {
    required TResult Function(_ConnectivityStateInitial value) initial,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_ConnnectivityState value)? $default, {
    TResult Function(_ConnectivityStateInitial value)? initial,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ConnnectivityState value)? $default, {
    TResult Function(_ConnectivityStateInitial value)? initial,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _ConnnectivityState extends ConnectivityState {
  factory _ConnnectivityState(final ConnectivityResult status) =
      _$_ConnnectivityState;
  _ConnnectivityState._() : super._();

  ConnectivityResult get status => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_ConnnectivityStateCopyWith<_$_ConnnectivityState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ConnectivityStateInitialCopyWith<$Res> {
  factory _$$_ConnectivityStateInitialCopyWith(
          _$_ConnectivityStateInitial value,
          $Res Function(_$_ConnectivityStateInitial) then) =
      __$$_ConnectivityStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_ConnectivityStateInitialCopyWithImpl<$Res>
    extends _$ConnectivityStateCopyWithImpl<$Res>
    implements _$$_ConnectivityStateInitialCopyWith<$Res> {
  __$$_ConnectivityStateInitialCopyWithImpl(_$_ConnectivityStateInitial _value,
      $Res Function(_$_ConnectivityStateInitial) _then)
      : super(_value, (v) => _then(v as _$_ConnectivityStateInitial));

  @override
  _$_ConnectivityStateInitial get _value =>
      super._value as _$_ConnectivityStateInitial;
}

/// @nodoc

class _$_ConnectivityStateInitial extends _ConnectivityStateInitial {
  const _$_ConnectivityStateInitial() : super._();

  @override
  String toString() {
    return 'ConnectivityState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConnectivityStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(ConnectivityResult status) $default, {
    required TResult Function() initial,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(ConnectivityResult status)? $default, {
    TResult Function()? initial,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(ConnectivityResult status)? $default, {
    TResult Function()? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ConnnectivityState value) $default, {
    required TResult Function(_ConnectivityStateInitial value) initial,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(_ConnnectivityState value)? $default, {
    TResult Function(_ConnectivityStateInitial value)? initial,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ConnnectivityState value)? $default, {
    TResult Function(_ConnectivityStateInitial value)? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _ConnectivityStateInitial extends ConnectivityState {
  const factory _ConnectivityStateInitial() = _$_ConnectivityStateInitial;
  const _ConnectivityStateInitial._() : super._();
}
