import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const CustomFlatButton({Key key, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
        textColor: Colors.red,
        color: Colors.white,
        splashColor: Colors.white,
        padding: EdgeInsets.all(10),
        borderSide: BorderSide(color: Colors.white),
        highlightedBorderColor: Colors.red,
        highlightElevation: 4.0,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
        ));
  }
}
