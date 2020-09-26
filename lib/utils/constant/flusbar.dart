import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class KFlushBar extends StatelessWidget {
  final String text;
  KFlushBar({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      title: "Hey Weeb",
      message: "Added $text in your watching list.",
      duration: Duration(seconds: 3),
    );
  }
}
