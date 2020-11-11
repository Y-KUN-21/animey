import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class KtextStyle extends StatelessWidget {
  final String text;
  final Function onPressed;
  KtextStyle({Key key, this.text, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
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
            icon: Icon(
              EvaIcons.arrowheadRightOutline,
              color: Colors.grey,
              size: 30,
            ),
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
