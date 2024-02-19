import 'package:devsociety/controllers/PostController.dart';
import 'package:devsociety/models/Post.dart';
import 'package:devsociety/provider/PostProvider.dart';
import 'package:devsociety/provider/UserProvider.dart';
import 'package:devsociety/services/DriveService.dart';
import 'package:devsociety/views/components/button.dart';
import 'package:devsociety/views/screens/home/widgets/page_choose_image.dart';
import 'package:flutter/material.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:devsociety/views/utils/variable.dart';
import 'package:provider/provider.dart';

class PageCreatePost extends StatefulWidget {
  const PageCreatePost({super.key});

  @override
  State<PageCreatePost> createState() => _PageCreatePostState();
}

class _PageCreatePostState extends State<PageCreatePost>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int _selectedIndex = 0;
  final _driveService = DriveService();
  List<String> _fileIds = [];

  TextEditingController _titleController = TextEditingController();
  bool enabled() =>
      Provider.of<PostProvider>(context, listen: false).content != null;

  Future<void> createPost(int authorId) async {
    try {
      final postProvider = Provider.of<PostProvider>(context, listen: false);
      _fileIds = await _driveService.uploadFiles(postProvider.content);
      if (_fileIds.isNotEmpty) {
        Post? resPost = await PostController().createPost(
          new Post(
            author: authorId,
            topic: topics[_selectedIndex],
            title: _titleController.text.toString(),
            content: _fileIds.join(', '),
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
        Navigator.pop(context);
        if (resPost != null) {
          postProvider.addPostToList(resPost);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final userProvider =
        Provider.of<UserProvider>(context, listen: false).userDTO.user;
    List<Widget> _widgetOptions = [
      PageChoosImage(),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(userProvider.firstname),
            ),
          ],
        ),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text("2"),
            ),
          ],
        ),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("3"),
          ],
        ),
      ),
    ];
    return Scaffold(
      body: CustomScrollView(
        physics: ScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            backgroundColor: Theme.of(context).canvasColor,
            elevation: 0,
            scrolledUnderElevation: 0,
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyButton(
                        label: lang(context).post_v.toUpperCase(),
                        enabledColor: Colors.grey.withOpacity(.1),
                        enabledTextColor: Colors.grey,
                        radius: 15,
                        onPressed: () => createPost(userProvider.id)),
                  ),
                ],
              ),
            ],
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            pinned: false,
            snap: true,
            floating: true,
            scrolledUnderElevation: 0,
            backgroundColor: Theme.of(context).canvasColor,
            toolbarHeight: 190,
            title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  PostMenu(title: lang(context).photo, index: 0, imageUrl: ""),
                  PostMenu(title: lang(context).text, index: 1, imageUrl: ""),
                  PostMenu(title: "Video", index: 2, imageUrl: ""),
                  PostMenu(title: lang(context).snq, index: 3, imageUrl: ""),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: TextField(
                        minLines: 1,
                        maxLines: 50,
                        controller: _titleController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: myColor.withOpacity(.05),
                          filled: true,
                          hintText: lang(context).whatonyourmind,
                        ),
                      ),
                    ),
                    Material(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return SlideTransition(
                              position: Tween<Offset>(
                                begin: Offset(1, 1),
                                end: Offset(0, 0),
                              ).animate(animation),
                              child: child);
                        },
                        child: _widgetOptions[_selectedIndex],
                      ),
                    ),
                    // Material(
                    //   child: Container(
                    //     color: Theme.of(context).canvasColor,
                    //     child: _widgetOptions[_selectedIndex],
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget PostMenu({
    required int index,
    required String title,
    required String imageUrl,
  }) {
    List<Color> _colors = [
      Color.fromARGB(255, 57, 163, 239),
      Color.fromARGB(255, 233, 89, 127),
      Color.fromARGB(255, 226, 75, 75),
      Color.fromARGB(255, 139, 41, 195),
    ];
    List<Color> _secondColors = [
      Color.fromARGB(255, 53, 222, 157),
      Color.fromARGB(255, 137, 28, 141),
      Color.fromARGB(255, 255, 204, 64),
      Color.fromARGB(255, 148, 167, 250),
    ];
    return AnimatedGradientBorder(
      animationTime: 4,
      borderSize: 0,
      glowSize: 0,
      gradientColors: _selectedIndex == index
          ? [
              _colors[index],
              Theme.of(context).canvasColor,
              Theme.of(context).canvasColor,
              _secondColors[index],
            ]
          : [Theme.of(context).canvasColor],
      borderRadius: BorderRadius.all(Radius.circular(15)),
      child: Container(
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: _colors[index].withOpacity(.9),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  _secondColors[index],
                  _colors[index],
                ],
              ),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 4,
                color: Theme.of(context).canvasColor,
              )),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              height: 170,
              width: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
