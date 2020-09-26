import 'package:flutter/material.dart';

class KCircularBtn extends StatelessWidget {
  final Icon icon;
  final Function onPressed;

  KCircularBtn({Key key, this.icon, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipOval(
        child: Container(
            height: 50,
            width: 50,
            color: Colors.redAccent,
            child: IconButton(icon: icon, onPressed: onPressed)));
  }
}
