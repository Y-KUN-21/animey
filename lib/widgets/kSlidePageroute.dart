import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder {
  final Widget widget;

  SlidePageRoute({this.widget})
      : super(
          transitionDuration: Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            Animation<Offset> custom =
                Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                    .animate(animation);

            return SlideTransition(
              position: custom,
              child: child,
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) => widget,
        );
}
