import 'package:anime/controllers/popular_controller.dart';
import 'package:anime/screens/home/view_popular.dart';
import 'package:anime/views/popular.dart';
import 'package:anime/views/recent_sub.dart';
import 'package:anime/views/search_anime.dart';
import 'package:anime/utils/constant/kSlidePageroute.dart';
import 'package:anime/utils/constant/ktextStyle.dart';
import 'package:anime/widgets/autosizetext.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homepage extends StatelessWidget {
  final PopularController popularController = Get.put(PopularController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAutoSizeText(
          text: "animey".toUpperCase(),
          fontSize: 40,
          fontWeight: FontWeight.w500,
          fontfamily: "BebasNeue",
          color: Colors.red,
        ),
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
              EvaIcons.colorPaletteOutline,
              size: 27,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.grey[700],
            ),
            onPressed: () {
              changingTheme();
            }),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          KtextStyle(
            text: " Popular",
            icon: Icon(EvaIcons.arrowheadRightOutline),
            onPressed: () {
              Get.to(ViewAllPopular());
            },
          ),
          PopularAnimes(),
          KtextStyle(
            text: " Recent Animes",
            icon: Icon(EvaIcons.arrowheadRightOutline),
            onPressed: () {},
          ),
          RecentAnimes(),
        ]),
      ),
    );
  }
}

void changingTheme() {
  if (Get.isDarkMode) {
    Get.changeTheme(ThemeData.light());
  } else {
    Get.changeTheme(ThemeData.dark());
  }
}
