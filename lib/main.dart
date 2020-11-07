import 'package:anime/screens/home/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
