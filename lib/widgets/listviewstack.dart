import 'package:anime/widgets/anime_card_image.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ListViewAnimeCard extends StatelessWidget {
  const ListViewAnimeCard(
      {Key key, @required this.thumbnail, this.title, this.tag, this.onTap})
      : super(key: key);
  final String thumbnail;
  final String tag;
  final Function onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: tag,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10)),
              child: Card(
                  color: Colors.grey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5.0,
                  child: AnimeCardImage(
                    imageUrl: thumbnail,
                    blendMode: BlendMode.dstOut,
                  )),
              width: 200,
              height: 400,
            ),
          ),
        ),
        Container(
          width: 200,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(35, 190, 35, 5),
            child: AutoSizeText(
              title,
              maxFontSize: 18,
              minFontSize: 15,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                color: Colors.white,
              ),
            ),
          )),
        )
      ],
    );
  }
}
