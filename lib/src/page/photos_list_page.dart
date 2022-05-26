import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_list/src/bloc/photos/photos_list_bloc.dart';
import 'package:photo_list/src/core/failure.dart';
import 'package:photo_list/src/data/photo_repository.dart';
import 'package:photo_list/src/model/photo.dart';
import 'package:photo_list/src/page/photo_detail_page.dart';
import 'package:photo_list/src/widget/appbar_filter.dart';
import 'package:photo_list/src/widget/phtos_list_widget.dart';
import 'package:photo_list/src/widget/search_field.dart';

class PhotosListPage extends StatefulWidget {
  const PhotosListPage({Key? key}) : super(key: key);

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
        title: SearchField(
          onSubmitted: (value) => _sendQuery(value),
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBarFilter(
              onSort: (value) {
                _sendSort(value);
              },
            )),
      ),
      body: SafeArea(
        child: FutureBuilder<ConnectivityResult>(
          future: GetIt.instance<Connectivity>().checkConnectivity(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.data != ConnectivityResult.none) {
                // send api request
                BlocProvider.of<PhotosListBloc>(context)
                    .add(PhotosListLoad(const GetPhotosQuery(), false));
              }
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
        // no internet + initial state OR no result
        if ((state.status == PhotosListStateStatus.initial &&
                data == ConnectivityResult.none) ||
            (state.status != PhotosListStateStatus.loading &&
                state.values.isEmpty)) return _offlineScreen(context);

        _photosListState = state;

        return PhotosListWidget(
          values: state.values,
          onTap: (photo) {
            _openDetailsPage(photo, state);
          },
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

  // FUNCTIONAL METHODS
  _handlePhotoError(BuildContext context, PhotosListState state) async {
    if (state.status == PhotosListStateStatus.error) {
      if (state.error is OutOfRangeFailure) {
        _showEndListSnackBar(context);
      } else {
        _showErrorSnackBar(context, state.error!);
      }
    }
  }

  _sendQuery(String query) {
    BlocProvider.of<PhotosListBloc>(context).add(PhotosListLoad(
        _photosListState.query.copyWith(q: query), _photosListState.local));
  }

  _sendSort(String sort) {
    BlocProvider.of<PhotosListBloc>(context).add(PhotosListLoad(
        _photosListState.query.copyWith(order: sort), _photosListState.local));
  }

  _openDetailsPage(Photo photo, PhotosListState state) {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, anim, anotherAnim) => PhotoDetailPage(
                  likes: photo.likes,
                  views: photo.views,
                  tags: photo.tags,
                  user: photo.user,
                  largeImageURL: photo.largeImageURL,
                  userImageURL: photo.userImageURL,
                  pageURL: photo.pageURL,
                  local: state.local,
                  rawImageData: photo.getPhotoFromStorage(),
                ),
            transitionsBuilder: (context, animation, nextAnimation, child) {
              return ScaleTransition(
                scale: Tween<double>(
                  begin: 0.0,
                  end: 1.0,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.fastOutSlowIn,
                  ),
                ),
                child: child,
              );
            }));
  }

  // UI METHODS
  void _showOnlineSnackBar(BuildContext context) {
    _showSnackBar(const Text("You are ONLINE! Refresh list to get new data"));
  }

  void _showOfflineSnackBar(BuildContext context) {
    _showSnackBar(const Text("You are OFFLINE :("));
  }

  void _showEndListSnackBar(BuildContext context) {
    _showSnackBar(const Text("This is the end"));
  }

  void _showErrorSnackBar(BuildContext context, Failure failure) {
    _showSnackBar(Text(failure.message, style: const TextStyle().copyWith(color: Colors.red),));
  }

  void _showSnackBar(Widget content) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: content,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.grey,
    ));
  }

  Widget _offlineScreen(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Oops... You don't have internet connection"),
          OutlinedButton(
              onPressed: () {
                BlocProvider.of<PhotosListBloc>(context)
                    .add(PhotosListLoad(_photosListState.query, false));
              },
              child: const Text("Refresh")),
          OutlinedButton(
              onPressed: () {
                BlocProvider.of<PhotosListBloc>(context)
                    .add(PhotosListLoad(_photosListState.query, true));
              },
              child: const Text("Load data from memory")),
        ],
      ),
    );
  }
}
