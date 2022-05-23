import 'package:flutter_test/flutter_test.dart';
import 'package:photo_list/src/bloc/photos/photos_list_bloc.dart';
import 'package:photo_list/src/data/photo_repository.dart';

// ignore: depend_on_referenced_packages
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockPhotoRepository extends Mock implements PhotoRepository {}

void main() {
  late final PhotosListBloc bloc;
  late final PhotoRepository photoRepository;

  setUpAll(() {
    photoRepository = MockPhotoRepository();
    bloc = PhotosListBloc(photoRepository);
  });

  group("PhotosListBloc", () {
    test("bloc should have init state on start", () {
      expect(bloc.state.status, PhotosListStateStatus.initial);
    });

    blocTest<PhotosListBloc, PhotosListState>(
      'should not emit anything',
      build: () => bloc,
      expect: () => [],
    );

    blocTest<PhotosListBloc, PhotosListState>("should load data from local", build: () => bloc, act: (bloc) {
      bloc.add(PhotosListLoad(GetPhotosQuery(), true));
    },
    expect: () => [isA<PhotosListState>().having((p0) => p0.status, "status", PhotosListStateStatus.loading), isA<PhotosListState>().having((p0) => p0.status, "status", PhotosListStateStatus.done)]
    );
  });
}
