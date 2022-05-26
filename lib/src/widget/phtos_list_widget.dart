import 'package:flutter/material.dart';
import 'package:photo_list/src/model/photo.dart';

class PhotosListWidget extends StatefulWidget {
  List<Photo> values;
  bool isLoading, local;
  String sort;
  Function(Photo) onTap;
  Function() onEnd, onRefresh;

  PhotosListWidget(
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

    if (list.isEmpty && widget.isLoading)
      return const Center(child: CircularProgressIndicator());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RefreshIndicator(
        onRefresh: () async {
          widget.onRefresh();
        },
        child: GridView.builder(
            controller: scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.isLoading ? list.length + 2 : list.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 3 / 2),
            itemBuilder: (context, index) {
              if (index == list.length || index == list.length + 1) {
                return Container(child: CircularProgressIndicator());
              }
              return Container(
                clipBehavior: Clip.hardEdge,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
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
                              Icon(
                                Icons.favorite,
                                size: 14,
                              ),
                              Text(list[index].likes.toString()),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
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
                      constraints: BoxConstraints.tightFor(height: 20),
                      decoration: const BoxDecoration(color: Colors.black26),
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
              );
            }),
      ),
    );
  }
}
