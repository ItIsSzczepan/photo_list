import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:photo_list/src/core/failure.dart';
import 'package:photo_list/src/data/data_srouce/local/hive_database_service.dart';
import 'package:photo_list/src/data/data_srouce/remote/photo_api_service.dart';
import 'package:photo_list/src/model/photo.dart';

class MockHiveDatabase extends Mock implements HiveDatabaseService {
  @override
  final PhotoDao photoDao;

  MockHiveDatabase(this.photoDao);
}
class MockPhotoDAO extends Mock implements PhotoDao {
  MockBox mockBox;

  MockPhotoDAO(this.mockBox);

  @override
  getAll() => [];

  @override
  getListenableValue() => ValueNotifier(mockBox);
}
class MockBox extends Mock implements Box<Photo>{}
class MockPhotoApi extends Mock implements PhotoApiService{}
class MockDio extends Mock implements Dio{}


void main(){
  late final PhotoRepository photoRepository;
  late final MockHiveDatabase mockHiveDatabase;
  late final MockPhotoDAO mockPhotoDAO;
  late final MockBox mockBox;
  late final MockPhotoApi mockPhotoApi;


  setUpAll(() {
    mockBox = MockBox();
    mockPhotoDAO = MockPhotoDAO(mockBox);
    mockHiveDatabase = MockHiveDatabase(mockPhotoDAO);
    mockPhotoApi = MockPhotoApi();

    photoRepository = PhotoRepository(mockPhotoApi, mockHiveDatabase);
  });

  group("remote", () {
    test("should return Right<list> of photos when everything is right", () => null);

    test("should return Left<Failure.OutOfRange> when there is no more photos", () {});

    test("should return Left<Failure> on network error", (){});

    test("should save image as a list in photo object and add to db", (){});
  });

  group("local", () {
    test("should return Right<listenable> object when everything right", () async{
      var result = await photoRepository.getLocalImagesListenableObject();

      expect(result.value.value, mockBox);
    });

    test("should return Left<Failure> when error was threw", () async{
      when(() => mockPhotoDAO.getListenableValue()).thenThrow(HiveError("some error"));

      var result = await photoRepository.getLocalImagesListenableObject();

      expect(result.value.value, isA<Failure>());
    });
  });
}
