import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:anime/screens/player.dart';
import 'package:dio/dio.dart';

class Episodes extends StatefulWidget {
  final List episodeNumber, episodePage;
  Episodes({this.episodeNumber, this.episodePage});
  @override
  _EpisodesState createState() => _EpisodesState();
}

String url;
bool isLoading = false;
String status = "fetching link...";

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
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          progressIndicator: Container(
            height: 150,
            width: 150,
            child: Center(
                child: Column(children: [
              CircularProgressIndicator(),
              AutoSizeText(
                "Fetching link...",
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
                        ? 10
                        : 5,
                    childAspectRatio: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? 5 / 5
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
                                MaterialPageRoute(
                                    builder: (context) => Player(
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
    String url =
        "https://goanimey.herokuapp.com/api/video?episode=$episodePage";
    print(url);
    Response response = await Dio().get(url);
    if (response.statusCode != 200) {
      setState(() {
        status = "something went wrong\n ${response.statusMessage}";
      });
    }
    final List rawData = await jsonDecode(jsonEncode(response.data).toString());
    print(rawData);
    var urls = rawData[0];
    print(urls);
    if (urls["url"] != null) {
      setState(() {
        isLoading = false;
      });
      return url = urls["url"];
    } else if (urls["url0"] != null) {
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
    return url = urls["url1"];
  }

  @override
  void dispose() {
    setState(() {
      isLoading = false;
    });
    super.dispose();
  }
}
