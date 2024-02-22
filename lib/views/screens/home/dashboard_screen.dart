
import 'package:devsociety/controllers/LocalPreference.dart';
import 'package:devsociety/models/User.dart';
import 'package:devsociety/views/screens/home/widgets/page_create_post.dart';
import 'package:devsociety/views/screens/home/widgets/post_list.dart';
import 'package:devsociety/views/screens/home/widgets/user_story.dart';
import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';

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
 
    return Column(
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
        ListPost()
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
