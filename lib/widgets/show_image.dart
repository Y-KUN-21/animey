import 'package:anime/widgets/anime_card_image.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  final String imagePath;
  final Function onTap;
  final String title;

  ShowImage({this.imagePath, this.onTap, this.title});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Card(
            color: Colors.grey[800],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5.0,
            child: Container(
              child: AnimeCardImage(
                imageUrl: imagePath,
                blendMode: BlendMode.dstOut,
              ),
              width: 200,
              height: 290,
            ),
          ),
        ),
        Container(
          width: 200,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(35, 200, 35, 5),
            child: AutoSizeText(
              title,
              maxFontSize: 20,
              minFontSize: 11,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 20, color: Colors.grey[300]),
            ),
          )),
        )
      ],
    );
  }
}
