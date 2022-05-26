part of 'connectivity_bloc.dart';

@freezed
class ConnectivityState with _$ConnectivityState {
  const ConnectivityState._();

  factory ConnectivityState(ConnectivityResult status) = _ConnnectivityState;
  const factory ConnectivityState.initial() = _ConnectivityStateInitial;

  ConnectivityResult get result => (this as _ConnnectivityState).status;
  bool get isInitial => this is _ConnectivityStateInitial;
}
