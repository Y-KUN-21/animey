import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class Player extends StatefulWidget {
  final String episodeLink;
  Player({@required this.episodeLink});
  @override
  _PlayerState createState() => _PlayerState();
}

String videoLink;

class _PlayerState extends State<Player> {
  VideoPlayerController _playerController;
  ChewieController _chewieController;

  void initPlayer() async {
    _playerController = VideoPlayerController.network(videoLink);

    _chewieController = ChewieController(
      videoPlayerController: _playerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: false,
      allowMuting: true,
      allowedScreenSleep: true,
      autoInitialize: false,
      showControlsOnInitialize: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.grey,
        handleColor: Colors.red,
        backgroundColor: Colors.black,
        bufferedColor: Colors.redAccent,
      ),
    );
  }

  @override
  void initState() {
    _playerController.addListener(checkVideo);
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    setState(() {
      videoLink = widget.episodeLink;
    });
    initPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return widget.episodeLink == null
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            body: Center(
            child: Chewie(
              controller: _chewieController,
            ),
          ));
  }

  void checkVideo() {
    // Implement your calls inside these conditions' bodies :
    if (_playerController.value.position ==
        Duration(seconds: 0, minutes: 0, hours: 0)) {
      print('video Started');
    }

    if (_playerController.value.position == _playerController.value.duration) {
      print('video Ended');
    }
    @override
    void dispose() {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      _playerController.dispose();
      _chewieController.dispose();
      super.dispose();
    }
  }
}
