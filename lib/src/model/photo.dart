import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo.freezed.dart';
part 'photo.g.dart';

@freezed
class Photo with _$Photo{
  const Photo._();

  const factory Photo({
    // meta
    required int id,
    required String tags,
    required int likes,
    required int views,
    // photo links
    required String pageURL,
    required String previewURL,
    required String webformatURL,
    required String largeImageURL,
    // user data
    required String user,
    required String userImageURL,
    // local image
    List<int>? imageDataList
}) = _Photo;

  factory Photo.fromJson(Map<String, Object?> json)
  => _$PhotoFromJson(json);

  Uint8List getPhotoFromStorage(){
    return Uint8List.fromList(imageDataList ?? []);
  }
}