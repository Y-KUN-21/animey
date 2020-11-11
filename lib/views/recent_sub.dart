import 'package:anime/controllers/recent_controller.dart';
import 'package:anime/views/detailpage.dart';
import 'package:anime/widgets/ktextStyle.dart';
import 'package:anime/widgets/listviewstack.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentAnimes extends StatelessWidget {
  final RecentController recentController = Get.put(RecentController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: Obx(() {
        if (recentController.isLoading.value)
          return Center(child: LinearProgressIndicator());
        else
          return Column(
            children: [
              KtextStyle(
                text: " Recently updated",
                onPressed: null,
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  addRepaintBoundaries: true,
                  itemCount: recentController.recentAnimeModel.length,
                  itemBuilder: (context, index) {
                    var listdata = recentController.recentAnimeModel[index];

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
