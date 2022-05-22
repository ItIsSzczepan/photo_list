import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure{
  factory Failure(String message, {dynamic errorObject}) = _Failure;
  const factory Failure.outOfRange() = OutOfRangeFailure;
}