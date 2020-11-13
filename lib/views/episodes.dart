import 'package:anime/controllers/episodes_controller.dart';
import 'package:anime/views/player.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class EpisodeList extends StatefulWidget {
  final List episodeNumber, episodeURLs;
  const EpisodeList({Key key, this.episodeNumber, this.episodeURLs})
      : super(key: key);

  @override
  _EpisodeListState createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  EpisodeController episodeController = Get.put(EpisodeController());
  bool isLoading = false;
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
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: Container(
          color: Colors.transparent,
          height: 150,
          width: 150,
          child: Center(
              child: Column(children: [
            CircularProgressIndicator(),
            Text(
              "\nFetching link",
              style: TextStyle(color: Colors.white, fontSize: 15),
            )
          ])),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
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
                        setState(() {
                          isLoading = true;
                        });
                        episodeController
                            .fetchEpUrls(episodeurl)
                            .then((String videourl) {
                          setState(() {
                            isLoading = false;
                          });
                          Get.to(Player(
                            episodeLink: videourl,
                          ));
                        });
                      }),
                );
              }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    setState(() {
      isLoading = false;
    });
    super.dispose();
  }
}
