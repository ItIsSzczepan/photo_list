import 'package:photo_list/src/data/data_srouce/remote/photo_api_service.dart';
import 'package:photo_list/src/model/photo.dart';

Photo examplePhoto = Photo(
    id: 123,
    tags: "forest, river",
    likes: 12,
    views: 2000,
    pageURL: "www.google.com",
    previewURL: "previewURL",
    webformatURL: "webformatURL",
    largeImageURL: "largeImageURL",
    user: "user",
    userImageURL: "userImageURL");

PhotosPage examplePhotosPage = PhotosPage(total: 1200, totalHits: 500, photos: [
  examplePhoto.copyWith(id: 11),
  examplePhoto.copyWith(id: 15),
  examplePhoto.copyWith(id: 12, tags: "forest, candy, river"),
  examplePhoto.copyWith(id: 115),
  examplePhoto.copyWith(id: 20)
]);
