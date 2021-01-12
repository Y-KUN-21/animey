import 'package:anime/controllers/searched_controller.dart';
import 'package:anime/views/detailpage.dart';
import 'package:anime/widgets/search_listview.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchAnime extends StatefulWidget {
  @override
  _SearchAnimeState createState() => _SearchAnimeState();
}

TextEditingController _controller = TextEditingController();
String anime;

class _SearchAnimeState extends State<SearchAnime> {
  final SearchController searchController = Get.put(SearchController());
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
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: _searchFuture(),
      ),
    );
  }

  Widget _searchBar() {
    return TextField(
        onSubmitted: (String query) {
          setState(() {
            anime = query;
          });
          searchController.fetchSearch(anime);
        },
        style: TextStyle(color: Colors.black),
        textAlign: TextAlign.left,
        autofocus: true,
        controller: _controller,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.grey[600]),
          suffixIcon: IconButton(
            onPressed: () => searchController.fetchSearch(anime),
            icon: Icon(
              EvaIcons.searchOutline,
              color: Colors.red,
            ),
          ),
          isDense: true,
          hintText: "Search",
          contentPadding: new EdgeInsets.all(8.0),
          fillColor: Colors.grey[200],
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 0.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 1.0, color: Colors.red)),
        ));
  }

  Widget _searchFuture() {
    return Container(
        color: Colors.black,
        child: Obx(() {
          if (searchController.isLoading.value)
            return Center(
                child: Center(
              child: CircularProgressIndicator(),
            ));
          else {
            return ListView.builder(
                itemCount: searchController.searchAnimeModel.length,
                itemBuilder: (ctx, int index) {
                  var listdata = searchController.searchAnimeModel[index];
                  return SearchListView(
                    name: listdata.name,
                    year: listdata.year,
                    season: listdata.season,
                    status: listdata.status,
                    imageUrl: listdata.cover,
                    tag: listdata.name.hashCode,
                    onTap: () {
                      Get.to(
                          DetailPage(
                            title: listdata.name,
                            cover: listdata.cover,
                            link: listdata.url,
                            tag: listdata.name.hashCode.toString(),
                          ),
                          transition: Transition.rightToLeft);
                    },
                  );
                });
          }
        }));
  }

  @override
  void dispose() {
    _controller.clear();
    _SearchAnimeState()._searchFuture();
    super.dispose();
  }
}
