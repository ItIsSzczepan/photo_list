// ignore_for_file: non_constant_identifier_names

part of 'photo_repository.dart';

@freezed
class GetPhotosQuery with _$GetPhotosQuery {

  const factory GetPhotosQuery(
      {@Default(apiKey) String key,
      String? q,
      String? lang,
      String? id,
      String? image_type,
      String? orientation,
      String? category,
      int? min_width,
      int? min_height,
      String? colors,
      bool? editors_choice,
      bool? safesearch,
      String? order,
      int? page,
      int? per_page}) = _GetPhotosQuery;

  factory GetPhotosQuery.fromJson(Map<String, Object?> json) =>
      _$GetPhotosQueryFromJson(json);
}
