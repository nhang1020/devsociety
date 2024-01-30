import 'package:devsociety/controllers/LocalPreference.dart';
import 'package:devsociety/models/Post.dart';
import 'package:devsociety/models/User.dart';
import 'package:devsociety/provider/PostProvider.dart';
import 'package:devsociety/views/components/button.dart';
import 'package:devsociety/views/screens/home/widgets/page_create_post.dart';
import 'package:devsociety/views/screens/home/widgets/user_story.dart';
import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unicons/unicons.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  UserDTO? _userData;
  @override
  void initState() {
    super.initState();
    getLocalAccount();
  }

  Future getLocalAccount() async {
    _userData = await LocalPreference().getLocalAccount(context);
    setState(() {});
  }

  bool locale = true;
  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 130,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Stack(
                children: [
                  InkWell(
                    onTap: () {
                      // _showModalBottomSheet(PageCreatePost());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PageCreatePost()));
                    },
                    child: Container(
                      height: 90,
                      width: 100,
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: myColor.withOpacity(.1),
                        image: _userData?.user.avatar != null
                            ? DecorationImage(
                                image: NetworkImage(_userData?.user.avatar),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    myColor.withOpacity(.3), BlendMode.color),
                              )
                            : DecorationImage(
                                image: AssetImage(
                                    "assets/images/271849228_2013623129027600_2970126254522134146_n.jpg"),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    myColor.withOpacity(.3), BlendMode.color),
                              ),
                      ),
                    ),
                  ),
                  Container(
                      width: 40,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: myColor,
                      ),
                      child: Icon(Icons.add, color: Colors.white)),
                ],
              ),
              for (int i = 0; i < 4; i++) FriendStory(i: i)
            ],
          ),
        ),
        ListPost(list: postProvider.listPost)
      ],
    );
  }

  Future _showModalBottomSheet(Widget widget, {double? height}) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      constraints:
          BoxConstraints(maxHeight: height ?? screen(context).height - 30),
      // showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (BuildContext context) {
        return widget;
      },
    );
  }
}

class ListPost extends StatefulWidget {
  const ListPost({super.key, required this.list});
  final List<Post> list;
  @override
  State<ListPost> createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.list
          .map(
            (post) => Card(
              color: myColor.withOpacity(.05),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Yêu em rất nhiều",
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
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyButton(
                            color: Colors.transparent,
                            icon:
                                Icon(CupertinoIcons.heart_fill, color: myColor),
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
    );
  }
}
