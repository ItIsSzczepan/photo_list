import 'package:photo_list/src/data/data_srouce/remote/photo_api_service.dart';
import 'package:photo_list/src/model/photo.dart';

Photo examplePhoto = Photo(
    id: 123,
    tags: "forest, river",
    likes: 12,
    views: 2000,
    pageURL: "www.google.com",
    previewURL: "test",
    webformatURL: "https://pixabay.com/get/ga1a27226b30f21daa4daf7e037700d4edd74384c87adf6c96244996539869d743c549d19eb2b5176c3cac45da6e1d42b4380c64859eb240c7ceaddb180756aa8_640.jpg",
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
