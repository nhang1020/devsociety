import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devsociety/controllers/FirebaseController.dart';
import 'package:devsociety/models/Chat.dart';
import 'package:devsociety/models/User.dart';
import 'package:devsociety/provider/UserProvider.dart';
import 'package:devsociety/views/components/button.dart';
import 'package:devsociety/views/components/myImage.dart';
import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key, required this.user});
  final User user;
  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  TextEditingController _messageController = TextEditingController();
  List<String> _idChats = [];
  User account = User(firstname: '', lastname: '', email: '', id: 0);
  bool hasChat = false;
  String idChat = "";
  @override
  void initState() {
    super.initState();
    initChat();
  }

  Future<void> initChat() async {
    setState(() {
      account = Provider.of<UserProvider>(context, listen: false).userDTO.user;
      _idChats = [
        'chat-${account.id}-${widget.user.id}',
        'chat-${widget.user.id}-${account.id}'
      ];

      FirebaseController.getChat(_idChats).listen((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          hasChat = true;
          idChat = snapshot.docs[0].id;
        } else {
          idChat = _idChats[0];
          hasChat = false;
        }
      });
    });
  }

  Future<void> addMessage() async {
    if (_messageController.text.trim() == '') {
      _messageController.text = '';
      return;
    }

    FirebaseController.addMessage(
        Message(
          senderId: account.id,
          content: _messageController.text,
          time: Timestamp.now(),
        ),
        idChat,
        hasChat);
    _messageController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 40,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new, size: 20, color: myColor),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 40,
                width: 40,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: widget.user.avatar != null
                    ? MyImage(imageUrl: "${widget.user.avatar}", isAvatar: true)
                    : Image.asset(
                        'assets/icons/developer_96px.png',
                        fit: BoxFit.cover,
                        color: myColor.withOpacity(.5),
                      ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "${widget.user.firstname} ${widget.user.lastname}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color:
                              Theme.of(context).textTheme.displayMedium!.color,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(height: 3),
                    StreamBuilder(
                      stream: FirebaseController.getStatus(
                          "user-${widget.user.id}"),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Loading();
                        } else if (!snapshot.data!.exists) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.circle,
                                  color: Colors.redAccent, size: 10),
                              SizedBox(width: 5),
                              Text(
                                "Offline",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color!
                                      .withOpacity(.5),
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          );
                        } else {
                          final user = snapshot.data!;
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.circle,
                                  color: user.get('status')
                                      ? Color.fromARGB(255, 68, 229, 159)
                                      : Colors.redAccent,
                                  size: 10),
                              SizedBox(width: 5),
                              Text(
                                user.get('status')
                                    ? "Online"
                                    : "Truy cập ${displayTime(context, user.get('timeUpdate').toDate())}",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color!
                                      .withOpacity(.5),
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            MyButton(
              color: Theme.of(context).canvasColor,
              onPressed: () {},
              icon: Icon(UniconsLine.phone, color: myColor),
            ),
            SizedBox(width: 5),
            MyButton(
              color: Theme.of(context).canvasColor,
              onPressed: () {},
              icon: Icon(UniconsLine.video, color: myColor),
            ),
            SizedBox(width: 5),
            MyButton(
              color: Theme.of(context).canvasColor,
              onPressed: () {},
              icon: Icon(UniconsLine.list_ui_alt, color: myColor),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseController.getChat(_idChats),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Loading();
                      } else {
                        if (snapshot.data!.docs.isNotEmpty) {
                          Chat chat = Chat.fromJson(snapshot.data?.docs[0]
                              .data() as Map<String, dynamic>);
                          List<Message> message =
                              chat.messages.reversed.toList();
                          return ListView.builder(
                            reverse: true,
                            itemCount: chat.messages.length,
                            itemBuilder: (context, index) {
                              bool isMyMessage =
                                  message[index].senderId == account.id;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  mainAxisAlignment: isMyMessage
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  children: [
                                    Card(
                                      color: isMyMessage ? myColor : null,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      clipBehavior: Clip.hardEdge,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          constraints: BoxConstraints(
                                              maxWidth:
                                                  screen(context).width / 1.4),
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${message[index].content}",
                                                style: TextStyle(
                                                    color: isMyMessage
                                                        ? Colors.white
                                                        : null),
                                                maxLines: 50,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return Container();
                        }
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
              ],
            )),
            Container(
              padding: const EdgeInsets.all(10.0),
              color: Theme.of(context).canvasColor,
              height: 60,
              child: Row(
                children: [
                  MyButton(
                    color: Colors.transparent,
                    icon: Icon(UniconsLine.images, color: Colors.grey),
                  ),
                  Expanded(
                    child: TextField(
                      maxLines: null,
                      textAlign: TextAlign.justify,
                      controller: _messageController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        prefixIcon: MyButton(
                          onPressed: () {},
                          color: Colors.transparent,
                          icon: Icon(UniconsLine.smile_squint_wink),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: myColor.withOpacity(.08),
                        labelText: "Nhắn tin",
                        floatingLabelStyle:
                            TextStyle(color: Colors.transparent),
                        hintText: "Nhập tin nhắn...",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: MyButton(
                      padding: EdgeInsets.all(5),
                      onPressed: () {
                        addMessage();
                      },
                      color: Theme.of(context).scaffoldBackgroundColor,
                      icon: Icon(Icons.send_rounded, color: myColor, size: 27),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Future<void> addChat() async {
    try {} catch (e) {
      print(e);
    }
  }
}
