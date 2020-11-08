import 'package:anime/views/detailpage.dart';
import 'package:anime/views/homepage.dart';
import 'package:anime/screens/home/view_popular.dart';
import 'package:anime/screens/home/view_recent_sub.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'animay',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: "Montserrat",
        primaryColor: Colors.red,
        accentColor: Colors.redAccent,
      ),
      debugShowCheckedModeBanner: false,
      home: Homepage(),
      defaultTransition: Transition.native,
    );
  }
}
