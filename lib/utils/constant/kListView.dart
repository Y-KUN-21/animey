import 'package:anime/utils/constant/shadermask.dart';
import 'package:flutter/material.dart';

class KListView extends StatelessWidget {
  const KListView(
      {Key key,
      this.itemcount,
      this.onTap,
      @required this.imagePath,
      this.title})
      : super(key: key);
  final String imagePath;
  final Function onTap;
  final int itemcount;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          height: MediaQuery.of(context).orientation == Orientation.landscape
              ? 300
              : 300,
          child: ListView.builder(
              itemCount: itemcount,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return ShowImage(
                  imagePath: imagePath,
                  onTap: onTap,
                  title: title,
                );
              }),
        ),
      ),
    );
  }
}
