import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_list/src/bloc/connectivity/connectivity_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivityPlus extends Mock implements Connectivity {}

void main() {
  late ConnectivityBloc bloc;
  late Connectivity mockConnectivity;
  late StreamController<ConnectivityResult> connectivityStream;

  setUpAll(() {
    mockConnectivity = MockConnectivityPlus();

    connectivityStream = StreamController();
    when(() => mockConnectivity.onConnectivityChanged).thenAnswer((_) => connectivityStream.stream);

    bloc = ConnectivityBloc(mockConnectivity);
  });

  test("should return init state at beginning", () {
    expect(bloc.state, const ConnectivityState.initial());
  });

  blocTest<ConnectivityBloc, ConnectivityState>("description",
      build: () => bloc,
      act: (bloc) {
        bloc.add(ConnectivityStart());
        connectivityStream.add(ConnectivityResult.mobile);
      },
      expect: () => [const ConnectivityState(ConnectivityResult.mobile)]);

  tearDownAll(() {
    connectivityStream.close();
  });
}
