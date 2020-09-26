import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
              child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(
                        Rect.fromLTRB(0, 80, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      fit: BoxFit.fill,
                      imageUrl: imagePath,
                    ),
                  )),
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
