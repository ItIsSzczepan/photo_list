import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:photo_list/src/bloc/photos/photos_list_bloc.dart';
import 'package:photo_list/src/injector.dart';
import 'package:photo_list/src/model/photo.dart';
import 'package:photo_list/src/page/photos_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter("test/hive/");
  Hive.registerAdapter(PhotoAdapter());

  initInjector();

  runApp(MaterialApp(
    theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(elevation: 12),
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.purple, brightness: Brightness.dark)),
    themeMode: ThemeMode.light,
    home: MultiBlocProvider(
      providers: [
        BlocProvider<PhotosListBloc>(
          create: (context) => GetIt.instance(),
        ),
      ],
      child: const PhotosListPage(),
    ),
  ));
}
