part of 'connectivity_bloc.dart';

@freezed
class ConnectivityState with _$ConnectivityState {
  const factory ConnectivityState(ConnectivityResult status) = _ConnnectivityState;
  const factory ConnectivityState.initial() = _ConnnectivityStateInitial;
}
