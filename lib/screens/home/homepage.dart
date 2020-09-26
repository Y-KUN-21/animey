import 'package:anime/screens/home/popular.dart';
import 'package:anime/screens/home/recent_dub.dart';
import 'package:anime/screens/home/recent_sub.dart';
import 'package:anime/screens/home/search_anime.dart';
import 'package:anime/screens/settings.dart';
import 'package:anime/screens/home/watching.dart';
import 'package:anime/utils/constant/kSlidePageroute.dart';
import 'package:anime/utils/constant/ktextStyle.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(EvaIcons.searchOutline),
            onPressed: () {
              Navigator.push(context, SlidePageRoute(widget: SearchAnime()));
            },
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            iconSize: 27,
          )
        ],
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            EvaIcons.menu2Outline,
            size: 27,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.grey[700],
          ),
          onPressed: () {
            Navigator.push(context, SlidePageRoute(widget: (Settings())));
          },
        ),
        title: Text(
          "animey",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            fontFamily: "OpenSans",
            color: Colors.red,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                PopularAnimes(),
                SizedBox(
                  height: 10,
                ),
                RecentSubAnimes(),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                RecentDubAnimes(),
                SizedBox(
                  height: 10,
                ),
                KtextStyle(
                  text: " Watching",
                  icon: Icon(EvaIcons.arrowheadRightOutline),
                  onPressed: () {},
                ),
                LimitedBox(
                    maxHeight: MediaQuery.of(context).size.height / 2,
                    child: Container(child: Watching())),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
