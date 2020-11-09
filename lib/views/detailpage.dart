import 'package:anime/controllers/detail_controller.dart';
import 'package:anime/screens/detail/episodes.dart';
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
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Center(
            child: Stack(
              alignment: Alignment.topLeft,
              textDirection: TextDirection.ltr,
              children: [
                Container(
                  height: screenSize.height / 1.5,
                  width: screenSize.width,
                  child: AnimeCardImage(
                    imageUrl: cover,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                ),
                Container(
                    child: link == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : GetBuilder<DetailController>(
                            init: DetailController(link),
                            builder: (controller) {
                              if (controller.isLoading.value)
                                return Container(
                                    margin: EdgeInsets.only(top: 680),
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              else
                                return Container(
                                  margin: EdgeInsets.only(
                                      top: screenSize.height / 1.55,
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
                                        fontWeight: FontWeight.w900,
                                      ),
                                      SizedBox(height: 10),
                                      CustomAutoSizeText(
                                        text: controller
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
                                        text: controller.detailAnimeModel[0]
                                                .description ??
                                            "No description",
                                        maxLines: 6,
                                        fontSize: 25,
                                        textAlign: TextAlign.left,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          CustomFlatButton(
                                            text: "Watch",
                                            onPressed: () {
                                              Get.to(Episodes(
                                                episodeNumber: controller
                                                    .detailAnimeModel[0]
                                                    .episodeNumber,
                                                episodePage: controller
                                                    .detailAnimeModel[0]
                                                    .episodes,
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
