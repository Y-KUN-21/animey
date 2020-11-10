import 'package:anime/controllers/recent_controller.dart';
import 'package:anime/views/detailpage.dart';
import 'package:anime/widgets/listview_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentAnimes extends StatelessWidget {
  final RecentController recentController = Get.put(RecentController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Obx(() {
        if (recentController.isLoading.value)
          return Center(child: CircularProgressIndicator());
        else
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            addRepaintBoundaries: true,
            itemCount: recentController.recentAnimeModel.length,
            itemBuilder: (context, index) {
              var listdata = recentController.recentAnimeModel[index];
              var tag = listdata.hashCode.toString();
              return KlistViewHorizontal(
                thumbnail: listdata.cover == null
                    ? CircularProgressIndicator()
                    : listdata.cover,
                tag: tag,
                title: listdata.name,
                onTap: () {
                  Get.to(DetailPage(
                    title: listdata.name,
                    cover: listdata.cover,
                    link: listdata.url.toString() ?? null,
                    tag: tag,
                  ));
                },
              );
            },
          );
      }),
    );
  }
}
