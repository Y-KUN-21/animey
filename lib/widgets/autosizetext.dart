import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomAutoSizeText extends StatelessWidget {
  final String text;
  final String fontfamily;
  final FontWeight fontWeight;
  final int maxLines;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;

  const CustomAutoSizeText(
      {Key key,
      this.text,
      this.fontfamily,
      this.fontWeight,
      this.maxLines,
      this.fontSize,
      this.color,
      this.textAlign})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      maxLines: maxLines,
      maxFontSize: fontSize,
      minFontSize: fontSize - 5,
      textAlign: textAlign ?? TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: fontfamily ?? "Montserrat",
        color: color == null
            ? Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black
            : color,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}
