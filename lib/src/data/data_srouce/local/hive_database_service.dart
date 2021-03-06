import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:photo_list/src/model/photo.dart';

class HiveDatabaseService{
  late final PhotoDao photoDao;

  init() async{
    Box<Photo> photoBox = await Hive.openBox<Photo>('photos');
    photoDao = PhotoDao(photoBox);
  }

  void dispose(){
    photoDao.dispose();
  }
}

class PhotoDao{
  final Box<Photo> _box;

  const PhotoDao(this._box);

  addAll(List<Photo> photos) => _box.putAll({ for (Photo value in photos) value.id : value });
  add(Photo photo) => _box.put(photo.id, photo);
  Photo? get(int id) => _box.get(id);
  Iterable<Photo> getAll() => _box.values;
  ValueListenable<Box<Photo>> getListenableValue() => _box.listenable();

  void dispose(){
    _box.close();
  }
}