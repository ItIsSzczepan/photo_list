// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetPhotosQuery _$$_GetPhotosQueryFromJson(Map<String, dynamic> json) =>
    _$_GetPhotosQuery(
      key: json['key'] as String? ?? apiKey,
      q: json['q'] as String?,
      lang: json['lang'] as String?,
      id: json['id'] as String?,
      image_type: json['image_type'] as String?,
      orientation: json['orientation'] as String?,
      category: json['category'] as String?,
      min_width: json['min_width'] as int?,
      min_height: json['min_height'] as int?,
      colors: json['colors'] as String?,
      editors_choice: json['editors_choice'] as bool?,
      safesearch: json['safesearch'] as bool?,
      order: json['order'] as String?,
      page: json['page'] as int?,
      per_page: json['per_page'] as int?,
    );

Map<String, dynamic> _$$_GetPhotosQueryToJson(_$_GetPhotosQuery instance) =>
    <String, dynamic>{
      'key': instance.key,
      'q': instance.q,
      'lang': instance.lang,
      'id': instance.id,
      'image_type': instance.image_type,
      'orientation': instance.orientation,
      'category': instance.category,
      'min_width': instance.min_width,
      'min_height': instance.min_height,
      'colors': instance.colors,
      'editors_choice': instance.editors_choice,
      'safesearch': instance.safesearch,
      'order': instance.order,
      'page': instance.page,
      'per_page': instance.per_page,
    };
