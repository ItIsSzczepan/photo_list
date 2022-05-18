// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhotoAdapter extends TypeAdapter<_$_Photo> {
  @override
  final int typeId = 1;

  @override
  _$_Photo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Photo(
      id: fields[0] as int,
      tags: fields[1] as String,
      likes: fields[2] as int,
      views: fields[3] as int,
      pageURL: fields[4] as String,
      previewURL: fields[5] as String,
      webformatURL: fields[6] as String,
      largeImageURL: fields[7] as String,
      user: fields[8] as String,
      userImageURL: fields[9] as String,
      imageDataList: (fields[10] as List?)?.cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, _$_Photo obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.tags)
      ..writeByte(2)
      ..write(obj.likes)
      ..writeByte(3)
      ..write(obj.views)
      ..writeByte(4)
      ..write(obj.pageURL)
      ..writeByte(5)
      ..write(obj.previewURL)
      ..writeByte(6)
      ..write(obj.webformatURL)
      ..writeByte(7)
      ..write(obj.largeImageURL)
      ..writeByte(8)
      ..write(obj.user)
      ..writeByte(9)
      ..write(obj.userImageURL)
      ..writeByte(10)
      ..write(obj.imageDataList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhotoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
