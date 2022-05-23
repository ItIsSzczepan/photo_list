import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore: depend_on_referenced_packages
import 'package:mocktail/mocktail.dart';
import 'package:photo_list/src/config/const.dart';
import 'package:photo_list/src/data/data_srouce/remote/photo_api_service.dart';

class MockDio extends Mock implements Dio {
  @override
  BaseOptions options = BaseOptions();
}

void main() {
  late final Dio dio;
  late final PhotoApiService service;

  setUpAll(() {
    registerFallbackValue(
        RequestOptions(path: "https://pixabay.com/api/", method: "GET"));
    dio = MockDio();

    service = PhotoApiService(dio);
  });

  group("get places", () {
    test("should return list of Photos", () async {
      when(() => dio.fetch<Map<String, dynamic>>(any())).thenAnswer(
          (invocation) async => Response(
              requestOptions: RequestOptions(
                  path: "https://pixabay.com/api/", method: "GET"),
              data: jsonDecode(
                  await File("test/src/data/data_source/remote/test_json.json")
                      .readAsString())));

      PhotosPage result = await service.getPhotos({"key": apiKey});

      expect(result, isA<PhotosPage>());
      expect(result.total, 1570163);
      expect(result.photos.length, 20);
      expect(result.photos.first.id, 7192179);
    });

    test("should throw error on request error", () async {
      when(() => dio.fetch<Map<String, dynamic>>(any())).thenThrow(DioError(
          requestOptions:
              RequestOptions(path: "https://pixabay.com/api/", method: "GET"),
          error: "505"));

      expect(() => service.getPhotos({"key": apiKey}), throwsA(isA<DioError>()));
    });
  });
}
