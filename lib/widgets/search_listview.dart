import 'package:anime/widgets/autosizetext.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SearchListView extends StatelessWidget {
  final int tag;
  final String year;
  final String season;
  final String status;
  final String name;
  final String imageUrl;
  final Function onTap;
  SearchListView(
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
    var width = MediaQuery.of(context).size.width;
    return InkWell(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 140, right: 10),
              child: Container(
                width: width,
                height: 150,
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[800]
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 5, 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAutoSizeText(
                        text: name,
                        maxLines: 2,
                        fontSize: 22,
                        textAlign: TextAlign.left,
                        fontWeight: FontWeight.bold,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          infoText(status),
                          infoText(season),
                          infoText(year)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Hero(
                    tag: imageUrl,
                    child: CachedNetworkImage(
                      width: 140,
                      height: 180,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      fit: BoxFit.fill,
                      imageUrl: imageUrl,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget infoText(text) {
    return AutoSizeText(
      text == null ? "Unknown" : text,
      maxLines: 1,
      textAlign: TextAlign.right,
      minFontSize: 15,
      maxFontSize: 18,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
    );
  }
}
