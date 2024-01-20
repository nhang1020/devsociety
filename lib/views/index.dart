import 'package:devsociety/models/User.dart';
import 'package:devsociety/provider/ThemeProvider.dart';
import 'package:devsociety/views/screens/home/dashboard_screen.dart';
import 'package:devsociety/views/utils/variable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class Index extends StatefulWidget {
  const Index({super.key, required this.account});
  final UserDTO account;
  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  void initState() {
    super.initState();
  }

  List<IconData> _icons = [
    UniconsLine.estate,
    UniconsLine.airplay,
    UniconsLine.comment_dots,
    UniconsLine.chat_bubble_user,
  ];
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    List<Widget> _wigetOptions = [
      DashboardScreen(),
      Container(
        height: 300,
        color: Colors.amber.withOpacity(.1),
      ),
      Container(
        height: 2000,
        color: Colors.redAccent.withOpacity(.1),
      ),
      Container(
        height: 300,
        color: Colors.blue.withOpacity(.1),
      ),
    ];
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  backgroundColor: Theme.of(context).canvasColor,
                  pinned: true,
                  snap: true,
                  floating: true,
                  elevation: 0,
                  title: Hearder(),
                  scrolledUnderElevation: 12,
                  surfaceTintColor: Colors.transparent,
                  actions: [
                    IconButton(
                      onPressed: () {
                        themeProvider.themeMode == ThemeMode.dark
                            ? themeProvider.toggleTheme(false, 0, context)
                            : themeProvider.toggleTheme(true, 0, context);
                      },
                      icon: Icon(
                        themeProvider.isDarkMode
                            ? UniconsLine.moonset
                            : UniconsLine.brightness_low,
                        size: 30,
                        color: myColor,
                      ),
                    ),
                  ],
                  bottom: TabBar(
                    tabs: _icons
                        .map((IconData iconData) => Tab(
                              icon: Icon(iconData),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
            body: TabBarView(
              children: _wigetOptions.map((Widget page) {
                return Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      key: PageStorageKey<String>(page.hashCode.toString()),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(8.0),
                          sliver: SliverList(
                            delegate: SliverChildListDelegate([
                              Container(
                                child: page,
                              ),
                            ]),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class Hearder extends StatefulWidget {
  const Hearder({super.key});

  @override
  State<Hearder> createState() => _BodyState();
}

class _BodyState extends State<Hearder> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/devlogo.png",
          width: 40,
          color: myColor,
        ),
        SizedBox(width: 6),
        Column(
          children: [
            Text(
              "dev",
              style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 12,
                ),
              ),
            ),
            Text(
              "SOCIETY",
              style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}