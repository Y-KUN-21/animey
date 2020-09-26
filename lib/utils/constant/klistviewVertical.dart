import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class KlistViewVertical extends StatelessWidget {
  final Function onTap;
  final String tag;
  final String imageUrl;
  final String year;
  final String status;
  final String season;
  final String title;
  KlistViewVertical(
      {Key key,
      this.onTap,
      this.year,
      this.imageUrl,
      this.season,
      this.title,
      this.status,
      this.tag})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color rightColor = Colors.white;

    Color leftColor = Colors.white30;

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onTap,
          child: Container(
              height: 170,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      height: 175,
                      width: 130,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Hero(
                          tag: tag,
                          child: CachedNetworkImage(
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            fit: BoxFit.fill,
                            imageUrl: imageUrl,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            title,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            minFontSize: 15,
                            maxFontSize: 15,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: rightColor, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Year",
                                style: TextStyle(
                                    color: leftColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(year,
                                  style: TextStyle(
                                      color: rightColor,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Season",
                                style: TextStyle(
                                    color: leftColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(season,
                                  style: TextStyle(
                                      color: rightColor,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Status",
                                style: TextStyle(
                                    color: leftColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(status,
                                  style: TextStyle(
                                      color: rightColor,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
