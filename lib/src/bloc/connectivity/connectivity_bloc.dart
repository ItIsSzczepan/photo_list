import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';
part 'connectivity_bloc.freezed.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  late StreamSubscription _connectivityStream;
  final Connectivity _connectivity;

  ConnectivityBloc(this._connectivity) : super(const ConnectivityState.initial()) {
    on<ConnectivityStart>((event, emit) async {
      _connectivityStream = await _connectivity.onConnectivityChanged.listen((result) {
        if(emit.isDone){
          emit(ConnectivityState(result));
        }
      });
    });
  }

  @override
  Future<void> close(){
    _connectivityStream.cancel();
    return super.close();
  }
}
