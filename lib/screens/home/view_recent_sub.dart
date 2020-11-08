import 'package:anime/views/detailpage.dart';
import 'package:anime/utils/constant/kSlidePageroute.dart';
import 'package:anime/utils/constant/shadermask.dart';
import 'package:flutter/material.dart';

class ViewAllRecentSub extends StatefulWidget {
  final List recentList;
  ViewAllRecentSub({this.recentList});
  @override
  _ViewAllRecentSubState createState() => _ViewAllRecentSubState();
}

class _ViewAllRecentSubState extends State<ViewAllRecentSub> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var listdata = widget.recentList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "recently subbed",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
                    crossAxisCount: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? 4
                        : 2,
                    childAspectRatio: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? 6 / 9
                        : screenSize.width / (screenSize.height / 1.4),
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
                          imagePath: listdata[index].cover,
                          onTap: () {
                            Navigator.push(
                                context,
                                SlidePageRoute(
                                    widget: DetailPage(
                                  title: listdata[index].name,
                                  cover: listdata[index].cover,
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
