import 'package:anime/screens/detailpage.dart';
import 'package:anime/model/recent_sub.dart';
import 'package:anime/res/api_respo.dart';
import 'package:anime/utils/constant/kSlidePageroute.dart';
import 'package:anime/utils/constant/ktextStyle.dart';
import 'package:anime/utils/constant/listViewhztl.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:anime/screens/view_recent.dart';

class RecentSubAnimes extends StatefulWidget {
  @override
  _RecentSubAnimesState createState() => _RecentSubAnimesState();
}

ApiRepository _apiRepository = ApiRepository();

class _RecentSubAnimesState extends State<RecentSubAnimes> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _apiRepository.getRecentSubbed,
        builder: (BuildContext context,
            AsyncSnapshot<List<RecentAnimeModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container(
                height: 300,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
              break;
            case ConnectionState.waiting:
              return Container(
                height: 300,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
              break;
            case ConnectionState.active:
              return Container(
                height: 300,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                print("An error has occurred: ${snapshot.error}");
                return Container(
                  height: 300,
                  child: Center(
                    child: Text(
                      "Something Wrong",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              } else {
                return Column(
                  children: [
                    KtextStyle(
                      text: " Recent",
                      icon: Icon(EvaIcons.arrowheadRightOutline),
                      onPressed: () {
                        Navigator.push(
                            context,
                            SlidePageRoute(
                                widget: ViewAllRecent(
                              recentList: snapshot.data,
                            )));
                      },
                    ),
                    Container(
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          var listdata = snapshot.data[index];
                          var tag = listdata.hashCode.toString();
                          return KlistViewHorizontal(
                            thumbnail: snapshot.data[index].imageUrl == null
                                ? CircularProgressIndicator()
                                : listdata.imageUrl,
                            tag: tag,
                            title: listdata.name,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  SlidePageRoute(
                                      widget: DetailPage(
                                    title: listdata.name,
                                    cover: listdata.imageUrl,
                                    link: listdata.url,
                                    tag: tag,
                                  )));
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              break;
          }
          return Container();
        });
  }
}
