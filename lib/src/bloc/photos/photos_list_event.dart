part of 'photos_list_bloc.dart';

abstract class PhotosListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PhotosListLoadMore extends PhotosListEvent{}

class PhotosListLoad extends PhotosListEvent{
  final GetPhotosQuery query;
  final bool local;

  PhotosListLoad(this.query, this.local);

  @override
  List<Object?> get props => [query, local];
}
