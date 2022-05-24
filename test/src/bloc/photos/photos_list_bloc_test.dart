import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:photo_list/src/bloc/photos/photos_list_bloc.dart';
import 'package:photo_list/src/core/failure.dart';
import 'package:photo_list/src/data/photo_repository.dart';

// ignore: depend_on_referenced_packages
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:photo_list/src/model/photo.dart';

import '../../test_models.dart';

class MockPhotoRepository extends Mock implements PhotoRepository {}

void main() {
  late PhotosListBloc bloc;
  late final PhotoRepository photoRepository;

  setUpAll(() {
    registerFallbackValue(const GetPhotosQuery());

    photoRepository = MockPhotoRepository();
  });

  setUp((){
    bloc = PhotosListBloc(photoRepository);

    reset(photoRepository);

    when(() => photoRepository.getLocalPhotosList())
        .thenReturn(Right(examplePhotosPage.photos));
    when(() => photoRepository.getPhotosFromApi(any()))
        .thenAnswer((_) async => Right(examplePhotosPage.photos));
  });

  group("PhotosListBloc", () {
    test("bloc should have init state on start", () {
      expect(bloc.state.status, PhotosListStateStatus.initial);
    });

    blocTest<PhotosListBloc, PhotosListState>("should load data from local",
        build: () => bloc,
        act: (bloc) {
          bloc.add(PhotosListLoad(const GetPhotosQuery(), true));
        },
        expect: () => [
              // loading state with local = true
              isA<PhotosListState>()
                  .having(
                    (p0) => p0.status,
                    "status",
                    PhotosListStateStatus.loading,
                  )
                  .having((p0) => p0.local, "local", true),
              // done state with local = true
              isA<PhotosListState>()
                  .having(
                      (p0) => p0.status, "status", PhotosListStateStatus.done)
                  .having((p0) => p0.local, "local", true)
            ],
        verify: (_) {
          verify(() => photoRepository.getLocalPhotosList()).called(1);
        });

    blocTest<PhotosListBloc, PhotosListState>("should load data from api",
        build: () => bloc,
        act: (bloc) => bloc.add(PhotosListLoad(const GetPhotosQuery(), false)),
        expect: () => [
              // loading state with local = false
              isA<PhotosListState>()
                  .having(
                    (p0) => p0.status,
                    "status",
                    PhotosListStateStatus.loading,
                  )
                  .having((p0) => p0.local, "local", false),
              // done state with local = false
              isA<PhotosListState>()
                  .having(
                      (p0) => p0.status, "status", PhotosListStateStatus.done)
                  .having((p0) => p0.local, "local", false)
            ],
        verify: (_) {
          verify(() => photoRepository.getPhotosFromApi(any())).called(1);
        });

    blocTest<PhotosListBloc, PhotosListState>("should change query on the same as in event",
        build: () => bloc,
        act: (bloc) {
          bloc.add(PhotosListLoad(const GetPhotosQuery(editors_choice: true), false));
        },
        expect: () => [
              // loading state with changed query
              isA<PhotosListState>()
                  .having(
                      (p0) => p0.query.editors_choice, "editors_choice", true)
                  .having(
                    (p0) => p0.status,
                    "status",
                    PhotosListStateStatus.loading,
                  ),
              // done state with changed query
              isA<PhotosListState>()
                  .having(
                      (p0) => p0.query.editors_choice, "editors_choice", true)
                  .having(
                      (p0) => p0.status, "status", PhotosListStateStatus.done),
            ]);

    blocTest<PhotosListBloc, PhotosListState>(
        "should return filtered local list",
        build: () => bloc,
        act: (bloc) =>
            bloc.add(PhotosListLoad(const GetPhotosQuery(q: "candy"), true)),
        skip: 1,
        expect: () {
          List<Photo> expectList = examplePhotosPage.photos;
          expectList = expectList
              .where((element) => element.tags.contains("candy"))
              .toList();

          return [
            isA<PhotosListState>()
                .having((p0) => p0.local, "local", true)
                .having((p0) => p0.values.length, "length", expectList.length)
                .having(
                    (p0) => p0.values.first, "first element", expectList.first)
          ];
        });

    blocTest<PhotosListBloc, PhotosListState>("should return sorted local list",
        build: () => bloc,
        act: (bloc) =>
            bloc.add(PhotosListLoad(const GetPhotosQuery(order: "popular"), true)),
        skip: 1,
        expect: () {
          List<Photo> expectList = List.from(examplePhotosPage.photos);
          expectList.sort((a, b) => a.views.compareTo(b.views));

          return [
            isA<PhotosListState>()
                .having((p0) => p0.local, "local", true)
                .having((p0) => p0.values.length, "length", expectList.length)
                .having(
                    (p0) => p0.values.first, "first element", expectList.first)
          ];
        });

    blocTest<PhotosListBloc, PhotosListState>("should load more data",
        setUp: (){

        },
        build: () => bloc,
        act: (bloc) {
          bloc.add(PhotosListLoad(const GetPhotosQuery(), false));
          bloc.add(PhotosListLoadMore());
        },
        expect: () {
          List<Photo> expectList = examplePhotosPage.photos;
          return [
            isA<PhotosListState>().having(
                (p0) => p0.status, "status", PhotosListStateStatus.loading),
            isA<PhotosListState>().having((p0) => p0.values.length,
                "photos list length", expectList.length),
            isA<PhotosListState>().having(
                (p0) => p0.status, "status", PhotosListStateStatus.loading),
            isA<PhotosListState>().having((p0) => p0.values.length,
                "photos list length", expectList.length * 2),
          ];
        },
        verify: (_) {
          verify(() => photoRepository.getPhotosFromApi(any())).called(2);
        });

    group("errors", () {
      blocTest<PhotosListBloc, PhotosListState>("dio error",
          setUp: () {
            // return error
            when(() => photoRepository.getPhotosFromApi(any())).thenAnswer(
                (invocation) async => Left(Failure("dio",
                    errorObject: DioError(
                        requestOptions: RequestOptions(
                            path: "https://pixabay.com/api/")))));
          },
          build: () => bloc,
          act: (bloc) => bloc.add(PhotosListLoad(const GetPhotosQuery(), false)),
          skip: 1,
          expect: () => [
                isA<PhotosListState>()
                    .having((p0) => p0.status, "is error",
                        PhotosListStateStatus.error)
                    .having((p0) => p0.error!.errorObject, "failure",
                        isA<DioError>())
              ]);


      blocTest<PhotosListBloc, PhotosListState>(
          "should return out of range failure when there is no more data",
          setUp: () {
            when(() => photoRepository.getPhotosFromApi(any()))
                .thenAnswer((invocation) async => const Left(const Failure.outOfRange()));
          },
          build: () => bloc,
          act: (bloc) => bloc.add(PhotosListLoadMore()),
          skip: 1,
          expect: () => [
                isA<PhotosListState>()
                    .having((p0) => p0.status, "is error",
                        PhotosListStateStatus.error)
                    .having(
                        (p0) => p0.error, "failure", isA<OutOfRangeFailure>())
              ]);


      blocTest<PhotosListBloc, PhotosListState>("should handle hive error",
          setUp: () {
            when(() => photoRepository.getLocalPhotosList()).thenReturn(Left(
                Failure("hive error", errorObject: HiveError("db error"))));
          },
          build: () => bloc,
          act: (bloc) => bloc.add(PhotosListLoad(const GetPhotosQuery(), true)),
          skip: 1,
          expect: () => [
                isA<PhotosListState>()
                    .having((p0) => p0.status, "is error",
                        PhotosListStateStatus.error)
                    .having((p0) => p0.error!.errorObject, "failure",
                        isA<HiveError>())
              ]);
    });
  });
}
