import 'package:anime/screens/detail/detailpage.dart';
import 'package:anime/model/popular.dart';
import 'package:anime/res/api_respo.dart';
import 'package:anime/screens/home/view_popular.dart';
import 'package:anime/utils/constant/kSlidePageroute.dart';
import 'package:anime/utils/constant/ktextStyle.dart';
import 'package:anime/utils/constant/listViewhztl.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class PopularAnimes extends StatefulWidget {
  @override
  _PopularAnimesState createState() => _PopularAnimesState();
}

class _PopularAnimesState extends State<PopularAnimes> {
  ApiRepository _apiRepository = ApiRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _apiRepository.getPopularAnime,
        builder: (BuildContext context,
            AsyncSnapshot<List<PopularAnimeModel>> snapshot) {
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
                return Container(
                  height: 300,
                  child: Center(
                    child: Text(
                      "Something went Wrong",
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              } else {
                return Column(
                  children: [
                    KtextStyle(
                      text: " Popular",
                      icon: Icon(EvaIcons.arrowheadRightOutline),
                      onPressed: () {
                        Navigator.push(
                            context,
                            SlidePageRoute(
                                widget: ViewAllPopular(
                              popularList: snapshot.data,
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
                            thumbnail: snapshot.data[index].cover == null
                                ? CircularProgressIndicator()
                                : listdata.cover,
                            tag: tag,
                            title: listdata.name,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  SlidePageRoute(
                                      widget: DetailPage(
                                    title: listdata.name,
                                    cover: listdata.cover,
                                    link: listdata.url.toString(),
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
