import 'package:anime/controllers/detail_controller.dart';
import 'package:anime/screens/detail/episodes.dart';
import 'package:anime/utils/constant/circularbtn.dart';
import 'package:anime/utils/constant/kSlidePageroute.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
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
      appBar: AppBar(
        iconTheme: IconTheme.of(context),
        title: Text("About"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black12
                            : Colors.grey[900],
                        borderRadius: BorderRadius.circular(10)),
                    height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? screenSize.height / 1.350
                        : screenSize.width / 1.6,
                    width: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? double.infinity
                        : screenSize.width / 1,
                    child: link == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : GetBuilder<DetailController>(
                            init: DetailController(link),
                            builder: (controller) {
                              if (controller.isLoading.value)
                                return Center(
                                    child: CircularProgressIndicator());
                              else
                                print(controller.detailAnimeModel[0].name);
                              return Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait
                                              ? screenSize.height / 6
                                              : screenSize.height / 2),
                                      AutoSizeText(
                                        controller.detailAnimeModel[0].name,
                                        maxFontSize: 20,
                                        minFontSize: 15,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      AutoSizeText(
                                        controller.detailAnimeModel[0]
                                                    .description ==
                                                null
                                            ? "No description"
                                            : controller.detailAnimeModel[0]
                                                .description,
                                        maxLines: 6,
                                        maxFontSize: 18,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        minFontSize: 15,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              KCircularBtn(
                                                  icon: Icon(EvaIcons
                                                      .playCircleOutline),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        SlidePageRoute(
                                                            widget: Episodes(
                                                          episodeNumber: controller
                                                              .detailAnimeModel[
                                                                  0]
                                                              .episodeNumber,
                                                          episodePage: controller
                                                              .detailAnimeModel[
                                                                  0]
                                                              .episodes,
                                                        )));
                                                  }),
                                              SizedBox(width: 20),
                                              KCircularBtn(
                                                icon:
                                                    Icon(EvaIcons.plusOutline),
                                                onPressed: () {
                                                  controller.insertWatching(
                                                    controller
                                                        .detailAnimeModel[0],
                                                    link,
                                                    cover,
                                                  );
                                                },
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            })),
              ),
              Container(
                color: Colors.transparent,
                child: Hero(
                  transitionOnUserGestures: true,
                  tag: cover,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      imageUrl: cover,
                      fadeInCurve: Curves.bounceIn,
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? screenSize.height / 1.3
                          : screenSize.height / 2.7,
                      width: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? screenSize.width / 3.2
                          : screenSize.width / 2,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
