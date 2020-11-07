import 'package:anime/Database/DatabaseHelper.dart';
import 'package:anime/screens/detail/detailpage.dart';
import 'package:anime/utils/constant/kSlidePageroute.dart';
import 'package:anime/utils/constant/listViewhztl.dart';
import 'package:flutter/material.dart';

class Watching extends StatefulWidget {
  Watching({Key key}) : super(key: key);
  @override
  _WatchingState createState() => _WatchingState();
}

class _WatchingState extends State<Watching> {
  DatabaseHelper _databaseHelper;
  Future watching;
  @override
  void initState() {
    _databaseHelper = DatabaseHelper.instance;
    refreshData();
    setState(() {});
    super.initState();
  }

  void refreshData() {
    setState(() {
      watching = _databaseHelper.queryAllWatching();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _databaseHelper.queryAllWatching(),
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("Add shows");
            break;
          case ConnectionState.active:
            return Text("Add shows");
            break;
          case ConnectionState.waiting:
            return Text("Add shows");
            break;
          case ConnectionState.done:
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Add shows"),
                ),
              );
            }
            var length = snapshot.data.length;
            return ListView.builder(
                physics: ScrollPhysics(),
                addRepaintBoundaries: true,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: length,
                itemBuilder: (ctx, int index) {
                  var listdata = snapshot.data[index];
                  var name = listdata["name"];
                  var imageUrl = listdata["imageUrl"];
                  var url = listdata["url"];

                  return KlistViewHorizontal(
                    thumbnail: imageUrl == null
                        ? CircularProgressIndicator()
                        : imageUrl,
                    tag: name.hashCode.toString(),
                    title: name,
                    onTap: () {
                      Navigator.push(
                          context,
                          SlidePageRoute(
                              widget: DetailPage(
                            title: name,
                            cover: imageUrl,
                            link: url,
                            tag: name.hashCode.toString(),
                          )));
                    },
                  );
                });
            break;
          default:
        }
        return Container();
      },
    );
  }

  @override
  void dispose() {
    _databaseHelper.close();
    super.dispose();
  }
}
