import 'package:anime/controllers/detail_controller.dart';
import 'package:anime/views/episodes.dart';
import 'package:anime/widgets/anime_card_image.dart';
import 'package:anime/widgets/autosizetext.dart';
import 'package:anime/widgets/flatbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPage extends StatelessWidget {
  final String title;
  final String cover;
  final String link;
  final String tag;
  const DetailPage({Key key, this.title, this.cover, this.link, this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        body: link == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Center(
                  child: Stack(
                    alignment: Alignment.topLeft,
                    textDirection: TextDirection.ltr,
                    children: [
                      Container(
                        height: height / 1.5,
                        width: width,
                        child: AnimeCardImage(imageUrl: cover),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                      ),
                      Container(
                          child: GetBuilder<DetailController>(
                              init: DetailController(link),
                              builder: (controller) {
                                if (controller.isLoading.value)
                                  return Container(
                                      margin: EdgeInsets.only(top: 680),
                                      child: Center(
                                          child: LinearProgressIndicator()));
                                else
                                  return Container(
                                    margin: EdgeInsets.only(
                                        top: height / 1.55,
                                        left: 20,
                                        right: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomAutoSizeText(
                                          text: controller
                                                  .detailAnimeModel[0].name ??
                                              "unknown",
                                          maxLines: 2,
                                          fontSize: 30,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          textAlign: TextAlign.left,
                                          letterSpacing: 3,
                                        ),
                                        SizedBox(height: 10),
                                        CustomAutoSizeText(
                                          text: "🏷️" +
                                                  controller
                                                      .detailAnimeModel[0].tags
                                                      .toString() ??
                                              "No tags",
                                          maxLines: 2,
                                          fontSize: 15,
                                          textAlign: TextAlign.left,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(height: 10),
                                        CustomAutoSizeText(
                                          text: "📜" +
                                                  controller.detailAnimeModel[0]
                                                      .description ??
                                              "No description",
                                          maxLines: 6,
                                          fontSize: 20,
                                          textAlign: TextAlign.left,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          letterSpacing: 2,
                                        ),
                                        SizedBox(height: 10),
                                        CustomAutoSizeText(
                                          text:
                                              "Episodes ${controller.detailAnimeModel[0].episodeNumber.length}",
                                          maxLines: 1,
                                          fontSize: 20,
                                          textAlign: TextAlign.left,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          letterSpacing: 2,
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            CustomFlatButton(
                                              text: "Watch",
                                              onPressed: () {
                                                Get.to(EpisodeList(
                                                  episodeNumber: controller
                                                      .detailAnimeModel[0]
                                                      .episodeNumber,
                                                  episodeURLs: controller
                                                      .detailAnimeModel[0]
                                                      .episodeUrLs,
                                                ));
                                              },
                                            ),
                                            SizedBox(width: 10),
                                            CustomFlatButton(
                                                text: "Add",
                                                onPressed: () {
                                                  controller.insertWatching(
                                                    controller
                                                        .detailAnimeModel[0],
                                                    link,
                                                    cover,
                                                  );
                                                }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                              })),
                    ],
                  ),
                ),
              ));
  }
}
