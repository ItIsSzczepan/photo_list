import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure{
  const Failure._();

  const factory Failure(String message, {dynamic errorObject}) = _Failure;
  const factory Failure.outOfRange() = OutOfRangeFailure;

  String get message => message;
  dynamic get errorObject => errorObject;
}