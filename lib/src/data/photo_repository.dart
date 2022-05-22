import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:photo_list/src/core/failure.dart';
import 'package:photo_list/src/data/data_srouce/local/hive_database_service.dart';
import 'package:photo_list/src/data/data_srouce/remote/http_service.dart';
import 'package:photo_list/src/data/data_srouce/remote/photo_api_service.dart';
import 'package:photo_list/src/model/photo.dart';

class PhotoRepository{
  final HiveDatabaseService _database;
  final PhotoApiService _photoApi;
  final HttpService _httpService;

  PhotoRepository(this._photoApi, this._httpService, this._database);

  Either<Failure, ValueListenable<Box<Photo>>> getLocalPhotosListenableObject() {
    try{
      var result = _database.photoDao.getListenableValue();
      return Right(result);
    }on HiveError catch(e){
      return Left(Failure(e.toString(), errorObject: e));
    }
  }

  Future<Either<Failure, List<Photo>>> getPhotosFromApi(String apiKey) async {
    try{
      PhotosPage page = await _photoApi.getPhotos(apiKey);
      return Right(page.photos);
    }on DioError catch(e){
      if(e.response?.statusCode == 400 && e.response?.statusMessage == "\"page\" is out of valid range."){
        return const Left(Failure.outOfRange());
      }

      return Left(Failure(e.response?.statusMessage ?? "Connection error", errorObject: e));
    // HiveError needs own "catch" because it's not Exception
    }on HiveError catch(e){
      return Left(Failure(e.message, errorObject: e));
    }on Exception catch(e){
      return Left(Failure(e.toString(), errorObject: e));
    }
  }
}