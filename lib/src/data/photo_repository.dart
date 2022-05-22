import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:photo_list/src/core/failure.dart';
import 'package:photo_list/src/data/data_srouce/local/hive_database_service.dart';
import 'package:photo_list/src/data/data_srouce/remote/photo_api_service.dart';
import 'package:photo_list/src/model/photo.dart';

class PhotoRepository{
  final HiveDatabaseService database;

  PhotoRepository(PhotoApiService photoApi, this.database);

  Either<Failure, ValueListenable<Box<Photo>>> getLocalImagesListenableObject() {
    try{
      var result = database.photoDao.getListenableValue();
      return Right(result);
    }on HiveError catch(e){
      return Left(Failure(e.toString(), errorObject: e));
    }
  }

}