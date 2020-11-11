import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';

class Player extends StatefulWidget {
  final String episodeLink;
  Player({@required this.episodeLink});
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  FlickManager flickManager;
  String url;
  @override
  void initState() {
    setState(() {
      url = widget.episodeLink;
      super.initState();
    });

    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(url),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return widget.episodeLink == null
        ? Center(child: CircularProgressIndicator())
        : Container(
            child: FlickVideoPlayer(preferredDeviceOrientation: [
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ], flickManager: flickManager),
          );
  }
}
