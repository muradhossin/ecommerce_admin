import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoFrameView extends StatefulWidget {
  final Widget child;
  final String url;
  final VoidCallback onImagePressed;

  const PhotoFrameView({
    Key? key,
    required this.child,
    required this.url,
    required this.onImagePressed,
  }) : super(key: key);

  @override
  State<PhotoFrameView> createState() => _PhotoFrameViewState();
}

class _PhotoFrameViewState extends State<PhotoFrameView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      alignment: Alignment.center,
      width: 75,
      height: 75,
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.grey, width: 1.5, style: BorderStyle.solid)),
      child: widget.url.isEmpty ? widget.child :  InkWell(
        onTap: widget.onImagePressed,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: widget.url,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, ulr, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
