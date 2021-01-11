import 'package:anime/views/detailpage.dart';
import 'package:anime/controllers/watching_controller.dart';
import 'package:anime/widgets/ktextStyle.dart';
import 'package:anime/widgets/listviewstack.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Watching extends StatefulWidget {
  Watching({Key key}) : super(key: key);
  @override
  _WatchingState createState() => _WatchingState();
}

class _WatchingState extends State<Watching> {
  final WatchingController watchingController = Get.put(WatchingController());
  @override
  Widget build(BuildContext context) {
    watchingController.fetchWatching();
    return Container(
        height: 350,
        child: GetX<WatchingController>(builder: (controller) {
          return Column(
            children: [
              KtextStyle(
                text: " Watching",
                onPressed: null,
              ),
              Expanded(
                child: controller.watching.isEmpty
                    ? Column(
                        children: [
                          Image.asset(
                            "assets/empty.png",
                            height: MediaQuery.of(context).size.height / 6.5,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Add shows you are watching.",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )
                    : ListView.builder(
                        physics: ScrollPhysics(),
                        addRepaintBoundaries: true,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: controller.watching.length,
                        itemBuilder: (ctx, int index) {
                          var listdata = controller.watching[index];
                          var name = listdata["name"];
                          var imageUrl = listdata["imageUrl"];
                          var url = listdata["url"];
                          return ListViewAnimeCard(
                            thumbnail: imageUrl == null
                                ? CircularProgressIndicator()
                                : imageUrl,
                            tag: name.hashCode.toString(),
                            title: name,
                            onTap: () {
                              Get.to(DetailPage(
                                title: name,
                                cover: imageUrl,
                                link: url,
                                tag: name.hashCode.toString(),
                              ));
                            },
                          );
                        }),
              ),
            ],
          );
        }));
  }
}
