import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_list/src/bloc/photos/photos_list_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_list/src/core/failure.dart';
import 'package:photo_list/src/data/photo_repository.dart';
import 'package:photo_list/src/page/photos_list_page.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../test_models.dart';

class MockPhotosListBloc extends MockBloc<PhotosListEvent, PhotosListState>
    implements PhotosListBloc {}

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late final Connectivity mockConnectivity;
  late PhotosListBloc mockPhotosListBloc;

  setUpAll(() {
    registerFallbackValue(const GetPhotosQuery());
    registerFallbackValue(PhotosListLoad(const GetPhotosQuery(), false));

    mockConnectivity = MockConnectivity();

    GetIt.instance.registerSingleton<Connectivity>(mockConnectivity);
  });

  setUp((){
    mockPhotosListBloc = MockPhotosListBloc();

    when(() => mockPhotosListBloc.close()).thenAnswer((invocation) async =>{});
  });

  setUpWidget(WidgetTester tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidget(MaterialApp(
      home: MultiBlocProvider(providers: [
        BlocProvider<PhotosListBloc>(create: (context) => mockPhotosListBloc)
      ], child: const PhotosListPage()),
    )));
  }

  setUpNetworkConnectionSuccess(StreamController<PhotosListState> photosStream,
      StreamController<ConnectivityResult> connStream) {
    when(() => mockConnectivity.checkConnectivity()).thenAnswer((invocation) async => ConnectivityResult.mobile);

    // PhotosListBloc
    photosStream
      ..add(const PhotosListState())
      ..add(const PhotosListState(status: PhotosListStateStatus.loading))
      ..add(PhotosListState(
          status: PhotosListStateStatus.done,
          values: examplePhotosPage.photos + examplePhotosPage.photos));

    // ConnectivityBloc
    connStream.add(ConnectivityResult.mobile);
  }

  setUpNetworkConnectionFailure(StreamController<PhotosListState> photosStream,
      StreamController<ConnectivityResult> connStream) {
    when(() => mockConnectivity.checkConnectivity()).thenAnswer((invocation) async => ConnectivityResult.none);

    // PhotosListBloc
    photosStream.add(const PhotosListState());

    // ConnectivityBloc
    connStream.add(ConnectivityResult.none);
  }

  // refresh indicator, infinity scroll,
  group("scroll", () {
    testWidgets("refresh indicator test", (WidgetTester tester) async {
      // PREPARE
      StreamController<PhotosListState> photosStreamController =
          StreamController<PhotosListState>();
      StreamController<ConnectivityResult> connStreamController =
          StreamController<ConnectivityResult>();

      setUpNetworkConnectionSuccess(photosStreamController, connStreamController);

      whenListen(mockPhotosListBloc, photosStreamController.stream, initialState: PhotosListState.initial());
      when(() => mockConnectivity.onConnectivityChanged).thenAnswer((_) => connStreamController.stream);

      final SemanticsHandle semanticsHandle = tester.ensureSemantics();

      await setUpWidget(tester);
      await tester.pump();
      await tester.pump();

      // ACT
      await tester.fling(
          find.byType(GridTile).first, const Offset(0.0, 300.0), 1000.0);
      await tester.pump();

      expect(
          tester.getSemantics(find.byType(RefreshProgressIndicator)),
          matchesSemantics(
            label: 'Refresh',
          ));

      photosStreamController
        ..add(const PhotosListState(status: PhotosListStateStatus.loading))
        ..add(PhotosListState(
            status: PhotosListStateStatus.done,
            values: examplePhotosPage.photos));

      await tester
          .pump(const Duration(seconds: 1)); // finish the scroll animation
      await tester.pump(
          const Duration(seconds: 1)); // finish the indicator settle animation
      await tester.pump(
          const Duration(seconds: 1)); // finish the indicator hide animation

      // CHECK
      verify(() => mockPhotosListBloc.add(any())).called(2);

      semanticsHandle.dispose();
    });
  });

  // show snackbar on error, show snackbar on end of the list, show snackbar on connection change (x2)
  group("snackbars", () {
    testWidgets("show snackbar on error", (WidgetTester tester)async{
      // PREPARE
      StreamController<PhotosListState> photosStreamController =
      StreamController<PhotosListState>();
      StreamController<ConnectivityResult> connStreamController =
      StreamController<ConnectivityResult>();

      setUpNetworkConnectionSuccess(photosStreamController, connStreamController);

      whenListen(mockPhotosListBloc, photosStreamController.stream, initialState: PhotosListState.initial());
      when(() => mockConnectivity.onConnectivityChanged).thenAnswer((_) => connStreamController.stream);

      await setUpWidget(tester);
      await tester.pump();

      // ACT
      var findSearchField = find.byType(TextField).first;
      await tester.enterText(findSearchField, "Flower");
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      photosStreamController
        ..add(PhotosListState(
            status: PhotosListStateStatus.loading,
            values: examplePhotosPage.photos + examplePhotosPage.photos))
        ..add(PhotosListState(
            status: PhotosListStateStatus.error,
            values: examplePhotosPage.photos + examplePhotosPage.photos,
            error: const Failure("test error")));

      await tester.pump();

      var findSnackBar = find.byType(SnackBar);

      // CHECK
      expect(findSnackBar, findsOneWidget);
      verify(() => mockPhotosListBloc.add(any())).called(2);
    });

    testWidgets("show snackbar on connection change (yes -> no)", (WidgetTester tester)async{
      // PREPARE
      StreamController<PhotosListState> photosStreamController =
      StreamController<PhotosListState>();
      StreamController<ConnectivityResult> connStreamController =
      StreamController<ConnectivityResult>();

      setUpNetworkConnectionSuccess(photosStreamController, connStreamController);

      whenListen(mockPhotosListBloc, photosStreamController.stream, initialState: PhotosListState.initial());
      when(() => mockConnectivity.onConnectivityChanged).thenAnswer((_) => connStreamController.stream);

      await setUpWidget(tester);
      await tester.pump();

      // ACT
      connStreamController.add(ConnectivityResult.none);
      await tester.pump();

      var findSnackBar = find.byType(SnackBar);
      // CHECK
      expect(findSnackBar, findsOneWidget);
    });

    testWidgets("show snackbar on connection change (no -> yes)", (WidgetTester tester)async{

      // PREPARE
      StreamController<PhotosListState> photosStreamController =
      StreamController<PhotosListState>();
      StreamController<ConnectivityResult> connStreamController =
      StreamController<ConnectivityResult>();

      setUpNetworkConnectionFailure(photosStreamController, connStreamController);

      whenListen(mockPhotosListBloc, photosStreamController.stream, initialState: PhotosListState.initial());
      when(() => mockConnectivity.onConnectivityChanged).thenAnswer((_) => connStreamController.stream);

      await setUpWidget(tester);
      await tester.pump();

      // ACT
      connStreamController.add(ConnectivityResult.mobile);
      await tester.pump();

      var findSnackBar = find.byType(SnackBar);

      // CHECK
      expect(findSnackBar, findsOneWidget);
    });
  });

  // execute function on sort change, execute function after search, execute load on db when is not connected to network
  group("execute functions", () {
    testWidgets("execute function on sort change", (WidgetTester tester) async{

      // PREPARE
      StreamController<PhotosListState> photosStreamController =
      StreamController<PhotosListState>();
      StreamController<ConnectivityResult> connStreamController =
      StreamController<ConnectivityResult>();

      setUpNetworkConnectionSuccess(photosStreamController, connStreamController);

      whenListen(mockPhotosListBloc, photosStreamController.stream, initialState: PhotosListState.initial());
      when(() => mockConnectivity.onConnectivityChanged).thenAnswer((_) => connStreamController.stream);

      await setUpWidget(tester);
      await tester.pump();

      // ACT
      var findSortButton = find.byIcon(Icons.sort);
      await tester.tap(findSortButton);
      await tester.pump();
      await tester.tap(find.text("Popular").last);
      await tester.pump();

      // CHECK
      verify(() => mockPhotosListBloc.add(any())).called(2);
    });

    testWidgets("execute function after search", (WidgetTester tester) async{

      // PREPARE
      StreamController<PhotosListState> photosStreamController =
      StreamController<PhotosListState>();
      StreamController<ConnectivityResult> connStreamController =
      StreamController<ConnectivityResult>();

      setUpNetworkConnectionSuccess(photosStreamController, connStreamController);

      whenListen(mockPhotosListBloc, photosStreamController.stream, initialState: PhotosListState.initial());
      when(() => mockConnectivity.onConnectivityChanged).thenAnswer((_) => connStreamController.stream);

      await setUpWidget(tester);
      await tester.pump();
      await tester.pump();

      // ACT
      var findSearchField = find.byType(TextField).first;
      await tester.enterText(findSearchField, "Flower");
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // CHECK
      verify(() => mockPhotosListBloc.add(any())).called(2);
    });

    testWidgets("execute load on db when is not connected to network", (WidgetTester tester) async{
      // PREPARE
      StreamController<PhotosListState> photosStreamController =
      StreamController<PhotosListState>();
      StreamController<ConnectivityResult> connStreamController =
      StreamController<ConnectivityResult>();

      setUpNetworkConnectionFailure(photosStreamController, connStreamController);

      whenListen(mockPhotosListBloc, photosStreamController.stream, initialState: PhotosListState.initial());
      when(() => mockConnectivity.onConnectivityChanged).thenAnswer((_) => connStreamController.stream);

      await setUpWidget(tester);
      await tester.pump();

      // ACT
      var findLocalButton = find.text("Load data from memory");
      await tester.tap(findLocalButton);

      photosStreamController
        ..add(const PhotosListState(status: PhotosListStateStatus.loading, local: true))
        ..add(PhotosListState(
            status: PhotosListStateStatus.done,
            values: examplePhotosPage.photos + examplePhotosPage.photos, local: true));

      await tester.pump();
      var findGridTile = find.byType(GridTile);

      // CHECK
      verify(() => mockPhotosListBloc.add(any())).called(1);
      expect(findGridTile, findsWidgets);
    });
  });
}
