import 'package:anime/controllers/popular_controller.dart';
import 'package:anime/views/popular.dart';
import 'package:anime/views/recent_sub.dart';
import 'package:anime/views/search_anime.dart';
import 'package:anime/views/watching.dart';
import 'package:anime/widgets/autosizetext.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homepage extends StatelessWidget {
  final PopularController popularController = Get.put(PopularController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: CustomAutoSizeText(
          text: "AnimeY",
          fontSize: 35,
          fontWeight: FontWeight.bold,
          fontfamily: "Roboto",
          color: Colors.red,
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          PopularAnimes(),
          RecentAnimes(),
          Watching(),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(EvaIcons.search),
        onPressed: () => Get.to(SearchAnime(), transition: Transition.downToUp),
      ),
    );
  }
}

void changingTheme() {
  if (Get.isDarkMode) {
    Get.changeTheme(ThemeData.light());
  } else {
    Get.changeTheme(ThemeData(
        accentColor: Colors.redAccent,
        primaryColor: Colors.red,
        brightness: Brightness.dark));
  }
}
