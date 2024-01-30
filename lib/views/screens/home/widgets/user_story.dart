import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';

class FriendStory extends StatefulWidget {
  const FriendStory({super.key, required this.i});
  final int i;
  @override
  State<FriendStory> createState() => _FriendStoryState();
}

class _FriendStoryState extends State<FriendStory> {
  List<String> _images = [
    "assets/images/2.jpg",
    "assets/images/3.jpg",
    "assets/images/4.jpg",
    "assets/images/5.jpg"
  ];
  List<String> _names = [
    "Ngọc Sang",
    "Ev. Collapse",
    "Ngọc Hạnh",
    "Trường Giang"
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 90,
          width: 100,
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [myColor, myColor.withOpacity(.1), Colors.cyan],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(3),
            margin: EdgeInsets.all(2.5),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(_images[widget.i]),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      myColor.withOpacity(.3), BlendMode.color),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 80,
          child: Opacity(
            opacity: .7,
            child: Text(
              _names[widget.i],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
