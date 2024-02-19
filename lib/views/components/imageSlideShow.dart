import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ImageSlideShow extends StatefulWidget {
  const ImageSlideShow({
    super.key,
    required this.images,
    this.height = 250,
  });
  final List<Widget> images;
  final double height;
  @override
  State<ImageSlideShow> createState() => _ImageSlideShowState();
}

class _ImageSlideShowState extends State<ImageSlideShow> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).canvasColor,
        ),
        child: ImageSlideshow(
          indicatorBackgroundColor: Colors.black45,
          height: widget.height,
          children: widget.images,
        ),
      ),
    );
  }
}
