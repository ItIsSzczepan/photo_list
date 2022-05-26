import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_list/src/bloc/connectivity/connectivity_bloc.dart';
import 'package:photo_list/src/bloc/photos/photos_list_bloc.dart';
import 'package:photo_list/src/core/failure.dart';
import 'package:photo_list/src/data/photo_repository.dart';
import 'package:photo_list/src/widget/appbar_filter.dart';
import 'package:photo_list/src/widget/phtos_list_widget.dart';

class PhotosListPage extends StatefulWidget {
  PhotosListPage({Key? key}) : super(key: key);

  @override
  State<PhotosListPage> createState() => _PhotosListPageState();
}

class _PhotosListPageState extends State<PhotosListPage> {
  PhotosListState _photosListState = PhotosListState.initial();
  StreamSubscription<ConnectivityResult>? connStream;

  @override
  Widget build(BuildContext context) {
    if (connStream != null) connStream!.cancel();
    connStream =
        GetIt.instance<Connectivity>().onConnectivityChanged.listen((value) {
      if (value != ConnectivityResult.none) {
        // OFFLINE -> ONLINE
        _showOnlineSnackBar(context);
      } else {
        // ONLINE -> OFFLINE
        _showOfflineSnackBar(context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
              border: UnderlineInputBorder(), filled: true, hintText: "Search"),
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            BlocProvider.of<PhotosListBloc>(context).add(PhotosListLoad(
                _photosListState.query.copyWith(q: value),
                _photosListState.local));
          },
        ),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBarFilter(
              onSort: (value) {
                BlocProvider.of<PhotosListBloc>(context).add(PhotosListLoad(
                    _photosListState.query.copyWith(order: value),
                    _photosListState.local));
              },
            )),
      ),
      body: SafeArea(
        child: FutureBuilder<ConnectivityResult>(
          future: GetIt.instance<Connectivity>().checkConnectivity(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              // loading
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.data != ConnectivityResult.none) {
                // send api request
                BlocProvider.of<PhotosListBloc>(context)
                    .add(PhotosListLoad(GetPhotosQuery(), false));
              }
              // return StreamBuilder
              return _listStreamBuilder(context, snapshot.data!);
            }
          },
        ),
      ),
    );
  }

  Widget _listStreamBuilder(context, ConnectivityResult data) {
    return BlocConsumer<PhotosListBloc, PhotosListState>(
      bloc: BlocProvider.of<PhotosListBloc>(context),
      listener: (context, state) {
        _handlePhotoError(context, state);
      },
      builder: (context, state) {
        if ((state.status == PhotosListStateStatus.initial &&
                data == ConnectivityResult.none) ||
            (state.status != PhotosListStateStatus.loading &&
                state.values.isEmpty)) return _OfflineScreen(context);
        _photosListState = state;
        return PhotosListWidget(
          values: state.values,
          onTap: (photo) {},
          onEnd: () {
            if (state.status != PhotosListStateStatus.loading) {
              BlocProvider.of<PhotosListBloc>(context)
                  .add(PhotosListLoadMore());
            }
          },
          onRefresh: () {
            BlocProvider.of<PhotosListBloc>(context)
                .add(PhotosListLoad(state.query, false));
          },
          isLoading: state.status == PhotosListStateStatus.loading,
          local: state.local,
        );
      },
    );
  }

  _handlePhotoError(BuildContext context, PhotosListState state) async {
    if (state.status == PhotosListStateStatus.error) {
      if (state.error is OutOfRangeFailure) {
        _showEndListSnackBar(context);
      } else {
        _showErrorSnackBar(context, state.error!);
      }
    }
  }

  void _showOnlineSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("You are ONLINE! Refresh list to get new data")));
  }

  void _showOfflineSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("You are OFFLINE :(")));
  }

  void _showEndListSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("This is the end")));
  }

  void _showErrorSnackBar(BuildContext context, Failure failure) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(failure.message)));
  }

  Widget _OfflineScreen(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Oops... You don't have internet connection"),
          OutlinedButton(
              onPressed: () {
                BlocProvider.of<PhotosListBloc>(context)
                    .add(PhotosListLoad(GetPhotosQuery(), false));
              },
              child: Text("Refresh")),
          OutlinedButton(
              onPressed: () {
                BlocProvider.of<PhotosListBloc>(context)
                    .add(PhotosListLoad(GetPhotosQuery(), true));
              },
              child: Text("Load data from memeory")),
        ],
      ),
    );
  }
}
