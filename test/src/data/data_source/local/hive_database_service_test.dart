import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:photo_list/src/data/data_srouce/local/hive_database_service.dart';
import 'package:photo_list/src/model/photo.dart';

import '../../../test_models.dart';

void main() {
  late final HiveDatabaseService service;

  setUpAll(() async {
    await Hive.initFlutter("test/hive/");
    Hive.registerAdapter(PhotoAdapter());

    service = HiveDatabaseService();
    await service.init();
  });

  test("add method should add one object", () async {
    PhotoDao dao = service.photoDao;
    Box<Photo> testBox = Hive.box<Photo>('photos');
    await testBox.clear();

    expect(testBox.values.length, 0);

    dao.add(examplePhoto);

    expect(testBox.values.length, 1);
  });

  test("add all method should add many objects", ()async{
    PhotoDao dao = service.photoDao;
    Box<Photo> testBox = Hive.box<Photo>('photos');
    await testBox.clear();

    expect(testBox.values.length, 0);

    dao.add(examplePhoto.copyWith(id: 1));
    dao.add(examplePhoto.copyWith(id: 7));
    dao.add(examplePhoto.copyWith(id: 20));

    expect(testBox.values.length, 3);
  });

  test("getAll method return right value", (){
    PhotoDao dao = service.photoDao;
    Box<Photo> testBox = Hive.box<Photo>('photos');

    expect(dao.getAll(), testBox.values);
  });

  test("getStream should return stream of Photos", () async{
    PhotoDao dao = service.photoDao;
    Box<Photo> testBox = Hive.box<Photo>('photos');

    var listenable = service.photoDao.getListenableValue();

    expect(listenable.value.values.length, testBox.values.length);

    dao.add(examplePhoto.copyWith(id: 99));

    expect(listenable.value.values.length, testBox.values.length);
  });

  tearDownAll(() {
    service.dispose();
    Hive.close();
    Directory("test/hive/").deleteSync();
  });
}