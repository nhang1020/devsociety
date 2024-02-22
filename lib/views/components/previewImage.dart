import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class PreviewImage extends StatelessWidget {
  const PreviewImage({super.key, required this.images, this.initIndex});
  final List<String> images;
  final int? initIndex;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.black,
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      content: Container(
        width: screen(context).width,
        height: screen(context).height,
        child: Column(
          children: [
            Container(
              height: 50,
              width: screen(context).width,
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white70)),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon:
                          Icon(Icons.download_outlined, color: Colors.white70))
                ],
              ),
            ),
            Container(
              constraints:
                  BoxConstraints(maxHeight: screen(context).height - 100),
              child: ImageSlideshow(
                initialPage: initIndex ?? 0,
                indicatorBackgroundColor: myColor.withOpacity(.5),
                height: screen(context).height,
                children: images
                    .map((e) => Stack(
                          alignment: Alignment.center,
                          children: [
                            Loading(),
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 30),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Image.network(e)),
                          ],
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
