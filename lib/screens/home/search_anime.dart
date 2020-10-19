import 'package:anime/screens/detail/detailpage.dart';
import 'package:anime/model/searched_anime_model.dart';
import 'package:anime/res/api_respo.dart';
import 'package:anime/utils/constant/kSlidePageroute.dart';
import 'package:anime/utils/constant/klistviewDb.dart';
import 'package:anime/utils/constant/ktextStyle.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class SearchAnime extends StatefulWidget {
  @override
  _SearchAnimeState createState() => _SearchAnimeState();
}

TextEditingController _controller = TextEditingController();
String anime;

class _SearchAnimeState extends State<SearchAnime> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _searchBar(),
        iconTheme: IconTheme.of(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: _searchFuture(),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white30
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
          onSubmitted: (String query) {
            setState(() {
              anime = query;
            });
            _searchFuture();
          },
          textAlign: TextAlign.left,
          autofocus: true,
          controller: _controller,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              suffixIcon: Icon(EvaIcons.searchOutline),
              isDense: true,
              hintText: " Search",
              fillColor: Colors.white,
              border: InputBorder.none)),
    );
  }

  Widget _searchFuture() {
    return anime == null
        ? Center(
            child: Text(
              "Enter something",
            ),
          )
        : FutureBuilder(
            future: ApiRepository(search: anime).getSearchedAnime,
            builder: (BuildContext context,
                AsyncSnapshot<List<SearchedAnimeModel>> snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.active) {
                return Container(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasData) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (ctx, int index) {
                          var listdata = snapshot.data[index];
                          return KlistViewVertical(
                            name: listdata.name,
                            year: listdata.year,
                            season: listdata.season,
                            status: listdata.status,
                            imageUrl: listdata.cover,
                            tag: listdata.name.hashCode,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  SlidePageRoute(
                                      widget: DetailPage(
                                    title: listdata.name,
                                    cover: listdata.cover,
                                    link: listdata.url,
                                    tag: listdata.name.hashCode.toString(),
                                  )));
                            },
                          );
                        }));
              }
              return Container(
                child: Center(
                    child: Center(
                  child: KtextStyle(
                    text: "Enter something",
                  ),
                )),
              );
            });
  }

  @override
  void dispose() {
    _controller.clear();
    _SearchAnimeState()._searchFuture();
    super.dispose();
  }
}
