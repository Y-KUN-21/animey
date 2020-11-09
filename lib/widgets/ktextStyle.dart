import 'package:flutter/material.dart';

class KtextStyle extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Icon icon;
  KtextStyle({Key key, this.text, this.icon, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        IconButton(
          icon: icon,
          onPressed: onPressed,
        )
      ],
    );
  }
}
