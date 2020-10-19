import 'package:anime/Database/DatabaseHelper.dart';
import 'package:anime/model/anime_detail_model.dart';
import 'package:anime/res/api_respo.dart';
import 'package:anime/screens/detail/episodes.dart';
import 'package:anime/utils/constant/circularbtn.dart';
import 'package:anime/utils/constant/kSlidePageroute.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final String cover;
  final String link;
  final String tag;
  DetailPage({Key key, @required this.title, this.cover, this.link, this.tag})
      : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

DatabaseHelper _databaseHelper;

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  String link;
  @override
  void initState() {
    _databaseHelper = DatabaseHelper.instance;
    setState(() {
      link = widget.link;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
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
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10)),
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? screenSize.height / 1.350
                          : screenSize.width / 1.6,
                  width:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? double.infinity
                          : screenSize.width / 1,
                  child: link == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : FutureBuilder(
                          future: ApiRepository(anime: link).getAnimeDetail,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<AnimeDetailModel>> snapshot) {
                            if (snapshot == null || snapshot.hasError) {
                              return Container(
                                child: Center(
                                  child: Text(
                                    "Something Wrong \n(${snapshot.error})\n\n\n Try searching",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.redAccent, fontSize: 15),
                                  ),
                                ),
                              );
                            } else if (snapshot.hasData) {
                              var listdata = snapshot.data[0];
                              var episodeNumber = listdata.episodeNumber;
                              var episodepage = listdata.episodes;
                              var height = screenSize.height;
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
                                              ? height / 6
                                              : height / 2),
                                      AutoSizeText(
                                        listdata.name,
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
                                        listdata.description == null
                                            ? "No description"
                                            : listdata.description,
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
                                                          episodeNumber:
                                                              episodeNumber,
                                                          episodePage:
                                                              episodepage,
                                                        )));
                                                  }),
                                              SizedBox(width: 20),
                                              KCircularBtn(
                                                icon:
                                                    Icon(EvaIcons.plusOutline),
                                                onPressed: () {
                                                  _insertWatching(
                                                      scaffoldKey,
                                                      listdata,
                                                      widget.cover,
                                                      widget.link);
                                                },
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            }
                            return Container(
                              height: 60,
                              width: 60,
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }),
                ),
              ),
              Container(
                color: Colors.transparent,
                child: Hero(
                  transitionOnUserGestures: true,
                  tag: widget.cover,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      imageUrl: widget.cover,
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

  void _snackbar(start, showname, finish) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.black54,
      elevation: 5.0,
      content: RichText(
        text: TextSpan(
            text: start,
            style: TextStyle(color: Colors.grey),
            children: <TextSpan>[
              TextSpan(
                  text: showname,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red)),
              TextSpan(
                  text: finish,
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.grey))
            ]),
      ),
      duration: Duration(seconds: 2),
    ));
  }

  void _insertWatching(key, listdata, String cover, String url) async {
    try {
      Map<String, dynamic> row = {
        _databaseHelper.pkey: url.hashCode,
        _databaseHelper.name: listdata.name,
        _databaseHelper.status: listdata.status,
        _databaseHelper.season: listdata.season,
        _databaseHelper.imageUrl: cover,
        _databaseHelper.url: url
      };
      print(url.hashCode.toString());
      await _databaseHelper.insertWatching(row);
      _snackbar("Added ", listdata.name, " in your watching list");
      setState(() {});
    } on DatabaseException {
      _snackbar("Already added ", listdata.name, " in your watching list.");
      print(url.hashCode.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
