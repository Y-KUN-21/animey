import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class KlistViewHorizontal extends StatelessWidget {
  const KlistViewHorizontal(
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
                child: ShaderMask(
                    shaderCallback: (size) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.transparent],
                      ).createShader(
                          Rect.fromLTRB(0, 0, size.width, size.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        placeholder: (context, url) => Center(
                            child: Image.network(
                                "https://cdn.iconscout.com/icon/free/png-256/page-not-found-5-530376.png")),
                        imageUrl: thumbnail,
                        fadeInCurve: Curves.bounceIn,
                        fit: BoxFit.fill,
                      ),
                    )),
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
