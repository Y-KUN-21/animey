import 'package:anime/views/homepage.dart';
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
      themeMode: ThemeMode.dark,
      theme: ThemeData(
          fontFamily: "Montserrat",
          primaryColor: Colors.red,
          accentColor: Colors.redAccent,
          backgroundColor: Colors.black,
          primarySwatch: Colors.red,
          brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: Homepage(),
      defaultTransition: Transition.native,
    );
  }
}
