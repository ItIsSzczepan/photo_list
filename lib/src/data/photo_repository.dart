import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:photo_list/src/config/const.dart';
import 'package:photo_list/src/core/failure.dart';
import 'package:photo_list/src/data/data_srouce/local/hive_database_service.dart';
import 'package:photo_list/src/data/data_srouce/remote/http_service.dart';
import 'package:photo_list/src/data/data_srouce/remote/photo_api_service.dart';
import 'package:photo_list/src/model/photo.dart';

part 'get_photos_query.dart';
part 'photo_repository.freezed.dart';
part 'photo_repository.g.dart';



class PhotoRepository{
  final HiveDatabaseService _database;
  final PhotoApiService _photoApi;
  final HttpService _httpService;

  PhotoRepository(this._photoApi, this._httpService, this._database);

  Either<Failure, List<Photo>> getLocalPhotosList() {
    try{
      dynamic result = _database.photoDao.getAll();
      result = result.toList();

      return Right(result);
    }on HiveError catch(e){
      return Left(Failure(e.toString(), errorObject: e));
    }
  }

  Future<Either<Failure, List<Photo>>> getPhotosFromApi(GetPhotosQuery query) async {
    try{
      // make a map from object
      Map<String, dynamic> queryMap = query.toJson();
      queryMap.removeWhere((key, value) => value == null);

      // send api request
      PhotosPage page = await _photoApi.getPhotos(queryMap);

      // run isolate for downloading and saving photos raw data in background
      _savePhotosToDbAndDownloadPhotosRawData(page.photos);
      // return data from request
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
    List<Photo> photoList = List.from(photosFromWeb);

    // check if we had download image in past and update stats
    for(int i=0; i<photoList.length; i++){
      photoList[i] = _saveUpdatePhotoInDb(photoList[i]);
    }

    // download raw data photo for new photos
    photoList.removeWhere((element) => element.imageDataList != null);
    for(Photo p in photoList){
      await _downloadAndSavePhotoData(p);
    }
  }

  _saveUpdatePhotoInDb(Photo photo){
    Photo? photoFromDb = _database.photoDao.get(photo.id);
    if(photoFromDb == null){
      _database.photoDao.add(photo);
    }else{
      photoFromDb.views=photo.views;
      photoFromDb.tags=photo.tags;
      photoFromDb.likes=photo.likes;
      photoFromDb.pageURL=photo.pageURL;
      photoFromDb.userImageURL=photo.userImageURL;
      photoFromDb.save();

      photo = photoFromDb;
    }
    return photo;
  }

  _downloadAndSavePhotoData(Photo photo) async {
    Response<List<int>> response;
    response = await _httpService.getRawDataResponse(photo.webformatURL);

    if(response.statusCode == 200){
      photo.imageDataList = response.data;
      photo.save();
    }
  }
}