import 'package:devsociety/views/components/myImage.dart';
import 'package:devsociety/views/components/previewImage.dart';
import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';

class ImageSlideShow extends StatefulWidget {
  const ImageSlideShow({
    super.key,
    required this.images,
    this.height = 300,
  });
  final List<String> images;
  final double height;
  @override
  State<ImageSlideShow> createState() => _ImageSlideShowState();
}

class _ImageSlideShowState extends State<ImageSlideShow> {
  Map<String, double> autoSize(int index, int length) {
    if (length == 1) {
      return {"width": screen(context).width - 20};
    }
    if (index == 2 && length < 4) {
      return {
        "width": screen(context).width - 20,
        "height": widget.height / 2 - 5
      };
    } else {
      return {
        "width": screen(context).width / 2 - 32,
        "height": widget.height / 2 - 5
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Wrap(
          runSpacing: 5,
          spacing: 5,
          children: [
            for (int index = 0;
                index < (widget.images.length > 4 ? 4 : widget.images.length);
                index++)
              widget.images.length > 4 && index == 3
                  ? InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => PreviewImage(
                                images: widget.images, initIndex: index));
                      },
                      child: Stack(
                        children: [
                          Container(
                            constraints:
                                BoxConstraints(maxHeight: widget.height * 2),
                            height:
                                autoSize(index, widget.images.length)["height"],
                            width:
                                autoSize(index, widget.images.length)["width"],
                            child: MyImage(imageUrl: widget.images[index]),
                          ),
                          Container(
                            alignment: Alignment.center,
                            constraints:
                                BoxConstraints(maxHeight: widget.height * 2),
                            height:
                                autoSize(index, widget.images.length)["height"],
                            width: screen(context).width / 2 - 26,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.6)),
                            child: Text(
                              "+ ${widget.images.length - 4}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900),
                            ),
                          )
                        ],
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => PreviewImage(
                                images: widget.images, initIndex: index));
                      },
                      child: Container(
                        constraints:
                            BoxConstraints(maxHeight: widget.height * 2),
                        height: autoSize(index, widget.images.length)["height"],
                        width: autoSize(index, widget.images.length)["width"],
                        child: MyImage(imageUrl: widget.images[index]),
                      ),
                    )
          ],
        )

        // ImageSlideshow(
        //   indicatorBackgroundColor: Colors.black45,
        //   height: widget.height,
        //   children: widget.images,
        // ),
        );
  }
}
