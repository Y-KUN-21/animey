import 'dart:convert';
import 'package:anime/screens/detail/player.dart';
import 'package:anime/utils/constant/kSlidePageroute.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Episodes extends StatefulWidget {
  final List episodeNumber, episodePage;
  Episodes({this.episodeNumber, this.episodePage});
  @override
  _EpisodesState createState() => _EpisodesState();
}

String url;
bool isLoading = false;
String status = "Fetching link.";

class _EpisodesState extends State<Episodes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconTheme.of(context),
          title: Text(
            "episodes",
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
              AutoSizeText(
                "\nFetching link",
                style: TextStyle(color: Colors.white, fontSize: 15),
              )
            ])),
          ),
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
              child: GridView.builder(
                  itemCount: widget.episodeNumber.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? 8
                        : 5,
                    childAspectRatio: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? 6 / 4
                        : screenSize.width / (screenSize.height / 2.8),
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isLoading = true;
                          });
                          getVideo(widget.episodePage[index])
                              .then((String value) {
                            Navigator.push(
                                context,
                                SlidePageRoute(
                                    widget: Player(
                                  episodeLink: value,
                                )));
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.grey[800]), // button color
                          child: SizedBox(
                              child: Center(
                                  child: AutoSizeText(
                            "EP " + widget.episodeNumber[index].toString(),
                            minFontSize: 10,
                            maxFontSize: 20,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ))),
                        ),
                      ),
                    );
                  })),
        ));
  }

  Future<String> getVideo(String episodePage) async {
    String url = "https://animeyapi.herokuapp.com/video?episode=$episodePage";
    print(url);
    Response response = await Dio().get(url);
    if (response.statusCode != 200) {
      setState(() {
        status = "something went wrong _getVideo\n ${response.statusMessage}";
      });
    }
    final List rawData = await jsonDecode(jsonEncode(response.data).toString());
    var urls = await rawData[0];
    var result;
    if (urls['url'][0] != null) {
      setState(() {
        isLoading = false;
        result = urls["url"][0];
      });
      return result;
    } else if (urls["url"][1] != null) {
      setState(() {
        isLoading = false;
        result = urls["url"][1];
      });
      return result;
    }
    if (urls['url'][2] != null) {
      setState(() {
        isLoading = false;
      });
      result = urls["url"][2];
    }
    setState(() {
      isLoading = false;
      result = urls["url"][0];
    });
    return result;
  }

  @override
  void dispose() {
    isLoading = false;
    super.dispose();
  }
}
