// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_api_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PhotosPage _$$_PhotosPageFromJson(Map<String, dynamic> json) =>
    _$_PhotosPage(
      total: json['total'] as int,
      totalHits: json['totalHits'] as int,
      photos: (json['hits'] as List<dynamic>)
          .map((e) => Photo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_PhotosPageToJson(_$_PhotosPage instance) =>
    <String, dynamic>{
      'total': instance.total,
      'totalHits': instance.totalHits,
      'hits': instance.photos,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _PhotoApiService implements PhotoApiService {
  _PhotoApiService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://pixabay.com/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<PhotosPage> getPhotos(queries) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(queries);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PhotosPage>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PhotosPage.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
