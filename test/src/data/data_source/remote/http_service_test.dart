import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:dio/dio.dart';
import 'package:photo_list/src/data/data_srouce/remote/http_service.dart';

class MockDio extends Mock implements Dio {
  @override
  BaseOptions options = BaseOptions();
}

void main() {
  late final Dio dio;
  late final HttpService service;

  setUpAll(() {
    registerFallbackValue(
        RequestOptions(path: "https://pixabay.com/api/", method: "GET"));
    registerFallbackValue(Uri.parse("https://pixabay.com/api/"));
    dio = MockDio();

    service = HttpService(dio);
  });

  group("get Photo raw", () {
    test("should return raw data of photo", () async {
      when(() => dio.getUri<List<int>>(any(), options: any(named: "options")))
          .thenAnswer((invocation) async => Response(
              requestOptions: RequestOptions(path: "https://pixabay.com/api/"),
              data: [255, 255, 255, 255]));
      Response<List<int>> result = await service.getRawDataResponse("");

      expect(result.data?.length, 4);
    });

    test("should return error on request error", () {
      when(() => dio.getUri<List<int>>(any(), options: any(named: "options")))
          .thenThrow(DioError(
              requestOptions:
                  RequestOptions(path: "https://pixabay.com/api/")));

      expect(() => service.getRawDataResponse(""), throwsA(isA<DioError>()));
    });
  });
}
