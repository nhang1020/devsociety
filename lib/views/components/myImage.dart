import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  const MyImage({super.key, required this.imageUrl, this.isAvatar = false});
  final String imageUrl;
  final bool isAvatar;
  @override
  Widget build(BuildContext context) {
    // final headers = Provider.of<PostProvider>(context).driveHeader;
    return FadeInImage(
      image: NetworkImage(imageUrl),
      placeholder: AssetImage("assets/icons/placeholder_image.png"),
      imageErrorBuilder: (context, error, stackTrace) {
        return Center(
          child: Image.asset(
            isAvatar
                ? 'assets/icons/developer_96px.png'
                : 'assets/icons/image_notfound.png',
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
