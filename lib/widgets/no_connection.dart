import 'package:auto_size_text/auto_size_text.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class NoConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Column(
        children: [
          Icon(EvaIcons.wifiOffOutline),
          AutoSizeText("Check you internet connection")
        ],
      ),),
    );
  }
}