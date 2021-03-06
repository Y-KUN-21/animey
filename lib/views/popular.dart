import 'package:anime/controllers/popular_controller.dart';
import 'package:anime/views/detailpage.dart';
import 'package:anime/widgets/ktextStyle.dart';
import 'package:anime/widgets/listviewstack.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularAnimes extends StatelessWidget {
  final PopularController popularController = Get.put(PopularController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: Obx(() {
        if (popularController.isLoading.value)
          return Center(child: LinearProgressIndicator());
        else
          return Column(
            children: [
              KtextStyle(
                text: " Popular",
                onPressed: null,
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  addRepaintBoundaries: true,
                  itemCount: popularController.popAnimemodel.length,
                  itemBuilder: (context, index) {
                    var listdata = popularController.popAnimemodel[index];

                    var tag = listdata.hashCode.toString();

                    return ListViewAnimeCard(
                      thumbnail: listdata.cover == null
                          ? CircularProgressIndicator()
                          : listdata.cover,
                      tag: tag,
                      title: listdata.name,
                      onTap: () {
                        Get.to(DetailPage(
                          title: listdata.name,
                          cover: listdata.cover,
                          link: listdata.url.toString(),
                          tag: tag,
                        ));
                      },
                    );
                  },
                ),
              ),
            ],
          );
      }),
    );
  }
}
