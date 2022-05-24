part of 'connectivity_bloc.dart';

abstract class ConnectivityEvent extends Equatable{}

class ConnectivityStart extends ConnectivityEvent{
  @override
  List<Object?> get props => [];
}