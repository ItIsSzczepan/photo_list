import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_list/src/core/failure.dart';
import 'package:photo_list/src/data/photo_repository.dart';
import 'package:photo_list/src/model/photo.dart';

part 'photos_list_event.dart';

part 'photos_list_state.dart';

class PhotosListBloc extends Bloc<PhotosListEvent, PhotosListState> {
  final PhotoRepository _photoRepository;

  PhotosListBloc(this._photoRepository) : super(PhotosListState.initial()) {
    on<PhotosListLoad>((event, emit) async {
      event.local
          ? await _loadLocal(event.query, emit)
          : await _loadFromApi(event.query, emit);
    });

    on<PhotosListLoadMore>((event, emit) async {
      await _loadMoreData(emit);
    });
  }

  _loadFromApi(GetPhotosQuery query, Emitter<PhotosListState> emit) async {
    // emit load state
    emit(PhotosListState(
        local: false,
        query: query,
        values: const [],
        status: PhotosListStateStatus.loading));

    Either<Failure, List<Photo>> result =
        await _photoRepository.getPhotosFromApi(query);

    await result.fold((l) async {
      // ON FAILURE
      emit(await state.copyWith(status: PhotosListStateStatus.error, error: l));
    }, (r) async{
      // ON SUCCESS
      emit(await state.copyWith(status: PhotosListStateStatus.done, values: r));
    });
  }

  _loadLocal(GetPhotosQuery query, Emitter<PhotosListState> emit) {
    // emit load state
    emit(PhotosListState(
        local: true,
        query: query,
        values: const [],
        status: PhotosListStateStatus.loading));

    Either<Failure, List<Photo>> result = _photoRepository.getLocalPhotosList();

    result.fold((l) {
      // ON FAILURE
      emit(state.copyWith(status: PhotosListStateStatus.error, error: l));
    }, (r) {
      // ON SUCCESS
      // filter and sort list
      List<Photo> value = _filterList(query, r);
      value = _sortList(query, value);

      emit(state.copyWith(status: PhotosListStateStatus.done, values: value));
    });
  }

  List<Photo> _filterList(GetPhotosQuery query, List<Photo> list) {
    list = List.from(list);
    if (query.q != null) {
      return list.where((element) => element.tags.contains(query.q!)).toList();
    } else {
      return list;
    }
  }

  List<Photo> _sortList(GetPhotosQuery query, List<Photo> list) {
    list = List.from(list);
    if (query.order != null) {
      switch (query.order) {
        case "popular":
          list.sort((a, b) => a.likes.compareTo(b.likes));
          list = list.reversed.toList();
          break;
        case "latest":
          list.sort((a, b) => a.views.compareTo(b.views));
          break;
      }
    }
    return list;
  }

  _loadMoreData(Emitter<PhotosListState> emit) async {
    // emit loading state
    emit(state.copyWith(status: PhotosListStateStatus.loading));

    GetPhotosQuery query = state.query;
    // if page == null then page = 2 else page++
    if(query.page == null) {
      query = query.copyWith(page: 2);
    } else {
      query = query.copyWith(page: query.page! + 1);
    }

    Either<Failure, List<Photo>> result = await _photoRepository.getPhotosFromApi(query);
    result.fold((l){
      // ON FAILURE
      emit(state.copyWith(status: PhotosListStateStatus.error, error: l));
    }, (r){
      // ON SUCCESS
      List<Photo> values = List.from(state.values);
      List<Photo> valuesFromApi = r;

      values.addAll(valuesFromApi);

      emit(state.copyWith(status: PhotosListStateStatus.done, values: values));
    });
  }
}
