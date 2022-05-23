part of 'photos_list_bloc.dart';

enum PhotosListStateStatus { initial, loading, done, error }

class PhotosListState extends Equatable {
  final bool local;
  final GetPhotosQuery query;
  final List<Photo> values;
  final Failure? error;
  final PhotosListStateStatus status;

  const PhotosListState(
      {this.local = false,
      this.query = const GetPhotosQuery(),
      this.values = const [],
      this.error,
      this.status = PhotosListStateStatus.initial});

  factory PhotosListState.initial() => const PhotosListState();

  PhotosListState copyWith(
      {bool? local,
      GetPhotosQuery? query,
      List<Photo>? values,
      Failure? error}) {
    return PhotosListState(
        local: local ?? this.local,
        query: query ?? this.query,
        values: values ?? this.values,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [local, query, props, error];
}
