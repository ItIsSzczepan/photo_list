import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

// ignore: depend_on_referenced_packages
import 'package:mocktail/mocktail.dart';
import 'package:photo_list/src/config/const.dart';
import 'package:photo_list/src/core/failure.dart';
import 'package:photo_list/src/data/data_srouce/local/hive_database_service.dart';
import 'package:photo_list/src/data/data_srouce/remote/http_service.dart';
import 'package:photo_list/src/data/data_srouce/remote/photo_api_service.dart';
import 'package:photo_list/src/data/photo_repository.dart';
import 'package:photo_list/src/model/photo.dart';

import '../../test_models.dart';

class MockHiveDatabase extends Mock implements HiveDatabaseService {
  @override
  final PhotoDao photoDao;

  MockHiveDatabase(this.photoDao);
}

class MockPhotoDAO extends Mock implements PhotoDao {
  @override
  getAll() => [];
}

class MockBox extends Mock implements Box<Photo> {}

class MockPhotoApi extends Mock implements PhotoApiService {}

class MockDio extends Mock implements Dio {}

class MockHttpService extends Mock implements HttpService {}

class MockPhoto extends Mock implements Photo {
  @override
  int id = Random().nextInt(1200);

  @override
  String tags = "forest, river";

  @override
  int likes = Random().nextInt(200);

  @override
  int views = Random().nextInt(400);

  @override
  String pageURL = "www.google.com";

  @override
  String userImageURL = "www.youtube.com";

  @override
  Future<void> save() async {}
}

void main() {
  late final PhotoRepository photoRepository;
  late final MockHiveDatabase mockHiveDatabase;
  late final MockPhotoDAO mockPhotoDAO;
  late final MockBox mockBox;
  late final MockPhotoApi mockPhotoApi;
  late final MockHttpService mockHttpService;

  setUpAll(() {
    mockBox = MockBox();
    mockPhotoDAO = MockPhotoDAO();
    mockHiveDatabase = MockHiveDatabase(mockPhotoDAO);
    mockPhotoApi = MockPhotoApi();
    mockHttpService = MockHttpService();

    registerFallbackValue(Uri.parse("https://pixabay.com/api/"));

    when(() => mockPhotoDAO.getListenableValue())
        .thenReturn(ValueNotifier(mockBox));

    when(() => mockHttpService.getRawDataResponse(any())).thenAnswer(
        (invocation) async => Response(
            requestOptions: RequestOptions(path: "https://pixabay.com/api/"),
            data: [255, 255, 255, 255]));

    photoRepository =
        PhotoRepository(mockPhotoApi, mockHttpService, mockHiveDatabase);
  });

  group("remote", () {
    test("should return Right<list> of photos when everything is right",
        () async {
      when(() => mockPhotoApi.getPhotos(any()))
          .thenAnswer((_) async => examplePhotosPage);

      var result = await photoRepository.getPhotosFromApi(GetPhotosQuery());
      // used to execute isolate
      await Future.delayed(const Duration(seconds: 1));

      expect(result.isRight(), true);
      expect(result.getOrElse(() => []), examplePhotosPage.photos);
    });

    test("should return Left<Failure.OutOfRange> when there is no more photos",
        () async {
      when(() => mockPhotoApi.getPhotos(any())).thenThrow(DioError(
          requestOptions: RequestOptions(path: "https://pixabay.com/api/"),
          response: Response(
              requestOptions: RequestOptions(path: "https://pixabay.com/api/"),
              statusCode: 400,
              statusMessage: "\"page\" is out of valid range."),
          type: DioErrorType.response));

      var leftObj;

      var result = await photoRepository.getPhotosFromApi(GetPhotosQuery());

      result.fold((l) => leftObj = l, (r) => null);

      expect(result.isLeft(), true);
      expect(leftObj, isA<OutOfRangeFailure>());
    });

    test("should return Left<Failure> on network error", () async {
      when(() => mockPhotoApi.getPhotos(any())).thenThrow(DioError(
          requestOptions: RequestOptions(path: "https://pixabay.com/api/"),
          response: Response(
              requestOptions: RequestOptions(path: "https://pixabay.com/api/"),
              statusCode: 404,
              statusMessage: "Wrong site"),
          type: DioErrorType.response));

      var leftObj;

      var result = await photoRepository.getPhotosFromApi(GetPhotosQuery());

      result.fold((l) => leftObj = l, (r) => null);

      expect(result.isLeft(), true);
      expect(leftObj, isA<Failure>());
      expect(leftObj.message, "Wrong site");
    });

    // I don't know how to test isolate
    // This code doesn't work because isolate can't execute function that
    // communicate with "outside", only through ports,
    // but this isolate don't have port for returning value
    // function verify() doesn't work either
    test("should save image as a list in photo object and add to db", () async {
      int getExecuteIndex = 0;
      int downloadExecuteIndex = 0;
      when(() => mockPhotoApi.getPhotos(any())).thenAnswer((_) async {
        getExecuteIndex++;
        return examplePhotosPage;
      });
      when(() => mockHttpService.getRawDataResponse(any()))
          .thenAnswer((invocation) async {
        downloadExecuteIndex++;
        return Response(
            requestOptions: RequestOptions(path: "https://pixabay.com/api/"),
            data: [255, 255, 255, 255]);
      });
      when(() => mockPhotoDAO.get(any())).thenAnswer((invocation) => null);

      photoRepository.getPhotosFromApi(GetPhotosQuery());
      await Future.delayed(const Duration(seconds: 10));

      expect(getExecuteIndex, 5);
      expect(downloadExecuteIndex, 5);
    }, skip: true);
  });

  group("local", () {
    test("should return Right<listenable> object when everything right",
        () async {
      var result = photoRepository.getLocalPhotosListenableObject();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ValueNotifier(MockBox())).value, mockBox);
    });

    test("should return Left<Failure> when error was threw", () async {
      when(() => mockPhotoDAO.getListenableValue())
          .thenThrow(HiveError("some error"));
      var left;
      var right;

      var result = photoRepository.getLocalPhotosListenableObject();

      result.fold((l) => left = l, (r) => right = r);

      expect(result.isLeft(), true);
      expect(left, isA<Failure>());
      expect(result.isRight(), false);
      expect(right, null);
    });
  });
}
