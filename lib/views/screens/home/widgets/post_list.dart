import 'package:devsociety/controllers/PostController.dart';
import 'package:devsociety/models/Post.dart';
import 'package:devsociety/provider/PostProvider.dart';
import 'package:devsociety/services/DriveService.dart';
import 'package:devsociety/views/components/commentList.dart';
import 'package:devsociety/views/components/imageSlideShow.dart';
import 'package:devsociety/views/components/loading.dart';
import 'package:devsociety/views/components/snackBar.dart';
import 'package:devsociety/views/components/videoPlayer.dart';
import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';
import 'package:devsociety/views/components/button.dart';
import 'package:google_fonts/google_fonts.dart';
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
                  // color: //,myColor.withOpacity(.05),
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CardHeader(post),
                        CardContent(post),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  MyButton(
                                    color: Colors.transparent,
                                    label:
                                        "${roundedQuanlity(context, 10130050)}",
                                    labelStyle: GoogleFonts.assistant(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    icon: Icon(
                                      CupertinoIcons.heart,
                                      // color: myColor,
                                    ),
                                    onPressed: () {},
                                  ),
                                  MyButton(
                                    onPressed: () {
                                      _showModalBottomSheet(CommentList());
                                    },
                                    labelStyle: GoogleFonts.assistant(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    label: "${roundedQuanlity(context, 500)}",
                                    color: Colors.transparent,
                                    icon: Icon(UniconsLine.comment),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: MyButton(
                                      radius: 13,
                                      color: Theme.of(context).canvasColor,
                                      icon: Icon(UniconsLine.bookmark,
                                          color: myColor),
                                      boxShadows: [
                                        BoxShadow(
                                            color: Theme.of(context)
                                                .bannerTheme
                                                .shadowColor!,
                                            offset: Offset(-3, 10),
                                            blurRadius: 15)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 4, left: 8, bottom: 8),
                                    child: MyButton(
                                      radius: 13,
                                      icon: Icon(UniconsLine.share,
                                          color: Colors.white),
                                      boxShadows: [
                                        BoxShadow(
                                            color: Theme.of(context)
                                                .bannerTheme
                                                .shadowColor!,
                                            offset: Offset(-3, 10),
                                            blurRadius: 10)
                                      ],
                                    ),
                                  ),
                                ],
                              )
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

  /* Widget */
  Widget CardHeader(Post post) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Wrap(
            children: [
              Card(
                margin: EdgeInsets.zero,
                color: Theme.of(context).canvasColor,
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 3, top: 3, bottom: 3, right: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/271849228_2013623129027600_2970126254522134146_n.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth: screen(context).width / 2),
                              child: Text(
                                "${post.author["firstname"]}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(height: 3),
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
                                topicIcon(post.topic,
                                    size: 17,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color!
                                        .withOpacity(.5))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 30),
        Padding(
          padding: const EdgeInsets.only(right: 3),
          child: PopupMenuButton(
            position: PopupMenuPosition.under,
            elevation: 20,
            color: myColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: MyButton(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              color: Theme.of(context).canvasColor,
              boxShadows: [
                BoxShadow(
                    color: Theme.of(context).bannerTheme.shadowColor!,
                    offset: Offset(-3, 10),
                    blurRadius: 15)
              ],
              icon: Icon(Icons.more_vert_outlined, size: 30, color: myColor),
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                onTap: () => deletePost(post),
                child: MyButton(
                  color: Colors.transparent,
                  icon: Icon(UniconsLine.trash),
                  label:
                      "${lang(context).delete} ${lang(context).post.toLowerCase()}",
                ),
              ),
              PopupMenuItem(
                child: MyButton(
                  color: Colors.transparent,
                ),
              ),
              PopupMenuItem(
                child: MyButton(
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget CardContent(Post post) {
    return Column(children: <Widget>[
      Container(
        margin: EdgeInsets.only(
            top: post.title == '' || post.title == null ? 0 : 10),
        padding: EdgeInsets.all(post.title == '' || post.title == null ? 0 : 4),
        child: Text(post.title),
      ),
      post.topic == topics[0]
          ? ImageSlideShow(images: [
              for (int i = 0; i < stringToList(post.content).length; i++)
                DriveService.displayDrivePhoto(stringToList(post.content)[i]),
            ])
          : (post.topic == topics[2]
              ? MyVideo(
                  path:
                      "https://drive.google.com/uc?export=download&id=${post.content}")
              : SizedBox()),
    ]);
  }

  /* Function */

  PostController _postController = PostController();
  Future deletePost(Post post) async {
    showLoadingDialog(context);
    bool res = await _postController.deletePost(post.id);
    if (res) {
      Provider.of<PostProvider>(context, listen: false)
          .removePostFromList(post);
      Navigator.pop(context);
      MySnackBar(context: context).showWaiting("Xóa bài đăng thành công!");
    } else {
      // MySnackBar(context: context).showError("Lỗi", isDarkMode)
      print(res);
    }
  }

  Widget topicIcon(String topic, {double size = 23, Color? color}) {
    switch (topic) {
      case 'IMAGE':
        return Icon(UniconsLine.comment_image, size: size, color: color);
      case 'TEXT':
        return Icon(UniconsLine.document_layout_left, size: size, color: color);
      case 'VIDEO':
        return Icon(UniconsLine.airplay, size: size, color: color);
      case 'QNA':
        return Icon(UniconsLine.comment_question, size: size, color: color);
      default:
        return Icon(UniconsLine.document_layout_left, size: size, color: color);
    }
  }

  Future _showModalBottomSheet(Widget widget, {double? height}) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      enableDrag: true,
      constraints:
          BoxConstraints(maxHeight: height ?? screen(context).height / 1.3),
      // showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (BuildContext context) {
        return widget;
      },
    );
  }
}
