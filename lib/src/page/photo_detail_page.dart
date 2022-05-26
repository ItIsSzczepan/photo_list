import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_list/src/page/image_preview_page.dart';

class PhotoDetailPage extends StatefulWidget {
  final int likes, views;
  final String tags, user, largeImageURL, userImageURL, pageURL;
  final bool local;
  final Uint8List? rawImageData;

  const PhotoDetailPage(
      {Key? key,
      required this.likes,
      required this.views,
      required this.tags,
      required this.user,
      required this.largeImageURL,
      required this.userImageURL,
      required this.pageURL,
      required this.local,
      this.rawImageData})
      : super(key: key);

  @override
  State<PhotoDetailPage> createState() => _PhotoDetailPageState();
}

class _PhotoDetailPageState extends State<PhotoDetailPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..forward();

  late final Animation<Offset> _slideAnimation = Tween<Offset>(
    begin: const Offset(0.0, -1.5),
    end: const Offset(0.0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  ));

  late final Animation<double> _fadeAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                // IMAGE
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      _openImagePreview(context);
                    },
                    // ignore: avoid_unnecessary_containers
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0)),
                      clipBehavior: Clip.antiAlias,
                      child: _animatedWidget(
                          child: Hero(
                        tag: 'image preview',
                        child: (widget.local
                            ? Image.memory(widget.rawImageData!)
                            : Image.network(
                                widget.largeImageURL,
                                loadingBuilder: (_, widget, event) =>
                                    event == null
                                        ? widget
                                        : const CircularProgressIndicator(),
                              )),
                      )),
                    ),
                  ),
                ),

                // WHITE SPACE
                Flexible(child: Container()),

                // USER AND DATA
                Flexible(
                  child: Column(
                    children: [
                      _animatedWidget(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // LIKES
                          _smallCard(
                              child: Row(
                            children: [
                              const Icon(Icons.favorite_border),
                              Text(widget.likes.toString())
                            ],
                          )),
                          // TAGS
                          _smallCard(
                              child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Icon(Icons.tag),
                              Text(widget.tags.toString())
                            ],
                          )),
                          // VIEWS
                          _smallCard(
                              child: Row(
                            children: [
                              const Icon(Icons.remove_red_eye),
                              Text(widget.views.toString())
                            ],
                          ))
                        ],
                      )),
                      // USER
                      _animatedWidget(
                          child: _largeCard(
                              lending: ClipOval(
                                  child: widget.local ? Icon(Icons.person) : Image.network(
                                widget.userImageURL,
                                filterQuality: FilterQuality.high,
                              )),
                              content: Text(widget.user)))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _animatedWidget({required Widget child}) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: child,
      ),
    );
  }

  Widget _smallCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), color: Colors.black87),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }

  Widget _largeCard({required Widget lending, required Widget content}) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size.fromHeight(80)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), color: Colors.black87),
      child: Row(
        children: [
          lending,
          const SizedBox(
            width: 25,
          ),
          content
        ],
      ),
    );
  }

  void _openImagePreview(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ImagePreviewPage(
                local: widget.local,
                largeImageURL: widget.largeImageURL,
                rawImageData: widget.rawImageData)));
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }
}
