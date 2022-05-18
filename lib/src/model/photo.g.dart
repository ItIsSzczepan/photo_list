// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Photo _$$_PhotoFromJson(Map<String, dynamic> json) => _$_Photo(
      id: json['id'] as int,
      tags: json['tags'] as String,
      likes: json['likes'] as int,
      views: json['views'] as int,
      pageURL: json['pageURL'] as String,
      previewURL: json['previewURL'] as String,
      webformatURL: json['webformatURL'] as String,
      largeImageURL: json['largeImageURL'] as String,
      user: json['user'] as String,
      userImageURL: json['userImageURL'] as String,
      imageDataList: (json['imageDataList'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$$_PhotoToJson(_$_Photo instance) => <String, dynamic>{
      'id': instance.id,
      'tags': instance.tags,
      'likes': instance.likes,
      'views': instance.views,
      'pageURL': instance.pageURL,
      'previewURL': instance.previewURL,
      'webformatURL': instance.webformatURL,
      'largeImageURL': instance.largeImageURL,
      'user': instance.user,
      'userImageURL': instance.userImageURL,
      'imageDataList': instance.imageDataList,
    };
