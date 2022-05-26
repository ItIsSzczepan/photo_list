import 'dart:typed_data';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo.freezed.dart';
part 'photo.g.dart';

@unfreezed
class Photo extends HiveObject with _$Photo{
  Photo._();

  @HiveType(typeId: 1, adapterName: "PhotoAdapter")
  factory Photo({
    // meta
    @HiveField(0) required int id,
    @HiveField(1) required String tags,
    @HiveField(2) required int likes,
    @HiveField(3) required int views,
    // photo links
    @HiveField(4) required String pageURL,
    @HiveField(5) required String previewURL,
    @HiveField(6) required String webformatURL,
    @HiveField(7) required String largeImageURL,
    // user data
    @HiveField(8) required String user,
    @HiveField(9) required String userImageURL,
    // local image
    @HiveField(10) List<int>? imageDataList
}) = _Photo;

  factory Photo.fromJson(Map<String, Object?> json)
  => _$PhotoFromJson(json);

  Uint8List getPhotoFromStorage(){
    return Uint8List.fromList(imageDataList ?? []);
  }
}