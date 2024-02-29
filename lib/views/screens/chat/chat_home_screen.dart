import 'package:devsociety/models/User.dart';
import 'package:devsociety/provider/UserProvider.dart';
import 'package:devsociety/views/components/myImage.dart';
import 'package:devsociety/views/components/textField.dart';
import 'package:devsociety/views/screens/chat/widgets/chat_room.dart';
import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  List<User> _listUser = [];

  @override
  void initState() {
    super.initState();
    setListUsers();
  }

  setListUsers() {
    setState(() {
      _listUser = Provider.of<UserProvider>(context, listen: false).listUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: MyTextField(
              prefixIcon: Icon(
                UniconsLine.search,
                size: 20,
                color: Colors.grey.withOpacity(.5),
              ),
              hintText: "${lang(context).search}",
            ),
          ),
          for (var user in _listUser)
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatRoom(user: user),
                    ));
              },
              minVerticalPadding: 20,
              leading: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(shape: BoxShape.circle),
                width: 50,
                child: user.avatar != null
                    ? MyImage(imageUrl: "${user.avatar}", isAvatar: true)
                    : Image.asset(
                        'assets/icons/developer_96px.png',
                        fit: BoxFit.cover,
                        color: myColor.withOpacity(.5),
                      ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "${user.firstname} ${user.lastname}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.color
                              ?.withOpacity(.7)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    displayTime(
                      context,
                      DateTime.now().subtract(
                        Duration(hours: (2 + 1) * 10),
                      ),
                    ),
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )
                ],
              ),
              subtitle: Text(
                "Hôm nay tôi buồn buồnbuồnbuồnbuồnbuồnbuồnbuồnbuồn",
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.color
                      ?.withOpacity(.5),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}
