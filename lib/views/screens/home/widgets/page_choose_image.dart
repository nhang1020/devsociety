import 'dart:io';
import 'dart:typed_data';

import 'package:devsociety/config/ImageHelper.dart';
import 'package:devsociety/provider/PostProvider.dart';
import 'package:devsociety/views/components/button.dart';
import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class PageChooseImage extends StatefulWidget {
  const PageChooseImage({super.key});

  @override
  State<PageChooseImage> createState() => _PageChooseImageState();
}

class _PageChooseImageState extends State<PageChooseImage> {
  List<File> images = [];
  Uint8List? imageList;
  Future<File> uint8ListToFile(Uint8List uint8list, String filePath) async {
    File file = await uint8ListToFile(uint8list, filePath);
    return file;
  }

  Future<void> chooseImage({bool multiple = false}) async {
    var files = await ImageHelper().pickImageByGallery(mutiple: multiple);
    if (files.isNotEmpty) {
      final postProvider = Provider.of<PostProvider>(context, listen: false);
      setState(() {
        images = images + files.map((image) => File(image.path)).toList();
      });
      // postProvider.updateContent(images.map((e) => e.path).join(', '));
      postProvider.updateContent(images);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _isEven = images.length % 2 == 0;
    return Container(
      width: screen(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: MyButton(
                  onPressed: () {},
                  icon: Icon(
                    UniconsLine.apps,
                    color: Colors.white,
                  ),
                  radius: 15,
                  border: Border.all(color: myColor, width: 2),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: MyButton(
                  onPressed: () => chooseImage(multiple: true),
                  color: Colors.transparent,
                  icon: Icon(
                    UniconsLine.images,
                    color: myColor,
                  ),
                  radius: 15,
                  label: lang(context).selectmultiimages,
                  textColor: myColor,
                  border: Border.all(color: myColor, width: 2),
                ),
              ),
            ],
          ),
          SizedBox(height: images.isEmpty ? 30 : 0),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 30),
            color: Colors.transparent,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
            clipBehavior: Clip.hardEdge,
            child: images.isNotEmpty
                ? Wrap(
                    children: images
                        .map(
                          (image) => Stack(
                            alignment: Alignment.topRight,
                            children: [
                              AnimatedContainer(
                                constraints: BoxConstraints(
                                    maxWidth: 500, maxHeight: 500),
                                duration: Duration(milliseconds: 300),
                                width: !_isEven &&
                                        images.indexOf(image) ==
                                            images.length - 1
                                    ? screen(context).width / 1.2
                                    : screen(context).width / 2.5,
                                height: images.length > 1
                                    ? 140
                                    : screen(context).width / 1.2,
                                clipBehavior: Clip.hardEdge,
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Image.file(
                                  image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: MyButton(
                                  color: Colors.black26,
                                  height: 40,
                                  width: 60,
                                  radius: 15,
                                  onPressed: () {
                                    setState(() {
                                      images.remove(image);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  )
                : InkWell(
                    onTap: () {
                      chooseImage();
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          UniconsLine.image,
                          size: 140,
                          color: myColor.withOpacity(.2),
                        ),
                        Image.asset(
                          "assets/icons/imageborder.png",
                          color: myColor,
                          width: 200,
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          height: 120,
                          width: 130,
                          child: Icon(
                            Icons.add_circle,
                            size: 40,
                            color: myColor,
                          ),
                        )
                      ],
                    ),
                  ),
          ),
          SizedBox(height: 8),
          images.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                      color: Colors.red.shade200.withOpacity(.1),
                      width: screen(context).width / 2.4 - 10,
                      icon: Icon(UniconsLine.image_times,
                          color: Colors.red.shade700),
                      onPressed: () {
                        setState(() {
                          images.clear();
                        });
                      },
                    ),
                    SizedBox(width: 10),
                    MyButton(
                      color: myColor.withOpacity(.1),
                      width: screen(context).width / 2.4 - 10,
                      icon: Icon(Icons.add, color: myColor),
                      onPressed: () {
                        chooseImage();
                      },
                    ),
                  ],
                )
              : SizedBox(),
          imageList != null
              ? Image.memory(
                  imageList!,
                  fit: BoxFit.cover,
                )
              : SizedBox(),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
