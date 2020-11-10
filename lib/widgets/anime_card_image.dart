import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AnimeCardImage extends StatelessWidget {
  final String imageUrl;
  final BlendMode blendMode;
  const AnimeCardImage({Key key, this.imageUrl, this.blendMode})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (size) {
          return LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black, Colors.transparent],
          ).createShader(Rect.fromLTRB(0, 0, size.width, size.height));
        },
        blendMode: blendMode ?? BlendMode.darken,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            errorWidget: (context, url, error) =>
                Image.asset("assets/error.png"),
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            imageUrl: imageUrl,
            fadeInCurve: Curves.bounceIn,
            fit: BoxFit.fill,
          ),
        ));
  }
}
