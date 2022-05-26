import 'package:flutter/material.dart';
import 'package:photo_list/src/model/photo.dart';
import 'package:url_launcher/url_launcher.dart';

class PhotosListWidget extends StatefulWidget {
  final List<Photo> values;
  final bool isLoading, local;
  final String sort;
  final Function(Photo) onTap;
  final Function() onEnd, onRefresh;

  const PhotosListWidget(
      {Key? key,
      required this.values,
      required this.onTap,
      required this.onEnd,
      required this.onRefresh,
      this.sort = 'popular',
      this.isLoading = false,
      this.local = false})
      : super(key: key);

  @override
  State<PhotosListWidget> createState() => _PhotosListWidgetState();
}

class _PhotosListWidgetState extends State<PhotosListWidget> {
  late ScrollController scrollController;

  @override
  initState() {
    super.initState();
    scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent <=
          scrollController.offset) {
        widget.onEnd();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Photo> list = widget.values;

    if (list.isEmpty && widget.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator(
            onRefresh: () async {
              widget.onRefresh();
            },
            child: GridView.builder(
                controller: scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.isLoading ? list.length + 2 : list.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 3 / 2),
                itemBuilder: (context, index) {
                  if (index == list.length || index == list.length + 1) {
                    // ignore: avoid_unnecessary_containers
                    return Container(child: const CircularProgressIndicator());
                  }
                  return Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: GestureDetector(
                      onTap: () => widget.onTap(list[index]),
                      child: GridTile(
                          footer: GridTileBar(
                            backgroundColor: Colors.black87,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.favorite,
                                      size: 14,
                                    ),
                                    Text(list[index].likes.toString()),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.remove_red_eye,
                                      size: 14,
                                    ),
                                    Text(list[index].views.toString()),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          child: Container(
                            constraints: const BoxConstraints.tightFor(height: 20),
                            decoration:
                                const BoxDecoration(color: Colors.black26),
                            child: list[index].previewURL == "test"
                                ? Text(list[index].id.toString())
                                : (!widget.local
                                    ? Image.network(
                                        list[index].previewURL,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.memory(
                                        list[index].getPhotoFromStorage())),
                          )),
                    ),
                  );
                }),
          ),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
                onTap: () async {
                  launchUrl(Uri.parse("https://pixabay.com/"), mode: LaunchMode.externalApplication);
                },
                child: Container(
                    color: Colors.white70,
                    constraints: const BoxConstraints(maxHeight: 100, maxWidth: 100),
                    child: Image.asset('assets/pixabay_logo.png'))))
      ],
    );
  }
}
