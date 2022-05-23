import 'package:dio/dio.dart';

class HttpService {
  final Dio _dio;

  HttpService(this._dio);

  Future<Response<List<int>>> getRawDataResponse(String uri) =>
      _dio.getUri<List<int>>(Uri.parse(uri),
          options: Options(responseType: ResponseType.bytes));
}
