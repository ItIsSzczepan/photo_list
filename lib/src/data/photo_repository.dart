import 'dart:isolate';

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

      Isolate.spawn(_savePhotosToDbAndDownloadPhotosRawData, page.photos);
      return Right(page.photos);

    }on DioError catch(e){
      // check if list ends
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

  Future<void> _savePhotosToDbAndDownloadPhotosRawData(List<Photo> photosFromWeb) async{
    debugPrint(photosFromWeb.toString());
    List<Photo> photoList = List.from(photosFromWeb);
    for(int i=0; i<photoList.length; i++){
      photoList[i] = _saveUpdatePhotoInDb(photoList[i]);
    }

    photoList.removeWhere((element) => element.imageDataList != null);
    for(Photo p in photoList){
      await _downloadAndSavePhotoData(p);
    }

    Isolate.exit();
  }

  _saveUpdatePhotoInDb(Photo photo){
    Photo? photoFromDb = _database.photoDao.get(photo.id);
    if(photoFromDb == null){
      _database.photoDao.add(photo);
    }else{
      photo = photoFromDb.copyWith(
        tags: photoFromDb.tags != photo.tags ? photo.tags : photoFromDb.tags,
        likes: photoFromDb.likes != photo.likes ? photo.likes : photoFromDb.likes,
        views: photoFromDb.views != photo.views ? photo.views : photoFromDb.views,
        pageURL: photoFromDb.pageURL != photo.pageURL ? photo.pageURL : photoFromDb.pageURL,
        userImageURL: photoFromDb.userImageURL != photo.userImageURL ? photo.userImageURL : photoFromDb.userImageURL,
      );
      photo.save();
    }
    debugPrint("save");
    return photo;
  }

  _downloadAndSavePhotoData(Photo photo) async {
    Response<List<int>> response;
    response = await _httpService.getRawDataResponse(photo.webformatURL);

    if(response.statusCode == 200){
      photo = photo.copyWith(
        imageDataList: response.data
      );
      photo.save();
    }
    debugPrint("download");
  }
}