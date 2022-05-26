import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_list/src/bloc/photos/photos_list_bloc.dart';
import 'package:photo_list/src/data/data_srouce/local/hive_database_service.dart';
import 'package:photo_list/src/data/data_srouce/remote/http_service.dart';
import 'package:photo_list/src/data/data_srouce/remote/photo_api_service.dart';
import 'package:photo_list/src/data/photo_repository.dart';

void initInjector(){
  GetIt.instance.registerSingleton<Connectivity>(Connectivity());
  GetIt.instance.registerSingleton<Dio>(Dio());

  GetIt.instance.registerSingleton<HiveDatabaseService>(HiveDatabaseService()..init());
  GetIt.instance.registerSingleton<PhotoApiService>(PhotoApiService(GetIt.instance()));
  GetIt.instance.registerSingleton<HttpService>(HttpService(GetIt.instance()));

  GetIt.instance.registerSingleton<PhotoRepository>(PhotoRepository(GetIt.instance(), GetIt.instance(), GetIt.instance()));

  GetIt.instance.registerFactory<PhotosListBloc>(() => PhotosListBloc(GetIt.instance()));
}