import 'package:anime/controllers/popular_controller.dart';
import 'package:anime/views/popular.dart';
import 'package:anime/views/recent_sub.dart';
import 'package:anime/views/search_anime.dart';
import 'package:anime/views/watching.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homepage extends StatelessWidget {
  final PopularController popularController = Get.put(PopularController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          backgroundColor: Colors.red,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Image.asset(
                "assets/logo.png",
                height: 30,
              ),
              background: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
              )),
          expandedHeight: 140,
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          SingleChildScrollView(
              child: Column(
            children: [
              PopularAnimes(),
              RecentAnimes(),
              Watching(),
            ],
          ))
        ]))
      ]),
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
