import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class KlistViewVertical extends StatelessWidget {
  final int tag;
  final String year;
  final String season;
  final String status;
  final String name;
  final String imageUrl;
  final Function onTap;
  KlistViewVertical(
      {Key key,
      this.year,
      this.name,
      this.tag,
      this.imageUrl,
      this.onTap,
      this.season,
      this.status})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                          tag: imageUrl,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AutoSizeText(
                            name,
                            maxLines: 3,
                            textAlign: TextAlign.left,
                            minFontSize: 15,
                            maxFontSize: 20,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Column(
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    infoText("Status"),
                                    infoText(status)
                                  ]),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    infoText("Season"),
                                    infoText(season)
                                  ]),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [infoText("Year"), infoText(year)]),
                            ],
                          )
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

  Widget infoText(text) {
    return AutoSizeText(
      text == null ? "Unknown" : text,
      maxLines: 1,
      textAlign: TextAlign.left,
      minFontSize: 10,
      maxFontSize: 15,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
    );
  }
}
