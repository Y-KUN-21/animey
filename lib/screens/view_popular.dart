import 'package:anime/screens/detailpage.dart';
import 'package:anime/utils/constant/kSlidePageroute.dart';
import 'package:anime/utils/constant/shadermask.dart';
import 'package:flutter/material.dart';

class ViewAllPopular extends StatefulWidget {
  final List popularList;
  ViewAllPopular({this.popularList});

  @override
  _ViewAllPopularState createState() => _ViewAllPopularState();
}

class _ViewAllPopularState extends State<ViewAllPopular> {
  @override
  Widget build(BuildContext context) {
    var listdata = widget.popularList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("popular this week"),
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
