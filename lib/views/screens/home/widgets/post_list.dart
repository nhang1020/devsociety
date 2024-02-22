import 'package:devsociety/provider/PostProvider.dart';
import 'package:devsociety/services/DriveService.dart';
import 'package:devsociety/views/components/imageSlideShow.dart';
import 'package:devsociety/views/components/videoPlayer.dart';
import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';
import 'package:devsociety/views/components/button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter/cupertino.dart';

class ListPost extends StatefulWidget {
  const ListPost({super.key});

  @override
  State<ListPost> createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    return Column(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: postProvider.listPost
              .map(
                (post) => Card(
                  color: myColor.withOpacity(.05),
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth: screen(context).width / 2),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    foregroundImage: AssetImage(
                                        "assets/images/271849228_2013623129027600_2970126254522134146_n.jpg"),
                                  ),
                                  SizedBox(width: 7),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          post.author["firstname"],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "${displayTime(context, post.createdAt)} • ",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .color!
                                                      .withOpacity(.5),
                                                  fontSize: 12),
                                            ),
                                            Icon(FontAwesomeIcons.earthAmericas,
                                                size: 10)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.more_vert_outlined,
                                  size: 30, color: myColor),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(4),
                          child: Text(post.title),
                        ),
                        post.topic == topics[0]
                            ? ImageSlideShow(images: [
                                for (int i = 0;
                                    i < stringToList(post.content).length;
                                    i++)
                                  DriveService.displayDrivePhoto(
                                      stringToList(post.content)[i]),
                              ])
                            : (post.topic == topics[2]
                                ? MyVideo(
                                    path:
                                        "https://drive.google.com/uc?export=download&id=${post.content}")
                                : SizedBox()),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyButton(
                                color: Colors.transparent,
                                icon: Icon(CupertinoIcons.heart_fill,
                                    color: myColor),
                                onPressed: () async {
                                  // await PostController().getPosts(0, 2);
                                },
                              ),
                              MyButton(
                                color: Colors.transparent,
                                icon: Icon(UniconsLine.comment),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        postProvider.loading ? Loading() : SizedBox()
      ],
    );
  }
}
