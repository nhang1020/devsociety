import 'package:devsociety/views/components/textField.dart';
import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
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
          for (int index = 0; index < 4; index++)
            ListTile(
              onTap: () {},
              minVerticalPadding: 20,
              leading: CircleAvatar(
                radius: 25,
                foregroundImage: AssetImage(
                  _images[index],
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "${_names[index]}",
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
                        Duration(hours: (index + 1) * 10),
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
