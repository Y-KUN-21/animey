import 'package:anime/controllers/episodes_controller.dart';
import 'package:anime/screens/detail/player.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EpisodeList extends StatefulWidget {
  final List episodeNumber, episodeURLs;
  const EpisodeList({Key key, this.episodeNumber, this.episodeURLs})
      : super(key: key);

  @override
  _EpisodeListState createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  EpisodeController episodeController = Get.put(EpisodeController());
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconTheme.of(context),
        title: Text(
          "Episodes",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
        child: GridView.builder(
            itemCount: widget.episodeNumber.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: orientation == Orientation.landscape ? 8 : 5,
              childAspectRatio: orientation == Orientation.landscape
                  ? 6 / 4
                  : width / (height / 2.8),
            ),
            itemBuilder: (BuildContext context, int index) {
              var episodenum = widget.episodeNumber[index];
              var episodeurl = widget.episodeURLs[index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: OutlineButton(
                    textColor: Colors.red,
                    color: Colors.white,
                    splashColor: Colors.white,
                    padding: EdgeInsets.all(10),
                    borderSide: BorderSide(color: Colors.red),
                    highlightedBorderColor: Colors.red,
                    highlightElevation: 4.0,
                    child: Center(
                      child: Text(
                        "EP " + episodenum.toString(),
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0)),
                    onPressed: () {
                      episodeController
                          .fetchEpUrls(episodeurl)
                          .then((String videourl) {
                        Get.to(Player(
                          episodeLink: videourl,
                        ));
                      });
                    }),
              );
            }),
      ),
    );
  }
}
