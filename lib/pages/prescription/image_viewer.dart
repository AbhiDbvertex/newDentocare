import 'package:flutter/cupertino.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatefulWidget {
  String? img_url;

  ImageViewer(String url) {
    this.img_url = url;
  }

  @override
  State<ImageViewer> createState() => _ImageViewerState(img_url);
}

class _ImageViewerState extends State<ImageViewer> {
  String? img_url;

  _ImageViewerState(String? url) {
    this.img_url = url;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
      imageProvider: NetworkImage(this.img_url.toString()),
    ));
  }
}
