import 'package:anime/screens/detailpage.dart';
import 'package:anime/utils/constant/kSlidePageroute.dart';
import 'package:anime/utils/constant/shadermask.dart';
import 'package:flutter/material.dart';

class ViewAllRecent extends StatefulWidget {
  final List recentList;
  ViewAllRecent({this.recentList});
  @override
  _ViewAllRecentState createState() => _ViewAllRecentState();
}

class _ViewAllRecentState extends State<ViewAllRecent> {
  @override
  Widget build(BuildContext context) {
    var listdata = widget.recentList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("recently subbed anime"),
        elevation: 0.0,
      ),
      body: listdata == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: GridView.builder(
                  itemCount: listdata.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 4.2 / 6,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5.0,
                      child: Container(
                        child: ShowImage(
                          title: listdata[index].name,
                          imagePath: listdata[index].imageUrl,
                          onTap: () {
                            Navigator.push(
                                context,
                                SlidePageRoute(
                                    widget: DetailPage(
                                  title: listdata[index].name,
                                  cover: listdata[index].imageUrl,
                                  link: listdata[index].url,
                                  tag: listdata[index].name.hashCode.toString(),
                                )));
                          },
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}
