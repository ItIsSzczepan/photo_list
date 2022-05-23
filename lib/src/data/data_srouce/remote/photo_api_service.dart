import 'dart:async';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_list/src/config/const.dart';
import 'package:photo_list/src/model/photo.dart';
import 'package:retrofit/http.dart';
import 'package:flutter/foundation.dart';

part 'photo_api_service.freezed.dart';

part 'photo_api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class PhotoApiService {
  factory PhotoApiService(Dio dio, {String baseUrl}) = _PhotoApiService;

  @GET("/")
  Future<PhotosPage> getPhotos(@Queries() Map<String, dynamic> queries);
}

@freezed
class PhotosPage with _$PhotosPage {
  const factory PhotosPage(
      {required int total,
      required int totalHits,
      @JsonKey(name: "hits") required List<Photo> photos}) = _PhotosPage;

  factory PhotosPage.fromJson(Map<String, dynamic> json) => _$PhotosPageFromJson(json);
}
