import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImagePreviewPage extends StatelessWidget {
  final bool local;
  final String largeImageURL;
  final Uint8List? rawImageData;

  const ImagePreviewPage({Key? key, required this.local, required this.largeImageURL, this.rawImageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Center(child: Hero(
            tag: 'image preview',
            child: (local
                ? Image.memory(rawImageData!)
                : Image.network(
              largeImageURL,
              loadingBuilder: (_, widget, event) =>
              event == null
                  ? widget
                  : const CircularProgressIndicator(),
            )),
          ),),
        ),
      ),
    );
  }
}
