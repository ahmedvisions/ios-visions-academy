import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VidPlayer extends StatefulWidget {
  final video;

  const VidPlayer({
    Key key,
    this.video,
  }) : super(key: key);
  @override
  _VidPlayerState createState() => _VidPlayerState();
}

class _VidPlayerState extends State<VidPlayer> {
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;
  initializeVideo() {
    videoPlayerController =
        VideoPlayerController.network(widget.video.videoUrl);
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        allowMuting: true,
        allowedScreenSleep: false,
        looping: false);
  }

  @override
  void initState() {
    initializeVideo();
    // VideoPlayerController.network(widget.imageString);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final playerWidget = Chewie(
      controller: chewieController,
    );
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: [
              playerWidget,
            ],
          ),
        ),
      ),
    );
  }
}
