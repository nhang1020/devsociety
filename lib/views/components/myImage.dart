import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  const MyImage({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    // final headers = Provider.of<PostProvider>(context).driveHeader;
    return FadeInImage(
      image: NetworkImage(imageUrl),
      placeholder: AssetImage("assets/icons/placeholder_image.png"),
      imageErrorBuilder: (context, error, stackTrace) {
        return Center(
          child: Image.asset(
            'assets/icons/image_notfound.png',
            fit: BoxFit.cover,
            color: myColor.withOpacity(.5),
          ),
        );
      },
      fit: BoxFit.cover,
    );
    // return Image.network(
    //     "https://drive.google.com/file/d/19IwbHV3WtD5et1rXOM6xwQ1cQmQaltZM/view");
  }
}
