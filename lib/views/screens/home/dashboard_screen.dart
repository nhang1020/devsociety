import 'dart:convert';

import 'package:devsociety/models/User.dart';
import 'package:devsociety/services/AuthService.dart';
import 'package:devsociety/views/components/button.dart';
import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    _userData = await AuthService().getLocalAccount();
    setState(() {});
  }

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
  bool locale = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 130,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Stack(
                children: [
                  Container(
                    height: 90,
                    width: 100,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: myColor.withOpacity(.1),
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/images/271849228_2013623129027600_2970126254522134146_n.jpg"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            myColor.withOpacity(.3), BlendMode.color),
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
              for (int i = 0; i < 4; i++)
                Column(
                  children: [
                    Container(
                      height: 90,
                      width: 100,
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [
                            myColor,
                            myColor.withOpacity(.1),
                            Colors.cyan
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(3),
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(_images[i]),
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
                          _names[i],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        LangDropDown(),
        // ToggleLanguage(),
      ],
    );
  }
}
