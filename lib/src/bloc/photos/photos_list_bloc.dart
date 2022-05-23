import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_list/src/core/failure.dart';
import 'package:photo_list/src/data/photo_repository.dart';
import 'package:photo_list/src/model/photo.dart';

part 'photos_list_event.dart';
part 'photos_list_state.dart';

class PhotosListBloc extends Bloc<PhotosListEvent, PhotosListState> {
  PhotosListBloc() : super(PhotosListState.initial()) {
    on<PhotosListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
